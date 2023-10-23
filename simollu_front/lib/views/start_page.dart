import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simollu_front/root.dart';
import 'package:simollu_front/utils/token.dart';
import 'package:simollu_front/views/login_page.dart';
import 'package:get/get.dart';
import 'package:simollu_front/views/writing_review_page.dart';

// final Uri _url = Uri.parse('https://simollu.com/api/user/oauth2/authorization/kakao');

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String token = "";

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    _readLoginInfo();
  }

  Future<void> _readLoginInfo() async {
    token = await getToken();
    if(token != "") {
      Get.offAll(Root());
    }
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 20),
              Image.asset(
                  'assets/logo.png',
                  width: 300,
              ),
              InkWell(
                onTap: () {
                  Get.to(MyWebView());
                } ,
                child: Image.asset(
                  'assets/kakao_login_large_wide 1.png'
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GetToken {
  final List<String> _key = ['token', 'initial'];

  Future<String> isTokenExists() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_key[0]);
    // final initial = prefs.getBool(_key[1]);
    return token ?? '';
  }
}
