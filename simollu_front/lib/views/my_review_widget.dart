import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:simollu_front/models/reviewModel.dart';
import 'package:simollu_front/views/review_management_star_button.dart';

class MyReview extends StatelessWidget {
  late Future<List<ReviewModel>> myReivews;
  List<Map<dynamic, dynamic>> ratingText = [
    {'text': '별로예요', Color: Colors.redAccent},
    {'text': '기다릴만해요', Color: Colors.amber},
  ];

  MyReview({
    Key? key,
    required this.myReivews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
            future: myReivews,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 100),
                          Icon(Icons.speaker_notes_off_outlined,
                            size: 90,
                          ),
                          SizedBox(height: 20),
                          Text('작성한 리뷰가 없습니다.',
                            style: TextStyle(
                                fontSize: 18
                            ),
                          )
                        ],
                      )
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    ReviewModel review = snapshot.data![index];
                    return Card(
                      elevation: 2.0, //그림자 깊이
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 9, vertical: 10),
                        child: Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // 위젯 위쪽 정렬
                          children: [
                            SizedBox(
                              // height: 180,
                              child: Align(
                                alignment: Alignment.center,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'https://s3.ap-northeast-2.amazonaws.com/dongnealba.assets/stores/6388b351e5f1ee033c04fd5c/pic_1669903185757_0.jpeg', // imageUrl 값이 없을 경우 대체 이미지 URL 사용
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          CachedNetworkImage(
                                            imageUrl:
                                            'https://s3.ap-northeast-2.amazonaws.com/dongnealba.assets/stores/6388b351e5f1ee033c04fd5c/pic_1669903185757_0.jpeg',
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.cover,
                                          ),
                                    ),
                                  ),
                                  // child: Image.asset(
                                  //   'assets/dongraejeong.png',
                                  //   width: 80,
                                  //   height: 80,
                                  //   fit: BoxFit
                                  //       .cover, // 이미지가 Container에 꽉 차게 보이도록 설정
                                  // ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 170,
                                    child: Text(
                                      review.restaurantName as String,
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Roboto',
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
                                    width: 190,
                                    margin: EdgeInsets.only(top: 6),
                                    child: Text(
                                      review.reviewContent,
                                      maxLines: 8,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'Roboto',
                                        // fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.normal,
                                        letterSpacing: 0,
                                        wordSpacing: 0,
                                        height: 1.0,
                                        shadows: [],
                                        decoration: TextDecoration.none,
                                      ),
                                      softWrap: true,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 6),
                                    margin: EdgeInsets.only(top: 19),
                                    child: _buildRating(review.reviewRating),
                                    // child: ReviewStarBox(
                                    //   text: '기다릴만해요',
                                    // )
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              // 나머지 공간을 차지하기 위한 Expanded 위젯
                              child: Container(),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              child: Text(
                                review.reviewRegistDate!.split('T')[0],
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  // fontWeight: FontWeight.w600,
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
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.amber,
                  ),
                );
              }
            }),
        // Card(
        //   elevation: 2.0, //그림자 깊이
        //   child: Container(
        //     padding: EdgeInsets.symmetric(horizontal: 9, vertical: 10),
        //     child: Row(
        //       crossAxisAlignment: CrossAxisAlignment.start, // 위젯 위쪽 정렬
        //       children: [
        //         SizedBox(
        //           // height: 180,
        //           child: Align(
        //             alignment: Alignment.center,
        //             child: ClipRRect(
        //               borderRadius: BorderRadius.circular(10),
        //               child: Image.asset(
        //                 'assets/dongraejeong.png',
        //                 width: 80,
        //                 height: 80,
        //                 fit: BoxFit.cover, // 이미지가 Container에 꽉 차게 보이도록 설정
        //               ),
        //             ),
        //           ),
        //         ),
        //         Container(
        //           margin: EdgeInsets.only(top: 8),
        //           padding: EdgeInsets.only(left: 10),
        //           child: Column(
        //             mainAxisSize: MainAxisSize.max,
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Container(
        //                 width: 170,
        //                 child: Text(
        //                   '동래정 선릉직영점rrrrrrrrrrrrrrrrr',
        //                   maxLines: 2,
        //                   style: TextStyle(
        //                     color: Colors.black,
        //                     fontSize: 15,
        //                     fontFamily: 'Roboto',
        //                     fontWeight: FontWeight.bold,
        //                     fontStyle: FontStyle.normal,
        //                     letterSpacing: 0,
        //                     wordSpacing: 0,
        //                     height: 1.0,
        //                     shadows: [],
        //                     decoration: TextDecoration.none,
        //                   ),
        //                 ),
        //               ),
        //               Container(
        //                 width: 190,
        //                 margin: EdgeInsets.only(top: 6),
        //                 child: Text(
        //                   '가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나',
        //                   maxLines: 8,
        //                   style: TextStyle(
        //                     color: Colors.black,
        //                     fontSize: 14,
        //                     fontFamily: 'Roboto',
        //                     // fontWeight: FontWeight.w600,
        //                     fontStyle: FontStyle.normal,
        //                     letterSpacing: 0,
        //                     wordSpacing: 0,
        //                     height: 1.0,
        //                     shadows: [],
        //                     decoration: TextDecoration.none,
        //                   ),
        //                   softWrap: true,
        //                 ),
        //               ),
        //               Container(
        //                   padding: EdgeInsets.only(top: 6),
        //                   // margin: EdgeInsets.only(top: 19),
        //                   child: ReviewStarBox(
        //                     text: '기다릴만해요',
        //                   )),
        //             ],
        //           ),
        //         ),
        //         Expanded(
        //           // 나머지 공간을 차지하기 위한 Expanded 위젯
        //           child: Container(),
        //         ),
        //         Container(
        //           margin: EdgeInsets.only(top: 8),
        //           child: Text(
        //             '10초 전',
        //             style: TextStyle(
        //               color: Colors.black54,
        //               fontSize: 14,
        //               fontFamily: 'Roboto',
        //               // fontWeight: FontWeight.w600,
        //               fontStyle: FontStyle.normal,
        //               letterSpacing: 0,
        //               wordSpacing: 0,
        //               height: 1.0,
        //               shadows: [],
        //               decoration: TextDecoration.none,
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Container _buildRating(int reviewRating) {
    var review = ratingText[reviewRating];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: review[Color],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
        child: Text(
          review['text'],
          style: TextStyle(
              color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
