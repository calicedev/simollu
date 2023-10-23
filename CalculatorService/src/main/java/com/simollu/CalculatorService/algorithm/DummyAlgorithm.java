package com.simollu.CalculatorService.algorithm;


// 더미데이


import com.simollu.CalculatorService.dto.CreateDummyRequestDto;
import com.simollu.CalculatorService.entity.WaitingLog;
import com.simollu.CalculatorService.service.WaitingLogService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.*;


/*

더미 데이터 만들기

내일이 주말인지 여부에 따라 시간대별로 입장자수와 퇴장자수를 생성한다.
입장자수와 퇴장자수에게 입장 시간 퇴장 시간을 부여한다.
입장자는 시간이 되면 큐에 들어가고 이 때 자신의 순위를 부여받는다
퇴장자는 시간이 되면 앞에서부터 뺀다.

그렇다면 여기서 대기시간을 어떻게 구해야하는지 고민이 생긴다.

1. 입장자가 큐에 들어갈 때 앞에 있는 팀의 대기 시간에 5 ~ 7 분을 더한 것을 대기시간으로 할 것 인가
    -> 5~7분 사이의 난수로 부여

2. 입장자가 큐에 진입하는 시간(웨이팅 건 시간)에서 큐에 빠저나가는 시간(가게에 입장)을 뺀 것을 대기시간으로 할 것 인가
    -> 처음 큐에 들어간 시간 - 큐에 나간 시간

2번이 좀 더 현실감이 있지 않나..?


 */

@Component
@RequiredArgsConstructor
public class DummyAlgorithm {

    private final WaitingLogService waitingLogService;


    // 입장자
    static HashMap<LocalTime, boundary> entrance;
    // 퇴장자
    static HashMap<LocalTime, boundary> leaver;
    // 웨이팅 큐
    static Deque<waitingTeam> waitingQue;


    public void makeDummy(CreateDummyRequestDto requestDto) {

        // 동래정
        Long restaurantSeq = requestDto.getRestaurantSeq();

        // hashmap 생성
        initHashMap();

        // 큐 생성
        waitingQue = new LinkedList<>();

        // 다음날이 주말이냐 평일이냐에 따라 가중치 부여
        if (requestDto.isTomorrowIsHoliday()) {
            holidayMake();
        }
        else {
            weekdayMake();
        }

        LocalDate targetDate = requestDto.getTargetDate();

        List<timeDot> timeList = null;


        List<LocalTime> timeFlow = new ArrayList<>();
        for (LocalTime time : entrance.keySet()) {
            timeFlow.add(time);
        }
        Collections.sort(timeFlow);



        // 시간별 웨이팅 큐와 들어가는 사람과 나가는 사람 구현
        for (LocalTime time : timeFlow) {

            boundary eb = entrance.get(time);
            boundary lb = leaver.get(time);

            int enterNum = makeRandom(eb.start, eb.end); // 입장자 수
            int leaverNum = makeRandom(lb.start, lb.end); // 퇴장자 수

            // 입장자와 퇴장자 시간흐름 저장 map
            timeList = new ArrayList<>();

            // 입장팀들이 몇 시에 웨이팅을 신청했는지 생성
            for (int i = 0; i < enterNum; i++) {
                int enterTime = makeRandom(0, 29);
                timeList.add(new timeDot(enterTime, 1));
            }
            // 퇴장팀들이 몇 시에 가게에 입장했는지 생성
            for (int i = 0; i < leaverNum; i++) {
                int leaverTime = makeRandom(0, 29);
                timeList.add(new timeDot(leaverTime, 2));
            }

            Collections.sort(timeList);


//            System.out.println();
//            for (timeDot data : timeList) {
//                System.out.println(data.time);
//            }
//            System.out.println();


            for (timeDot data : timeList) {

                // waiting 신청인 경우
                if(data.type == 1) {
                    int rank = waitingQue.size() + 1;
                    LocalTime requestTime = time.plusMinutes(data.time);
                    waitingQue.add(new waitingTeam(rank, requestTime));
                }
                // 대기순위 1위 가게 입장
                else {

                    if(waitingQue.isEmpty()) {
                        continue;
                    }

                    waitingTeam waitingTeam = waitingQue.pollFirst();

                    if (waitingTeam == null) {
                        continue;
                    }

                    int people = makeRandom(2, 6);
                    int rank = waitingTeam.waitingRank;
                    LocalTime startTime = waitingTeam.startTime;
                    LocalDateTime startDate = LocalDateTime.of(targetDate, startTime);

                    LocalTime endTime = time.plusMinutes(data.time);
                    LocalDateTime endDate = LocalDateTime.of(targetDate, endTime);

                    long waitingTime = Duration.between(startTime, endTime).toMinutes();


                    WaitingLog sample = WaitingLog.builder()
                            .restaurantSeq(restaurantSeq)
                            .waitingPersonCnt(people)
                            .waitingLogRank(rank)
                            .waitingLogTime(waitingTime)
                            .waitingStatusRegistDate(startDate)
                            .waitingStatusEntranceDate(endDate)
                            .build();

                    waitingLogService.insertWaitingLog(sample);


                }

            }






        }

    }




    // 웨이팅 신청을 눌렀을 때 시간
    public static class waitingTeam {
        int waitingRank; // 웨이팅 신청 시점에 순위
        LocalTime startTime; // 웨이팅 신청 시간

        waitingTeam(int waitingRank, LocalTime startTime) {
            this.waitingRank = waitingRank;
            this.startTime = startTime;
        }
    }


    // 시간 흐름에 따라 입장자와 퇴장자를 나열하기 위한 class
    public static class timeDot implements Comparable<timeDot> {
        int time;
        int type; // 1 입장 2 퇴장

        timeDot(int time, int type) {
            this.time = time;
            this.type = type;
        }

        @Override
        public int compareTo(timeDot o) {
            return this.time - o.time;
        }
    }

    public static class boundary {
        int start;
        int end;

        boundary(int start, int end) {
            this.start = start;
            this.end = end;
        }
    }


    // 난수를 발생해주는 함수
    public int makeRandom(int start, int end) {
        Random random = new Random();

        if (start > end) {
            throw new IllegalArgumentException("Start value must be smaller than or equal to the end value.");
        }

        int range = end - start + 1;
        return start + random.nextInt(range);
    }


    // 가중치 생성
    public void initHashMap() {
        entrance = new HashMap<>();
        leaver = new HashMap<>();
    }

    // 가중치 부여


    // 평일
    public void weekdayMake() {

        // 점심 시간
        entrance.put(LocalTime.of(11,00), new boundary(1, 2));
        entrance.put(LocalTime.of(11,30), new boundary(1, 2));
        entrance.put(LocalTime.of(12,00), new boundary(1, 2));
        entrance.put(LocalTime.of(12,30), new boundary(1, 2));
        entrance.put(LocalTime.of(13,00), new boundary(4, 6));
        entrance.put(LocalTime.of(13,30), new boundary(2, 3));
        entrance.put(LocalTime.of(14,00), new boundary(0, 0));



        entrance.put(LocalTime.of(16,00), new boundary(0, 0));
        entrance.put(LocalTime.of(16,30), new boundary(0, 0));
        entrance.put(LocalTime.of(17,00), new boundary(0, 0));
        entrance.put(LocalTime.of(17,30), new boundary(3, 5));
        entrance.put(LocalTime.of(18,00), new boundary(24, 30));
        entrance.put(LocalTime.of(18,30), new boundary(8, 14));
        entrance.put(LocalTime.of(19,00), new boundary(6, 10));
        entrance.put(LocalTime.of(19,30), new boundary(3, 6));
        entrance.put(LocalTime.of(20,00), new boundary(1, 3));
        entrance.put(LocalTime.of(20,30), new boundary(0, 0));
        entrance.put(LocalTime.of(21,00), new boundary(0, 0));
        entrance.put(LocalTime.of(21,30), new boundary(0, 0));
        entrance.put(LocalTime.of(22,00), new boundary(0, 0));



        // 점심
        leaver.put(LocalTime.of(11,00), new boundary(0, 0));
        leaver.put(LocalTime.of(11,30), new boundary(0, 0));
        leaver.put(LocalTime.of(12,00), new boundary(2, 3));
        leaver.put(LocalTime.of(12,30), new boundary(2, 3));
        leaver.put(LocalTime.of(13,00), new boundary(6, 12));
        leaver.put(LocalTime.of(13,30), new boundary(6, 12));
        leaver.put(LocalTime.of(14,00), new boundary(6, 12));

        leaver.put(LocalTime.of(16,00), new boundary(0, 0));
        leaver.put(LocalTime.of(16,30), new boundary(0, 0));
        leaver.put(LocalTime.of(17,00), new boundary(0, 0));
        leaver.put(LocalTime.of(17,30), new boundary(15, 18));
        leaver.put(LocalTime.of(18,00), new boundary(10, 12));
        leaver.put(LocalTime.of(18,30), new boundary(6, 8));
        leaver.put(LocalTime.of(19,00), new boundary(8, 10));
        leaver.put(LocalTime.of(19,30), new boundary(10, 12));
        leaver.put(LocalTime.of(20,00), new boundary(10, 12));
        leaver.put(LocalTime.of(20,30), new boundary(20, 22));
        leaver.put(LocalTime.of(21,00), new boundary(10, 12));
        leaver.put(LocalTime.of(21,30), new boundary(10, 12));
        leaver.put(LocalTime.of(22,00), new boundary(6, 8));
    }


    // 주말
    public void holidayMake() {
        entrance.put(LocalTime.of(16,00), new boundary(0, 0));
        entrance.put(LocalTime.of(16,30), new boundary(2, 3));
        entrance.put(LocalTime.of(17,00), new boundary(2, 3));
        entrance.put(LocalTime.of(17,30), new boundary(3, 5));
        entrance.put(LocalTime.of(18,00), new boundary(20, 24));
        entrance.put(LocalTime.of(18,30), new boundary(14, 16));
        entrance.put(LocalTime.of(19,00), new boundary(8, 12));
        entrance.put(LocalTime.of(19,30), new boundary(8, 12));
        entrance.put(LocalTime.of(20,00), new boundary(6, 10));
        entrance.put(LocalTime.of(20,30), new boundary(2, 3));
        entrance.put(LocalTime.of(21,00), new boundary(0, 0));
        entrance.put(LocalTime.of(21,30), new boundary(0, 0));
        entrance.put(LocalTime.of(22,00), new boundary(0, 0));


        leaver.put(LocalTime.of(16,00), new boundary(0, 0));
        leaver.put(LocalTime.of(16,30), new boundary(0, 0));
        leaver.put(LocalTime.of(17,00), new boundary(0, 0));
        leaver.put(LocalTime.of(17,30), new boundary(15, 18));
        leaver.put(LocalTime.of(18,00), new boundary(8, 10));
        leaver.put(LocalTime.of(18,30), new boundary(6, 8));
        leaver.put(LocalTime.of(19,00), new boundary(8, 10));
        leaver.put(LocalTime.of(19,30), new boundary(10, 12));
        leaver.put(LocalTime.of(20,00), new boundary(10, 12));
        leaver.put(LocalTime.of(20,30), new boundary(20, 22));
        leaver.put(LocalTime.of(21,00), new boundary(10, 12));
        leaver.put(LocalTime.of(21,30), new boundary(10, 12));
        leaver.put(LocalTime.of(22,00), new boundary(6, 8));
    }





}
