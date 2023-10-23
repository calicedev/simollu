import 'package:flutter/material.dart';
import 'package:simollu_front/viewmodels/waiting_view_model.dart';
import 'package:simollu_front/widgets/waiting_record_card.dart';
import 'package:simollu_front/widgets/custom_tabBar.dart';

import '../models/waiting_record_model.dart';

class WaitingRecordPage extends StatefulWidget {
  const WaitingRecordPage({Key? key}) : super(key: key);

  @override
  State<WaitingRecordPage> createState() => _WaitingRecordPageState();
}

class _WaitingRecordPageState extends State<WaitingRecordPage> {
  late final Future<List<WaitingRecordModel>> waitingRecords;
  late final Future<List<WaitingRecordModel>> cancleRecords;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    waitingRecords = WaitingViewModel.fetchWaitingRecord(1);
    cancleRecords = WaitingViewModel.fetchWaitingRecord(2);
    print(waitingRecords);
    print('취소용$cancleRecords');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomTabBar(length: 2, tabs: [
          '이용 완료',
          '취소 내역'
        ], tabViews: [
          // 위젯 리스트
          usageHistory(records: waitingRecords),
          usageHistory(records: cancleRecords),
        ]));
  }

  Widget usageHistory({required Future<List<WaitingRecordModel>> records}) {
    // 사용 내역 tabView 내용 위젯
    return Column(
      children: [
        // WaitingRecordcard(),
        FutureBuilder(
          future: records,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: ((context, index) {
                    WaitingRecordModel record = snapshot.data![index];
                    return WaitingRecordcard(
                      record: record,
                    );
                  }),
                );
              } else {
                return Column(
                  children: [
                    SizedBox(height: 100),
                    Icon(Icons.speaker_notes_off_outlined,
                    size: 100,),
                    SizedBox(height: 20),
                    Text('내역이 존재하지 않습니다.',
                    style: TextStyle(
                      fontSize: 18
                    ),
                    )
                  ],
                );
              }
            } else {
              return CircularProgressIndicator();
            }
          },
        )
      ],
    );
  }

  Widget cancelWaiting() {
    // 이용 취소 tabView 내용 위젯
    return Column(
      children: [
        // WaitingRecordcard(
        //   isCanclled: true,
        // ),
        // WaitingRecordcard(
        //   isCanclled: true,
        // ),
        // WaitingRecordcard(
        //   isCanclled: true,
        // ),
        // WaitingRecordcard(
        //   isCanclled: true,
        // ),
      ],
    );
  }
}
