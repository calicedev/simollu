import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:simollu_front/root.dart';
import 'package:simollu_front/viewmodels/review_view_model.dart';
import 'package:simollu_front/views/fork_reward_page.dart';
import 'package:simollu_front/views/interesting_restaurants_page.dart';
import 'package:simollu_front/views/liking_things_page.dart';
import 'package:simollu_front/views/my_page_edit.dart';
import 'package:simollu_front/views/recenlty_viewed_restaurants_page.dart';
import 'package:simollu_front/views/review_management_page.dart';
import 'package:simollu_front/views/start_page.dart';
import 'package:simollu_front/views/waiting_record_page.dart';

import '../viewmodels/user_view_model.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => MyPageState();
}

class MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = Get.find();
    ReviewViewModel reviewViewModel = Get.find();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 노란색 박스
            // 프로필 이미지, 닉네임, 화살표 버튼
            Container(
              height: 135,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
                color: Color(0xFFFFD200),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child:
                        // 프사
                        Obx(
                      () => CircleAvatar(
                        radius: 50,
                        backgroundImage: userViewModel.image.value == ""
                            ? AssetImage("assets/logo.png")
                            : CachedNetworkImageProvider(
                                userViewModel.image.value) as ImageProvider,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => Text(
                        userViewModel.nickname.value,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      RootController.to.setRootPageTitles("내 정보 수정");
                      RootController.to.setIsMainPage(false);
                      Navigator.push(
                        context,
                        GetPageRoute(
                          page: () => MyPageEdit(
                            name: "",
                          ),
                          transition: Transition.cupertino,
                        ),
                      );
                    },
                    style: ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(
                        Colors.transparent,
                      ),
                      shadowColor: null,
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            // 흰색 박스
            // 포크 수, 관심 매장 수, 작성 리뷰 수
            Container(
              height: 120,
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
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 6),
                        )
                      ],
                    ),
                    child: IntrinsicWidth(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: GestureDetector(
                              onTap: () {
                                RootController.to.setRootPageTitles("포크 사용 내역");
                                RootController.to.setIsMainPage(false);
                                Navigator.push(
                                  context,
                                  GetPageRoute(
                                    curve: Curves.fastOutSlowIn,
                                    page: () => ForkRewardPage(),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "포크",
                                    style: TextStyle(
                                      color: Color(0xFF555555),
                                      fontSize: 16,
                                    ),
                                  ),
                                  Obx(
                                    () => Text(
                                      userViewModel.fork.value.toString(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          VerticalDivider(
                            indent: 10,
                            endIndent: 10,
                            color: Colors.grey.withOpacity(0.5),
                            thickness: 1.0,
                          ),
                          SizedBox(
                            width: 100,
                            child: GestureDetector(
                              onTap: () {
                                RootController.to.setRootPageTitles("관심 식당");
                                RootController.to.setIsMainPage(false);
                                Navigator.push(
                                  context,
                                  GetPageRoute(
                                    curve: Curves.fastOutSlowIn,
                                    page: () => InterestingRestaurantsPage(),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "관심 식당",
                                    style: TextStyle(
                                      color: Color(0xFF555555),
                                      fontSize: 16,
                                    ),
                                  ),
                                  Obx(
                                    () => Text(
                                      userViewModel
                                          .interestRestaurantList.value.length
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          VerticalDivider(
                            indent: 10,
                            endIndent: 10,
                            color: Colors.grey.withOpacity(0.5),
                            thickness: 1.0,
                          ),
                          SizedBox(
                            width: 100,
                            child: GestureDetector(
                              onTap: () {
                                RootController.to.setRootPageTitles("작성 리뷰");
                                RootController.to.setIsMainPage(false);
                                Navigator.push(
                                  context,
                                  GetPageRoute(
                                    curve: Curves.fastOutSlowIn,
                                    page: () => ReviewManagementPage(),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "작성 리뷰",
                                    style: TextStyle(
                                      color: Color(0xFF555555),
                                      fontSize: 16,
                                    ),
                                  ),
                                  Obx(
                                    () => Text(
                                      reviewViewModel.reviewList.value.length
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
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
              ),
            ),
            // 리스트
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    RootController.to.setRootPageTitles("웨이팅 기록");
                    RootController.to.setIsMainPage(false);
                    Navigator.push(
                      context,
                      GetPageRoute(
                        curve: Curves.fastOutSlowIn,
                        page: () => WaitingRecordPage(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFDDDDDD),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          '웨이팅 기록',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    RootController.to.setRootPageTitles("최근 본 식당");
                    RootController.to.setIsMainPage(false);
                    Navigator.push(
                      context,
                      GetPageRoute(
                        curve: Curves.fastOutSlowIn,
                        page: () => RecentlyViewedRestaurantsPage(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFDDDDDD),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          '최근 본 식당',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('취향 보기');
                    RootController.to.setRootPageTitles("취향 보기");
                    RootController.to.setIsMainPage(false);
                    Navigator.push(
                      context,
                      GetPageRoute(
                        curve: Curves.fastOutSlowIn,
                        page: () => LikingThings(isLogined: true),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFDDDDDD),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          '취향 보기',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('회원 탈퇴');
                  },
                  child: Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFDDDDDD),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          '회원 탈퇴',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ElevatedButton(
          onPressed: () async {
            print('로그아웃');
            // SharedPreferences에서 "token" 키에 저장된 값을 삭제합니다.
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove("token");
            Get.offAll(StartPage());
          },
          style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            alignment: Alignment.center,
            backgroundColor: MaterialStateProperty.all(
              Color(0xFFFFD200),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              '로그아웃',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
