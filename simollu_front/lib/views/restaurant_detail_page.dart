import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simollu_front/models/waitingTimeModel.dart';
import 'package:simollu_front/viewmodels/user_view_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:simollu_front/models/menuInfoModel.dart';
import 'package:simollu_front/models/restaurantReviewModel.dart';
import 'package:simollu_front/services/restaurant_detail_api.dart';
import 'package:simollu_front/viewmodels/restaurant_view_model.dart';
import 'package:simollu_front/views/restaurant_review_page.dart';
import 'package:simollu_front/widgets/custom_tabBar.dart';

import '../models/restaurantDetailModel.dart';

class RestaurantDetailpage extends StatefulWidget {
  final int restaurantSeq;

  const RestaurantDetailpage({
    Key? key,
    required this.restaurantSeq,
  });

  @override
  State<RestaurantDetailpage> createState() => _RestaurantDetailpageState();
}

class _RestaurantDetailpageState extends State<RestaurantDetailpage>
    with SingleTickerProviderStateMixin {
  RestaurantViewModel restaurantViewModel = Get.find();
  UserViewModel userViewModel = Get.find();
  late TabController? _tabController;
  bool toggleChart = false;

  getRestaurantDetailInfo() async {
    await restaurantViewModel.fetchRestaurantDetail(widget.restaurantSeq);
    _isLike = restaurantViewModel.restaurantInfo.value!.restaurantLike;
  }

  postInterestRestaurant() async {
    bool response = await userViewModel.postInterestRestaurant(
        restaurantViewModel.restaurantInfo.value!.restaurantSeq);

    if (response) {
      setState(() {
        _isLike = !_isLike;
      });
    }
  }

  late List<RestaurantReviewModel> reviewList = [];
  bool _isLike = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    fetchReviewData();
    getRestaurantDetailInfo();
  }

  Future<void> fetchReviewData() async {
    await restaurantViewModel.fetchReview(widget.restaurantSeq);
    // result.sort((a, b) => (b['reviewSeq'].compareTo(a['reviewSeq'])));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => restaurantViewModel.restaurantInfo.value == null
          ? Container(
              color: Colors.white,
              child: Image.asset("assets/logo.png"),
            )
          : Scaffold(
              body: CustomTabBar(
                  length: 3,
                  tabs: ['메뉴', '매장 정보', '리뷰'],
                  tabViews: [
                    _menuDetail(restaurantViewModel.menuInfoList.value),
                    _restaurantInfo(
                        restaurantViewModel
                            .restaurantInfo.value!.restaurantBusinessHours,
                        restaurantViewModel
                            .restaurantInfo.value!.restaurantPhoneNumber),
                    RestaurantReviewPage(
                        reviewList: restaurantViewModel.reviews.value),
                  ],
                  hasSliverAppBar: true,
                  flexibleImage:
                      restaurantViewModel.restaurantInfo.value!.restaurantImg,
                  bottomWidget: Container(
                    color: Colors.white,
                    // height: 140,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      restaurantViewModel.restaurantInfo.value!
                                              .restaurantName ??
                                          '',
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      restaurantViewModel.restaurantInfo.value!
                                              .restaurantCategory ??
                                          '',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black54),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      restaurantViewModel.restaurantInfo.value!
                                              .restaurantAddress ??
                                          '',
                                      style: TextStyle(color: Colors.black38),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.timer_outlined,
                                          color: Colors.amber,
                                          size: 18,
                                        ),
                                        Text(
                                          '기다릴만해요 ${restaurantViewModel.restaurantInfo.value!.restaurantRating ?? 0}%',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.amber),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    _isLike
                                        ? IconButton(
                                            onPressed: () {
                                              setState(() {
                                                postInterestRestaurant();
                                              });
                                            },
                                            icon: Icon(
                                              Icons.favorite,
                                              color: Colors.pink,
                                            ))
                                        : IconButton(
                                            onPressed: () {
                                              setState(() {
                                                postInterestRestaurant();
                                              });
                                            },
                                            icon: Icon(
                                              Icons.favorite_border,
                                              color: Colors.pink,
                                            )),
                                    ButtonTheme(
                                      child: OutlinedButton(
                                        onPressed: () {
                                          setState(() {
                                            toggleChart = !toggleChart;
                                          });
                                        },
                                        style: OutlinedButton.styleFrom(
                                            foregroundColor: Colors.black,
                                            side: BorderSide(
                                              color: Colors.black12,
                                            ),
                                            fixedSize: Size(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                40),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0))),
                                        child: Text(
                                          '예상대기시간',
                                          maxLines: 1,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            child: toggleChart
                                ? Container(
                                    child: SfCartesianChart(
                                        primaryXAxis: CategoryAxis(),
                                        series: <LineSeries<WaitingTimeModel,
                                            String>>[
                                        LineSeries<WaitingTimeModel, String>(
                                            dataSource: restaurantViewModel
                                                .waitingTimeList,
                                            xValueMapper:
                                                (WaitingTimeModel waitingTime,
                                                        _) =>
                                                    waitingTime.timeZone,
                                            yValueMapper: (WaitingTimeModel
                                                        waitingTime,
                                                    _) =>
                                                waitingTime.expectedWaitingTime,
                                            // Enable data label
                                            dataLabelSettings:
                                                DataLabelSettings(
                                                    isVisible: false))
                                      ]))
                                : null,
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
    );
  }

  Widget _menuDetail(List<MenuInfoModel> menuList) {
    if (menuList.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          '등록된 메뉴 정보가 없습니다.',
          style: TextStyle(fontSize: 16),
        ),
      );
    }
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: menuList
              .map(
                (menu) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: menu.menuImage ??
                            'https://example.com/placeholder.jpg', // imageUrl 값이 없을 경우 대체 이미지 URL 사용
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            CachedNetworkImage(
                          imageUrl:
                              'https://cdn.pixabay.com/photo/2023/04/28/07/07/cat-7956026_960_720.jpg',
                          width: 80,
                          height: 80,
                        ),
                      ),
                      Expanded(
                        // margin: EdgeInsets.only(left: 10),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                menu.menuName ?? '',
                                maxLines: 2,
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(menu.menuPrice ?? ''))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _restaurantInfo(
      String restaurantBusinessHours, String restaurantPhoneNumber) {
    return Container(
      color: Colors.white,
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.only(left: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '영업 정보',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Expanded(flex: 3, child: Text('운영시간')),
                Expanded(flex: 7, child: Text(restaurantBusinessHours ?? '')),
              ],
            ),
            Row(
              children: [
                Expanded(flex: 3, child: Text('전화 번호 ')),
                Expanded(flex: 7, child: Text(restaurantPhoneNumber ?? '')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  MyTabBarDelegate({required this.tabBar});

  @override
  Widget build(
      BuildContext context, double shrinkOffest, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
