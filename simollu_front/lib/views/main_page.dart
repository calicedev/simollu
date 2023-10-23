import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:simollu_front/root.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simollu_front/services/main_api.dart';
import 'package:simollu_front/viewmodels/main_view_model.dart';
import 'package:simollu_front/viewmodels/map_view_model.dart';
import 'package:simollu_front/viewmodels/preference_view_model.dart';
import 'package:simollu_front/viewmodels/waiting_view_model.dart';
import 'package:simollu_front/views/map_page.dart';
import 'package:simollu_front/views/restaurant_detail_page.dart';
import 'package:simollu_front/widgets/shadow_button.dart';

import '../viewmodels/user_view_model.dart';

class WaitingInfo {
  final String restaurant;
  final int waitingNumber;
  int waitingCount;
  int expectedWatingTime;

  WaitingInfo({
    required this.restaurant,
    required this.waitingNumber,
    required this.waitingCount,
    required this.expectedWatingTime,
  });
}

class Restaurant {
  final String name;
  final String imagePath;
  final double likes;
  final int watingMinutes;
  final String location;
  final double distance;

  Restaurant({
    required this.name,
    required this.imagePath,
    required this.likes,
    required this.watingMinutes,
    required this.location,
    required this.distance,
  });
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  UserViewModel userViewModel = Get.find();
  MainViewModel mainViewModel = Get.find();
  MapViewModel mapViewModel = Get.find();
  PreferenceViewModel preferenceViewModel = Get.find();
  WaitingViewModel waitingViewModel = Get.find();

  void getData() async {
    await userViewModel.getNickname();
    await mapViewModel.getLocationPermission();
    await waitingViewModel.getWaitingInfo();
    await preferenceViewModel.getPreference();

    if (mapViewModel.locationPermission.value == LocationPermission.denied ||
        mapViewModel.locationPermission.value ==
            LocationPermission.deniedForever) {
      mainViewModel.getMainInfo(LatLng(37.5013068, 127.0396597));
    } else {
      mainViewModel.getMainInfo(LatLng(
          mapViewModel.currentPosition.value!.latitude,
          mapViewModel.currentPosition.value!.longitude));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  List<Map<String, Object>> foodTypeIcons = [
    {
      "imagePath": "assets/icons/korean.png",
      "label": "한식",
      "state": Category.Korean,
    },
    {
      "imagePath": "assets/icons/western.png",
      "label": "양식",
      "state": Category.Western,
    },
    {
      "imagePath": "assets/icons/chinese.png",
      "label": "중식",
      "state": Category.Chinese,
    },
    {
      "imagePath": "assets/icons/japanese.png",
      "label": "일식",
      "state": Category.Japanese,
    },
    {
      "imagePath": "assets/icons/fastfood.png",
      "label": "패스트푸드",
      "state": Category.FastFood,
    },
    {
      "imagePath": "assets/icons/cafe.png",
      "label": "카페",
      "state": Category.Cafe,
    },
    {
      "imagePath": "assets/icons/bakery.png",
      "label": "베이커리",
      "state": Category.Bakery,
    },
  ];
  List<Map<String, Object>> sortingOptions = [
    {
      "label": "가까운 순",
      "state": SortBy.NearBy,
    },
    {
      "label": "별점높은 순",
      "state": SortBy.HighRaiting,
    },
    {
      "label": "대기시간 적은 순",
      "state": SortBy.LessWaiting,
    }
  ];

  Future<void> _neverSatisfied() async {
    return showDialog<void>(
      //다이얼로그 위젯 소환
      context: context,
      barrierDismissible: false, // 다이얼로그 이외의 바탕 눌러도 안꺼지도록 설정
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('정말 순서를 뒤로 미루시겠습니까?'),
          ]),
          content: SingleChildScrollView(
            child: ListBody(
              //List Body를 기준으로 Text 설정
              children: <Widget>[
                Obx(
                  () => Text(
                      "${waitingViewModel.delayInfo.value!.waitingTeam}번째 순서로 미룹니다."),
                ),
                Obx(
                  () => Text(
                      "예상 대기 시간은 ${waitingViewModel.delayInfo.value!.waitingTime}분 입니다. "),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('확인'),
              onPressed: () async {
                bool res = await waitingViewModel.delayOrder();
                if (res) {
                  Navigator.of(context).pop();
                }
              },
            ),
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(
        () => waitingViewModel.waitingSeq.value == -1
            ? Container()
            : FloatingActionButton.extended(
                onPressed: () {
                  RootController.to.setRootPageTitles("");
                  RootController.to.setIsMainPage(false);
                  Navigator.push(
                    context,
                    GetPageRoute(
                      curve: Curves.fastOutSlowIn,
                      page: () => MapPage(),
                    ),
                  );
                },
                backgroundColor: Colors.amber,
                icon: Icon(Icons.location_on),
                label: Text(
                  '경로 보기',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 130,
              decoration: BoxDecoration(
                color: Color(0xFFFFD200),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Obx(
                          () => Text(
                            userViewModel.nickname.value + "님",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "오늘은 어디로 가볼까요?",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 28,
                    bottom: -10,
                    child: SvgPicture.asset(
                      "assets/logo.svg",
                      colorFilter: ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                      height: 64,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFFFD200),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                  ),
                  color: Colors.white,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Obx(
                        () => Container(
                          child: waitingViewModel.waitingSeq.value == -1
                              ? null
                              : Container(
                                  margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                        color: Colors.grey.withOpacity(0.4),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                waitingViewModel
                                                    .getWaitingInfo();
                                              },
                                              child: Icon(Icons.refresh),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10),
                                                    child: Text(
                                                      "${waitingViewModel.restaurantName.value}",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "예상 대기 시간",
                                                        style: TextStyle(
                                                          color: Colors.grey
                                                              .withOpacity(0.8),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        waitingViewModel
                                                                    .waitingTime
                                                                    .value >=
                                                                60
                                                            ? "${waitingViewModel.waitingTime.value ~/ 60}시간"
                                                            : "",
                                                      ),
                                                      Text(
                                                        " ${waitingViewModel.waitingTime.value % 60}분",
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "대기 순서",
                                                        style: TextStyle(
                                                          color: Colors.grey
                                                              .withOpacity(0.8),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "${waitingViewModel.waitingCurRank.value}",
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text("현재 대기 번호"),
                                                Text(
                                                  "${waitingViewModel.waitingNo.value}",
                                                  style: TextStyle(
                                                    color: Color(0xFFFFD200),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 32,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.all(10),
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    await waitingViewModel
                                                        .getDelayInfo();
                                                    _neverSatisfied();
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 5,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFFFD200),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          offset: Offset(0, 3),
                                                          blurRadius: 6,
                                                          color: Colors.grey
                                                              .withOpacity(0.4),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Text(
                                                      "순서 미루기",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.all(10),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    waitingViewModel
                                                        .cancelWaiting();
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 5,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFCCCCCC),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          offset: Offset(0, 6),
                                                          blurRadius: 3,
                                                          color: Colors.grey
                                                              .withOpacity(0.4),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Text(
                                                      "예약 취소",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                            child: Text(
                              "여기서 먹어볼까요?",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // 식당 정렬 순서 토글 행
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...List.generate(
                                3,
                                (index) => Obx(
                                  () => ShadowButton(
                                    event: () {
                                      mainViewModel.changeSortBy(
                                          sortingOptions[index]["state"]
                                              as SortBy);
                                    },
                                    color: sortingOptions[index]["state"]
                                                as SortBy ==
                                            mainViewModel.sortBy.value
                                        ? 0xFFFFD200
                                        : 0xFFAAAAAA,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      child: Text(
                                        sortingOptions[index]["label"]
                                            as String,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // 음식 리스트
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Obx(
                              () => Row(
                                children: [
                                  ...List.generate(
                                    mainViewModel.tryHereList.length,
                                    (index) => Padding(
                                      padding: EdgeInsets.all(10),
                                      child: GestureDetector(
                                        onTap: () {
                                          RootController.to.setRootPageTitles(
                                              mainViewModel.tryHereList[index]
                                                  .restaurantName);
                                          RootController.to
                                              .setIsMainPage(false);
                                          Navigator.push(
                                            context,
                                            GetPageRoute(
                                              curve: Curves.fastOutSlowIn,
                                              page: () => RestaurantDetailpage(
                                                  restaurantSeq: mainViewModel
                                                      .tryHereList[index]
                                                      .restaurantSeq),
                                            ),
                                          );
                                        },
                                        child: SizedBox(
                                          width: 120,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: double.infinity,
                                                height: 120,
                                                child: CachedNetworkImage(
                                                  imageUrl: mainViewModel
                                                      .tryHereList[index]
                                                      .restaurantImage,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Text(
                                                mainViewModel.tryHereList[index]
                                                    .restaurantName,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.timer_outlined,
                                                    color: Color(0xFFFFD200),
                                                  ),
                                                  Text(
                                                    "${mainViewModel.tryHereList[index].restaurantRating}%",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey
                                                          .withOpacity(0.8),
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.schedule,
                                                    color: Colors.grey
                                                        .withOpacity(0.8),
                                                    size: 20,
                                                  ),
                                                  Text(
                                                    "${mainViewModel.tryHereList[index].restaurantWaitingTime}m",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey
                                                          .withOpacity(0.8),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: RichText(
                      text: TextSpan(
                        text: "요즘 ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "HOT",
                            style: TextStyle(
                              color: Color(0xFFFF6000),
                            ),
                          ),
                          TextSpan(
                            text: "한 맛집!",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...List.generate(
                          foodTypeIcons.length,
                          (index) => Column(
                            children: [
                              ShadowButton(
                                color: 0xFFFFD200,
                                event: () {
                                  mainViewModel.changeCategroy(
                                      foodTypeIcons[index]["state"]
                                          as Category);
                                },
                                child: SizedBox(
                                  width: 64,
                                  height: 64,
                                  child: Image.asset(
                                    foodTypeIcons[index]["imagePath"] as String,
                                  ),
                                ),
                              ),
                              Text(
                                foodTypeIcons[index]["label"] as String,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => Column(
                      children: [
                        ...List.generate(
                          mainViewModel.recentlyHotList.length,
                          (index) => GestureDetector(
                            onTap: () {
                              RootController.to.setRootPageTitles(mainViewModel
                                  .recentlyHotList[index].restaurantName);
                              RootController.to.setIsMainPage(false);
                              Navigator.push(
                                context,
                                GetPageRoute(
                                  curve: Curves.fastOutSlowIn,
                                  page: () => RestaurantDetailpage(
                                      restaurantSeq: mainViewModel
                                          .recentlyHotList[index]
                                          .restaurantSeq),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 0.5,
                                    color: Colors.grey.withOpacity(0.8),
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: CachedNetworkImage(
                                      imageUrl: mainViewModel
                                          .recentlyHotList[index]
                                          .restaurantImage,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            mainViewModel.recentlyHotList[index]
                                                .restaurantName,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.timer_outlined,
                                                color: Color(0xFFFFD200),
                                              ),
                                              Text(
                                                "${mainViewModel.recentlyHotList[index].restaurantRating}%",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey
                                                      .withOpacity(0.8),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.schedule,
                                                color: Colors.grey
                                                    .withOpacity(0.8),
                                                size: 20,
                                              ),
                                              Text(
                                                "${mainViewModel.recentlyHotList[index].restaurantWaitingTime}m",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey
                                                      .withOpacity(0.8),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "${mainViewModel.recentlyHotList[index].restaurantAddress} ${mainViewModel.recentlyHotList[index].distance}km",
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
