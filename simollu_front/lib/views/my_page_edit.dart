import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simollu_front/root.dart';

import '../viewmodels/user_view_model.dart';

class MyPageEdit extends StatefulWidget {
  final String name;

  MyPageEdit({Key? key, required this.name}) : super(key: key);

  @override
  _MyPageEditState createState() => _MyPageEditState();
}

class _MyPageEditState extends State<MyPageEdit> {
  late TextEditingController nameController;

  UserViewModel userViewModel = Get.find();

  Future postNickname(String text) async {
    bool nicknameStatus = await userViewModel.postNickname(text);
    bool profileImageStatus = await userViewModel.updateProfileImage();
    if (nicknameStatus && profileImageStatus) {
      RootController.to.onWillPop();
    }
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: userViewModel.nickname.value);
  }

  @override
  void dispose() {
    nameController.dispose();
    userViewModel.updatedProfileImage.value = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Stack(
                  children: [
                    Obx(
                      () => CircleAvatar(
                        radius: 50,
                        backgroundImage: userViewModel.image.value == ""
                            ? AssetImage("assets/logo.png")
                            : (userViewModel.updatedProfileImage.value == null
                                ? CachedNetworkImageProvider(
                                    userViewModel.image.value) as ImageProvider
                                : FileImage(
                                    userViewModel.updatedProfileImage.value!)),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          userViewModel.onChangeProfileImage();
                        },
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "닉네임",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: 0.8,
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  print('내 정보 수정' + nameController.value.text);
                  postNickname(nameController.value.text);
                },
                style: ButtonStyle(
                  splashFactory: NoSplash.splashFactory,
                  alignment: Alignment.center,
                  backgroundColor: MaterialStateProperty.all(
                    Color(0xFFFFD200),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    '수정하기',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
