import 'package:flutter/material.dart';

class TestRestaurantDetailpage extends StatefulWidget {
  const TestRestaurantDetailpage({super.key});

  @override
  State<TestRestaurantDetailpage> createState() => _TestRestaurantDetailpageState();
}

class _TestRestaurantDetailpageState extends State<TestRestaurantDetailpage> {
  final List<List<String>> _menuList = [
    ['burger.jpg', '햄버거', '15,000'],
    ['potato.jpg', '감자튀김', '13,000'],
    ['potato.jpg', '감자튀김', '13,000'],
    ['potato.jpg', '감자튀김', '13,000'],
    ['potato.jpg', '감자튀김', '13,000'],
    ['potato.jpg', '감자튀김', '13,000'],
    ['potato.jpg', '감자튀김', '13,000'],
    ['potato.jpg', '감자튀김', '13,000'],
    ['potato.jpg', '감자튀김', '13,000'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/Rectangle 42.png'),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '바스버거',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '양식',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black54),
                              ),
                            ],
                          ),
                          Text(
                            '서울특별시 강남구 역삼동 777',
                            style: TextStyle(color: Colors.black38),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                color: Colors.amber,
                                size: 22,
                              ),
                              Text(
                                '기다릴만해요 87%',
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.favorite,
                              color: Colors.pink,
                            ),
                            ButtonTheme(
                              child: OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      side: BorderSide(
                                        color: Colors.black12,
                                      ),
                                      fixedSize: Size(
                                          MediaQuery.of(context).size.width *
                                              0.3,
                                          43),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(20.0))),
                                  child: Text(
                                    '예상대기시간',
                                    maxLines: 1,
                                  )),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 1000,
              color: Colors.white,
              // child: CustomTabBar(
              //   length: 3,
              //   tabs: ['메뉴', '매장 정보', '리뷰'],
              //   tabViews: [
              //     _menuDetail(_menuList),
              //     _restaurantInfo(),
              //     Container()
              //   ],
              // ),
            )
          ],
        ),
      ),
    );
  }

  Widget _menuDetail(List<List<String>> menuList) {
    return Column(
      children: menuList
          .map(
            (menu) => Row(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Image.asset('assets/${menu[0]}'),
            ),
            Column(
              children: [Text(menu[1]), Text(menu[2])],
            )
          ],
        ),
      )
          .toList(),
    );
  }

  Widget _restaurantInfo() {
    return Column(
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
            Expanded(flex: 3, child: Text('운영 ')),
            Expanded(flex: 7, child: Text('월 ~ 금 10:00')),
          ],
        ),
        Row(
          children: [
            Expanded(flex: 3, child: Text('전화 번호 ')),
            Expanded(flex: 7, child: Text('월 ~ 금 10:00')),
          ],
        ),
      ],
    );
  }
}
