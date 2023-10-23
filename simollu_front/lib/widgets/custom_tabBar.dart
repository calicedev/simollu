import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  final int length;
  final List<String> tabs;
  final List<Widget> tabViews;
  final bool? hasSliverAppBar;
  final String? flexibleImage;
  final Widget? bottomWidget;

  const CustomTabBar({
    Key? key,
    required this.length,
    required this.tabs,
    required this.tabViews,
    this.hasSliverAppBar = false,
    this.flexibleImage,
    this.bottomWidget,
  }) : super(key: key);

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with TickerProviderStateMixin {
  late TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: widget.length,
        child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                if (widget.hasSliverAppBar!)
                  SliverAppBar(
                    pinned: false,
                    expandedHeight: 200,
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    flexibleSpace: FlexibleSpaceBar(
                      background: CachedNetworkImage(
                        imageUrl: widget.flexibleImage!,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            CachedNetworkImage(
                          imageUrl:
                              'https://cdn.pixabay.com/photo/2023/04/28/07/07/cat-7956026_960_720.jpg',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                SliverToBoxAdapter(
                  child: widget.bottomWidget,
                ),
                SliverPersistentHeader(
                    pinned: true,
                    delegate: MyTabBarDelegate(
                      tabBar: TabBar(
                        controller: _tabController,
                        tabs: List<Widget>.generate(widget.length, (index) {
                          return Tab(
                              child: Text(
                            widget.tabs[index],
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ));
                        }),
                        indicatorColor: Colors.black,
                        labelPadding: EdgeInsets.all(5.0),
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        unselectedLabelStyle:
                            TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ))
              ];
            },
            body: _buildTabBarView()));
    // return Column(
    //   children: [
    //     _buildTabBar(),
    //     Expanded(child: _buildTabBarView()),
    //   ],
    // );
  }

  // TabBar 제목 부분
  // Widget _buildTabBar() {
  //   return Container(
  //     decoration: BoxDecoration(
  //         border:
  //         Border(bottom: BorderSide(color: Colors.black12, width: 0.5))),
  //     child: TabBar(
  //       controller: _tabController,
  //       tabs: List<Widget>.generate(widget.length, (index) {
  //         return Tab(
  //             child: Text(
  //               widget.tabs[index],
  //               style: TextStyle(color: Colors.black, fontSize: 17),
  //             ));
  //       }),
  //       indicatorColor: Colors.black,
  //       labelPadding: EdgeInsets.all(5.0),
  //       labelStyle: TextStyle(fontWeight: FontWeight.bold),
  //       unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
  //     ),
  //   );
  // }

  // TabBar 내용 부분
  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: List<Widget>.generate(widget.length, (index) {
        return SingleChildScrollView(
          child: widget.tabViews[index],
        );
      }),
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
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
            color: Colors.black12,
            width: 0.5,
          )),
          color: Colors.white),
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
