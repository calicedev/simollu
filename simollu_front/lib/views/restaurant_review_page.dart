import 'package:flutter/material.dart';
import 'package:simollu_front/models/restaurantReviewModel.dart';
import 'package:simollu_front/viewmodels/restaurant_view_model.dart';

class RestaurantReviewPage extends StatefulWidget {
  final List<RestaurantReviewModel> reviewList;

  const RestaurantReviewPage({
    Key? key,
    required this.reviewList,
  }) : super(key: key);

  @override
  State<RestaurantReviewPage> createState() => _RestaurantReviewPageState();
}

class _RestaurantReviewPageState extends State<RestaurantReviewPage> {
  RestaurantViewModel restaurantViewModel = RestaurantViewModel();

  Future<void> _handleTap(int reviewSeq) async {
    var result = await restaurantViewModel.fetchReviewDetail(reviewSeq);
    print(result.reviewContent);
  }

  @override
  Widget build(BuildContext context) {
    // return OutlinedButton(onPressed: (){ print(reviewList);}, child: Container( child: Text('버튼'),));
    if (widget.reviewList.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          '아직 등록된 리뷰가 없습니다.',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),

        ),
      );
    }
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.reviewList.length,
            itemBuilder: (context, index) {
              final review = widget.reviewList[index];
              return InkWell(
                onTap: () {
                  _handleTap(review.reviewSeq);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        child: Image.network(
                          review.userImg!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            // 이미지 로딩 실패 시 대체 이미지 보여주기
                            return Image.network(
                              'https://cdn.pixabay.com/photo/2023/04/28/07/07/cat-7956026_960_720.jpg',
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                        // decoration: BoxDecoration(
                        //     color: Colors.grey, shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review.userNickname,
                              // review['userSeq'],
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 3,),
                            review.reviewRating?
                              Text("기다릴만해요", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),)
                                :
                              Text('아쉬워요', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                            SizedBox(height: 3,),
                            Text(
                              review.reviewContent,
                              softWrap: true,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
