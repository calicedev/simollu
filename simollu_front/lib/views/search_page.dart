import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simollu_front/views/restaurant_detail_page.dart';
import 'package:simollu_front/views/search_initial_widget.dart';
import 'package:simollu_front/views/search_result_page.dart';

import '../models/searchModel.dart';
import '../viewmodels/search_view_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

const routeA = "/";
const routeB = "/B";
const routeC = "/C";

class _SearchPageState extends State<SearchPage> {
  // 화면이동을 위한 globalKey 상태 관리
  final _navigatorKey = GlobalKey<NavigatorState>();
  final TextEditingController _filter = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _searchText = "";
  bool _canPop = false;

  late List<SearchModel> result = [];

  SearchViewModel searchViewModel = SearchViewModel();

  _SearchPageState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }

  _onPressedHotKeyword(String keyword) async{
    // 검색 api 연결
    result = (await searchViewModel.getSearchResult(keyword)).cast<SearchModel>();

    await searchViewModel.setSearchResult(result);

    // 검색 결과 페이지로 이동
    _navigatorKey.currentState?.pushNamed(routeB);

    setState(() {
      _canPop = true;
      _searchText = keyword;
    });
  }


  bool _onPopPage(Route<dynamic> route, dynamic result) {
    bool canPop = _navigatorKey.currentState?.canPop() ?? false;
    setState(() {
      _canPop = canPop;
    });
    return route.didPop(result);
  }

  MaterialPageRoute _onGenerateRoute(RouteSettings setting) {
    if (setting.name == routeA) {
      return MaterialPageRoute<dynamic>(
          builder: (context) => SearchInitialWidget(onPressedHotKeyword: _onPressedHotKeyword,), settings: setting);
    }
    else if (setting.name == routeB) {
      return MaterialPageRoute<dynamic>(
          builder: (context) => SearchResultPage(searchResults: result,), settings: setting);
    }
    else {
      throw Exception('Unknown route: ${setting.name}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: _canPop
              ? IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.black54,
                  onPressed: () {
                    _navigatorKey.currentState?.pop();
                    bool temp = _navigatorKey.currentState?.canPop() ?? false;
                    setState(() {
                      _canPop = temp;
                    });
                  },
                )
              : null,
          title: Container(
            height: 45,
            margin: EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white70,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  // spreadRadius: 2,
                  // blurRadius: 3,
                  // offset: Offset(0, 3),
                ),
              ],
            ),
            child: TextField(
              cursorColor: Colors.amber,
              focusNode: focusNode,
              autofocus: true,
              controller: _filter,
              onSubmitted: (value) async {
                // 사용자가 입력한 검색어 처리하는 코드 작성
                print('사용자 검색 엔터');
                print(value);

                // 최근 검색어 저장
                RecentSearches.save(value);

                RecentSearches.printRecentSearches();

                setState(() {
                  // _hasNotSearchResult = false;
                  // _hasSearchResult = true;
                  _canPop = true;
                });

                // 검색 api 연결
                result = (await searchViewModel.getSearchResult(value)).cast<SearchModel>();

                await searchViewModel.setSearchResult(result);
                
                // 검색 결과 페이지로 이동
                _navigatorKey.currentState?.pushNamed(routeB);
              },
              onEditingComplete: () {

                },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                suffixIcon: focusNode.hasFocus
                    ? IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.grey,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            _filter.clear();
                            _searchText = "";
                          });
                        },
                      )
                    : Container(),
                alignLabelWithHint: true,
                // contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                hintText: '매장을 검색해보세요',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0,
                  wordSpacing: 0,
                  height: 1.0,
                  shadows: [],
                  decoration: TextDecoration.none,
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                // border: InputBorder.none,
                //
              ),
              // TextField 구성 요소 생략
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          // padding: EdgeInsets.only(bottom: 13),
          child:
             Container(
              color: Colors.white,
              child: Navigator(
                key: _navigatorKey,
                onPopPage: _onPopPage,
                initialRoute: routeA,
                onGenerateRoute: _onGenerateRoute,
              ),
            ),

        ),
      ),
    );
  }
}

class RecentSearches {
  static const _key = 'recentSearches';

  // 최근 검색어를 저장하는 메소드
  static Future<void> save(String query) async {
    final prefs = await SharedPreferences.getInstance();
    final recentSearches = prefs.getStringList(_key) ?? [];
    recentSearches.insert(0, query); // 새로운 검색어를 최상단에 추가
    await prefs.setStringList(_key, recentSearches);
  }

  // 최근 검색어 목록을 불러오는 메소드
  static Future<List<String>> load() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  // 최근 검색어 목록을 삭제하는 메소드
  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  // 최근 검색어 목록을 출력하는 메소드
  static Future<void> printRecentSearches() async {
    final recentSearches = await load();
    print('Recent searches:');
    for (final query in recentSearches) {
      print(query);
    }
  }

  // 최근 검색어를 업데이트하는 메소드
  static Future<void> update(String newQuery) async {
    final prefs = await SharedPreferences.getInstance();
    final recentSearches = prefs.getStringList(_key) ?? [];

    // 이전 검색어가 목록에 없으면 새 검색어를 최상단에 추가
    if (!recentSearches.contains(newQuery)) {
      recentSearches.insert(0, newQuery);

      // 검색어가 10개를 초과하면 마지막 항목을 제거
      if (recentSearches.length > 10) {
        recentSearches.removeLast();
      }
    } else {
      // 이전 검색어를 새 검색어로 대체
      final index = recentSearches.indexOf(newQuery);
      recentSearches.removeAt(index);
      recentSearches.insert(0, newQuery);
    }

    // // 이전 검색어를 새 검색어로 대체
    // final index = recentSearches.indexOf(newQuery);
    // if (index != -1) {
    //   recentSearches.removeAt(index);
    //   recentSearches.insert(0, newQuery);
    //   // recentSearches[index] = newQuery;
    // } else {
    //   // 이전 검색어가 목록에 없으면 새 검색어를 최상단에 추가
    //   recentSearches.insert(0, newQuery);
    // }

    await prefs.setStringList(_key, recentSearches);
  }
}
