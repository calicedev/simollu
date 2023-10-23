import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simollu_front/models/fork_model.dart';
import 'package:simollu_front/views/fork_history_widget.dart';

import '../viewmodels/user_view_model.dart';

class ForkRewardPage extends StatefulWidget {
  const ForkRewardPage({Key? key}) : super(key: key);

  @override
  State<ForkRewardPage> createState() => _ForkRewardPageState();
}

class _ForkRewardPageState extends State<ForkRewardPage> {
  UserViewModel userViewModel = Get.find();

  @override
  void initState() {
    super.initState();

    userViewModel.getForkList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          width: double.infinity,
          color: Colors.white,
          height: 100,
          child: FractionallySizedBox(
            widthFactor: 0.9,
            heightFactor: 0.7,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/Fork_small.png',
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('보유 포크', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                                text: userViewModel.fork.toString(),
                                style: TextStyle(
                                    color: Colors.amber, fontSize: 20)),
                            TextSpan(text: "개", style: TextStyle(fontSize: 18))
                          ]),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: Container(
              color: Colors.white,
              width: double.infinity,
              child: ListView.builder(
                itemCount: userViewModel.forkList.value.length,
                itemBuilder: (context, index) {
                  final list = userViewModel.forkList.value[index];
                  return ForkHistoryWidget(
                    rewardAmount: list.userForkAmount,
                    rewardDate: list.userForkRegisterDate,
                    rewardState: list.userForkType,
                    rewardContent: list.userForkContent,
                  );
                },
              )),
        )
      ],
    ));
  }
}
