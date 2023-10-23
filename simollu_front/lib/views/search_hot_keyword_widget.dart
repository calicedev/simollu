import 'package:flutter/material.dart';
import 'package:simollu_front/models/search_hot_keyword_model.dart';

class SearchHotKeyword extends StatelessWidget {
  final List<SearchHotKeywordModel> list;

  SearchHotKeyword({required this.list});

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final halfWidth = width / 2; // 가로 크기와 같은 비율의 높이 계산

    return Container(
      width: halfWidth,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   'Container',
          //   style: TextStyle(
          //     fontSize: 16.0,
          //     color: Colors.black,
          //   ),
          // ),
          Container(
            height: 190,
            padding: EdgeInsets.only(left: 20),
            color: Colors.white,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 25),
                      child: Text(list[index].order.toString()+". ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 0,
                          wordSpacing: 0,
                          height: 1.0,
                          shadows: [],
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 25),
                      child: Text(list[index].keyword,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 0,
                          wordSpacing: 0,
                          height: 1.0,
                          shadows: [],
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ]
      ),
    );
  }
}