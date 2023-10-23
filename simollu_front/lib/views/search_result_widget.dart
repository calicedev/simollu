import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/default_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simollu_front/services/waiting_api.dart';
import 'package:simollu_front/viewmodels/map_view_model.dart';
import 'package:simollu_front/viewmodels/waiting_view_model.dart';
import 'package:simollu_front/views/map_page.dart';
import 'package:simollu_front/views/restaurant_detail_page.dart';

import '../root.dart';

class SearchResultWidget extends StatefulWidget {
  final int restaurantSeq;
  final String name;
  final String imageUrl;
  final double distance;
  final int waitingTime;
  final int queueSize;
  final int restaurantRating;
  final int numberOfPeople;
  final VoidCallback onWait;
  final String latitude;
  final String longitude;

  const SearchResultWidget({
    Key? key,
    required this.restaurantSeq,
    required this.name,
    required this.imageUrl,
    required this.distance,
    required this.waitingTime,
    required this.queueSize,
    required this.restaurantRating,
    required this.numberOfPeople,
    required this.onWait,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  State<SearchResultWidget> createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends State<SearchResultWidget> {
  WaitingViewModel waitingViewModel = Get.find();
  MapViewModel mapViewModel = Get.find();
  int _numberOfPeople = 1;

  void _incrementNumberOfPeople() {
    setState(() {
      _numberOfPeople++;
    });
  }

  void _decrementNumberOfPeople() {
    setState(() {
      if (_numberOfPeople > 1) {
        _numberOfPeople--;
      }
    });
  }

  registWaiting() async {
    bool response = await waitingViewModel.postWaiting(
        widget.restaurantSeq, _numberOfPeople, widget.name);
    if (response) {
      mapViewModel.resetMapData();
      mapViewModel.destination.value = LatLng(
        double.parse(widget.latitude),
        double.parse(widget.longitude),
      );
      mapViewModel.restaurantName.value = widget.name;
      RootController.to.setRootPageTitles("");
      RootController.to.setIsMainPage(false);
      RootController.to.searchKey.currentState!.push(
        GetPageRoute(
          page: () => MapPage(),
          transition: Transition.cupertino,
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        RootController.to.setRootPageTitles(widget.name);
        RootController.to.setIsMainPage(false);
        RootController.to.searchKey.currentState!.push(
          GetPageRoute(
            page: () =>
                RestaurantDetailpage(restaurantSeq: widget.restaurantSeq),
            transition: Transition.cupertino,
          ),
        );

        // Get.to(RestaurantDetailpage(restaurantSeq: widget.restaurantSeq));
        // Navigator.push(context,
        //     MaterialPageRoute(
        //         fullscreenDialog: true,
        //         builder: (_) => RestaurantDetailpage())
        // );

        // Navigator.pushReplacement(
        //   context,
        //   GetPageRoute(
        //     curve: Curves.fastOutSlowIn,
        //     page: () => RestaurantDetailpage(),
        //   ),
        // );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start, // 위젯 위쪽 정렬
                children: [
                  SizedBox(
                    // height: 180,
                    child: Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: widget.imageUrl ??
                              'https://example.com/placeholder.jpg', // imageUrl 값이 없을 경우 대체 이미지 URL 사용
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              CachedNetworkImage(
                            imageUrl:
                                'https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20210822_175%2F1629608739877EdSeW_JPEG%2FCocsHIGyvHMjKF7YxPYLJklP.jpg',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // child: ClipRRect(
                      //   borderRadius: BorderRadius.circular(10),
                      //   child: Image.network(
                      //     widget.imageUrl,
                      //     width: 80,
                      //     height: 80,
                      //     fit: BoxFit
                      //         .cover, // 이미지가 Container에 꽉 차게 보이도록 설정
                      //   ),
                      // ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // 가게 이름
                          margin: EdgeInsets.only(left: 10, top: 10),
                          child: SizedBox(
                            child: Text(
                              widget.name,
                              maxLines: 2,
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
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 2),
                          child: Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                color: Color(0xFFFFD200),
                                size: 19,
                              ),
                              Text(
                                "기다릴만해요 ${widget.restaurantRating}%",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(widget.distance.toString() + "km"),
                                ],
                              ),
                              Expanded(child: Container()),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    color: Color(0xFFFFD200),
                                    size: 21,
                                  ),
                                  Text(
                                    '${widget.waitingTime}분 웨이팅',
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: 0,
                                      wordSpacing: 0,
                                      height: 1.0,
                                      shadows: [],
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     Icon(
                            //       Icons.schedule,
                            //       color: Color(0xFFFFD200),
                            //     ),
                            //     Text(
                            //       '1시간 30분 웨이팅',
                            //       maxLines: 2,
                            //       style: TextStyle(
                            //         color: Colors.black,
                            //         fontSize: 13,
                            //         fontFamily: 'Roboto',
                            //         fontWeight: FontWeight.bold,
                            //         fontStyle: FontStyle.normal,
                            //         letterSpacing: 0,
                            //         wordSpacing: 0,
                            //         height: 1.0,
                            //         shadows: [],
                            //         decoration: TextDecoration.none,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Color(0xFFFFD200),
                                  size: 21,
                                ),
                                Text(
                                  '현재 ${widget.queueSize}팀 대기 중',
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                    letterSpacing: 0,
                                    wordSpacing: 0,
                                    height: 1.0,
                                    shadows: [],
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              // 인원 수, 웨이팅하기 버튼
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: _decrementNumberOfPeople,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Icon(Icons.remove),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        width: 70,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 7.5),
                        child: Text(
                          '$_numberOfPeople',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: _incrementNumberOfPeople,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 160,
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () async {
                      print('웨이팅하기 ! 클릭');
                      // 웨이팅 등록 api 연결
                      registWaiting();
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Color(0xFFFFD200),
                      side: BorderSide(
                        color: Color(0xFFFFD200),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        '웨이팅하기',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
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
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
