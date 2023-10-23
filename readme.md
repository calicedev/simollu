## Simollu

![simollu](https://user-images.githubusercontent.com/50287759/233513886-e5c6a30f-735c-433d-9edf-6b83d8e6f5f2.png)

## Simollu - 웨이팅 시간을 가치있게 만들어주는 서비스

: 시간 가는 줄 모른다.

## ✔️기획 배경

![simollu-기획배경](https://github.com/chloe73/Algorithm/assets/50287759/afe6fd6e-787b-4170-a49c-b5d58f797fe3)

- 맛집에 웨이팅을 신청한 뒤, 차례가 올 때까지 하염없이 가게 앞에서 기다리는 시간이 너무 무료하고 지루하지 않으신가요?
- 이에 대해 저희 서비스는 사용자가 맛집에 웨이팅을 신청한 뒤, 사용자의 현재 위치와 가게 위치, 웨이팅 시간을 토대로 웨이팅 시간을 지루하지 않고 알차게 보낼 수 있도록 추천 경로를 제공합니다.

### 😎핵심기능

**1. 웨이팅 기능**
   : 순서 미루기 기능도 가능

<img width="244" alt="스크린샷 2023-05-27 오후 10 20 53" src="https://github.com/chloe73/Algorithm/assets/50287759/18900efc-9e57-40aa-af69-b64d415bee97">


**2. 웨이팅 시간에 따른 놀거리 추천 경로**

   ![추천경로](https://user-images.githubusercontent.com/50287759/233514348-6c04d800-c515-4d17-9ba6-856e54d102d6.png)

**3. 시간대 별 예상 대기시간 통계 (알고리즘 고도화)**

   ![image](https://user-images.githubusercontent.com/50287759/233514583-c1d5d85e-d59b-4350-8fa6-3aee4020ca7d.png)

**4. 실시간 인기 검색어**

<img width="244" alt="스크린샷 2023-05-27 오후 10 17 46" src="https://github.com/chloe73/Algorithm/assets/50287759/0c613fa4-061c-4cc9-bd39-6ee206e6f289">

## 🌈Figma

![자율PRJ  A701](https://user-images.githubusercontent.com/50287759/233515425-641943b1-bca5-41fb-9cbf-aef934f76c94.png)

## ERD

![ERDDiagram](https://user-images.githubusercontent.com/48821942/233518708-74efe7c1-e7c6-40ee-820c-959339012b15.PNG)

## Git branch 전략

![GitLabBranchStrategy](https://user-images.githubusercontent.com/48821942/233518940-75bcaed2-94f1-4a55-b315-8cc6d3d5209a.PNG)

### 🐳팀원

- 이소민 (팀장 | Front-end)
- 고태진 (Front-end)
- 김동언 (Back-end)
- 김수형 (Front-end)
- 이민정 (Back-end)
- 임혜은 (Back-end)




## BackEnd

알림 서비스 
FCM 을 활용해 사용자들의 행동에 따라 알림을 제공합니다.
calculator-service
과거의 로그를 연산해 예상 대기 시간과 시간별 순위 예상 대기 시간 증가율을 계산합니다.
그 후 이를 redis에 caching 하게 됩니다.



waiting-service
식당 대기와 관련된 작업을 수행합니다.
대기 신청, 대기 조회, 내역 조회, 미루기 기능 등의 행동을 합니다.
실시간 순위 정보를 redis 기록해 사용자들에게 현재 순위와 예상 대기 시간을 제공합니다. 


restaurant-service
식당, 후기 관련 기능을 담당하는 restaurant service 입니다.
엘라스틱 서치와 연결하여 검색을 구현했습니다.


user-service
카카오 소셜 로그인, 로그아웃 
회원의 기본 정보와 닉네임, 프로필 이미지, 포크, 상태 등을 관리합니다.


discovery-service
port : 8761
마이크로서비들의 이름과 ip address, port 번호를 관리하는 서비스 입니다.
이곳에 마이크로서비스들이 자신의 ip address, port 번호를 등록하면 Spring Cloud Gateway가 참고해서 경로를 지정해줍니다. 


Config-service
서비스들의 설정 정보를 관리하고 연결시켜 줍니다. 
bootstrap.yml, Docker 파일은 서버 안에서 관리합니다.
application.yml 파일은 다른 gitlab 저장소에 있습니다.
https://lab.ssafy.com/cladren12332/simollu_config



api gateway
spring cloud gateway로 구현했습니다.
discovery-service를 통해 각각의 서비스들의 이름과 ip address, port를 확인합니다.
그 이후 요청에 맞는 알맞은 경로를 설정해 줍니다.
jwt 토큰의 유효성 검증 필터를 적용합니다.









