import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:simollu_front/models/fork_model.dart';
import 'package:simollu_front/models/restaurant_model.dart';
import 'package:simollu_front/models/reviewModel.dart';
import 'package:simollu_front/services/user_api.dart';
import 'package:simollu_front/utils/token.dart';

class UserViewModel extends GetxController {
  Uri baseUri = Uri.parse('https://simollu.com');
  String token = ""; // 'late' 키워드를 사용하여 초기화를 뒤로 미룸
  RxString nickname = "".obs;
  RxString image = "".obs;
  RxInt fork = (-1).obs;
  RxList<ForkModel> forkList = <ForkModel>[].obs;
  RxList<RestaurantModel> interestRestaurantList = <RestaurantModel>[].obs;
  // Rx<File?> profileImage = Rx<File?>(null);
  Rx<File?> updatedProfileImage = Rx<File?>(null);

  Future<void> initialize() async {
    token = await getToken(); // getToken() 함수의 반환값을 대입
  }

  Future<bool> postInterestRestaurant(restaurantSeq) async {
    bool response = await UserAPI().postInterestRestaurant(restaurantSeq);

    return response;
  }

  Future<void> getInterestRestaurant() async {
    interestRestaurantList.value = await UserAPI().getInterestRestaurants();
  }

  // [GET] User 프로필 이미지 조회
  Future<void> getProfileImage() async {
    await initialize();

    String newImage = "";

    Uri uri = baseUri.resolve("/api/user/user/profile-image");
    final response = await http.get(headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": token
    }, uri);

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      newImage = jsonDecode(responseBody)['userProfileUrl'];
      image(newImage);
    }
  }

  // [GET] User 닉네임 조회
  Future<void> getNickname() async {
    await initialize();

    String newNickname = "";

    Uri uri = baseUri.resolve("/api/user/user/nickname");
    final response = await http.get(headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": token
    }, uri);
    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      newNickname = jsonDecode(responseBody)['userNicknameContent'];

      nickname(newNickname);
    }
  }

  // [POST] User 닉네임 수정
  Future<bool> postNickname(String nickname) async {
    Uri uri = baseUri.resolve("/api/user/user/nickname");

    await initialize();

    final response = await http.post(headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": token
    }, body: json.encode({"userNicknameContent": nickname}), uri);

    print(response);
    print("post @@@@@" + response.body);

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      final jsonResponse = jsonDecode(responseBody);
      nickname = jsonResponse['userNicknameContent'];
      this.nickname(nickname);
      return true;
    }
    return false;
  }

  // [GET] User 포크 수 조회
  Future<void> getForkNumber() async {
    Uri uri = baseUri.resolve("/api/user/user/fork");

    await initialize();

    int fork = 0;

    final response = await http.get(headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": token
    }, uri);

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      fork = jsonDecode(responseBody)['userFork'];
      this.fork.value = fork;
      print(fork);
    }
  }

  // 프로필 이미지 변경
  Future<void> onChangeProfileImage() async {
    await initialize();
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      updatedProfileImage.value = File(pickedImage.path);
    }
  }

  // [POST] User 프로필 이미지 변경
  Future<bool> updateProfileImage() async {
    Uri uri = baseUri.resolve("/api/user/user/profileImage");

    if (updatedProfileImage.value == null) {
      return true;
    }

    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll({
      "Authorization": token,
    });

    // 파일 첨부
    request.files.add(
      await http.MultipartFile.fromPath(
          'file', updatedProfileImage.value!.path),
    );

    var response = await request.send();

    if (response.statusCode == 200) {
      await getProfileImage();
      updatedProfileImage.value = null;
      return true;
    }

    return false;
  }

  // [GET] User 포크 내역 리스트 조회
  Future<void> getForkList() async {
    Uri uri = baseUri.resolve("/api/user/user/fork-list");

    await initialize();

    List<ForkModel> forkList = [];

    final response = await http.get(headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": token
    }, uri);
    print("---------@@@@@" + response.body);

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      List<dynamic> res = jsonDecode(responseBody);

      for (dynamic r in res) {
        forkList.add(ForkModel.fromJson(r));
      }
      this.forkList.value = forkList;
    }
  }
}
