import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simollu_front/models/waiting_record_model.dart';
import 'package:simollu_front/views/writing_review_page.dart';

import '../root.dart';
import '../views/my_page.dart';
import '../views/review_management_page.dart';

class WaitingRecordcard extends StatelessWidget {
  final bool? isCanclled;
  final WaitingRecordModel record;
  final List<String> week = ['월', '화', '수', '목', '금', '토', '일'];

  bool isDate(String str) {
    try {
      DateTime.parse(str);
      return true;
    } catch (e) {
      return false;
    }
  }

  WaitingRecordcard({
    Key? key,
    this.isCanclled = false,
    required this.record,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.9,
      // height: 100,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(3)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
            child: Text(
              record.restaurantName as String,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          // _buildPadding("예약일시", "2023/03/18(목) 13:45"),
          _buildPadding("예약일시", record.waitingStatusRegistDate as String),
          _buildPadding("대기번호", record.waitingNo.toString()),
          _buildPadding("인원",  record.waitingPersonCnt.toString()),
          if (isCanclled == true)
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Center(
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.95, 40),
                    ),
                    onPressed: () {
                      RootController.to.setRootPageTitles('작성 리뷰');
                      RootController.to.setIsMainPage(false);
                      Navigator.push(
                        context,
                        GetPageRoute(
                          curve: Curves.fastOutSlowIn,
                          page: () => ReviewManagementPage(),
                        ),
                      );
                    },
                    child: Text('리뷰 작성 하기')),
              ),
            )
        ],
      ),
    );
  }

  Widget _buildPadding(String label, String value) {
    final String content;
    if (isDate(value)) {
      final dateTime = DateTime.parse(value);
      final formattedDate = DateFormat('yyyy/MM/dd').format(dateTime);
      final formattedTime = DateFormat('HH:MM').format(dateTime);
      final weekday = week[dateTime.weekday];
      content = '$formattedDate($weekday) $formattedTime';
    } else {
      content = value;
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label), Text(content)],
      ),
    );
  }
}
