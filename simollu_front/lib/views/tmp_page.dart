import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simollu_front/views/fork_reward_page.dart';

import 'package:simollu_front/views/liking_things_page.dart';
import 'package:simollu_front/views/notification_page.dart';
import 'package:simollu_front/views/restaurant_detail_page.dart';

import 'package:simollu_front/views/review_management_page.dart';
import 'package:simollu_front/views/test_restaurant_detail_page.dart';

import 'package:simollu_front/views/writing_review_page.dart';
import 'package:simollu_front/views/start_page.dart';

class TmpPage extends StatelessWidget {
  const TmpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              OutlinedButton(
                onPressed: () {
                  debugPrint('취향 받기 페이지 이동!!!!!!!!');
                  // Get.to(LikingThings()); //페이지이동
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LikingThings(isLogined: false)));
                },
                style: OutlinedButton.styleFrom(
                    side: BorderSide(
                  // 테두리 바꾸는 속성
                  color: Colors.black54,
                  width: 1.0,
                )),
                child: Text('취향 받기 페이지',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0,
                      wordSpacing: 0,
                      height: 1.0,
                      shadows: [],
                      decoration: TextDecoration.none,
                    )),
              ),
              OutlinedButton(
                onPressed: () {
                  Get.to(StartPage());
                },
                child: Text('로그인'),
              ),
            ],
          ),
          Row(
            children: [
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReviewManagementPage()));
                },
                child: Text('내 리뷰 관리'),
              ),
              OutlinedButton(
                onPressed: () {
                  // Get.to(RestaurantDetailpage());
                },
                child: Text('가게 정보'),
              ),
              OutlinedButton(
                onPressed: () {
                  Get.to(TestRestaurantDetailpage());
                },
                child: Text('임시'),
              ),
              OutlinedButton(
                onPressed: () {},
                child: Text('포크'),
              ),
            ],
          ),
          Row(
            children: [
              OutlinedButton(
                onPressed: () {
                  Get.to(NotificationPage());
                },
                child: Text('알림'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
