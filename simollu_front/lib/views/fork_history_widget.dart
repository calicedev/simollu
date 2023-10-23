import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ForkHistoryWidget extends StatelessWidget {
  final String rewardDate; // 날짜
  final String rewardState; // 사용, 적립
  final String rewardContent; // 회원 가입, 순서 미루기, 리뷰 작성
  final int rewardAmount; // 포크 수

  const ForkHistoryWidget({
    required this.rewardDate,
    required this.rewardState,
    required this.rewardAmount,
    Key? key, required this.rewardContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.93,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Colors.black12,
                    width: 0.5
                )
            )
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
          child: Column(
            children: [
              Row(
                children: [
                  Text('$rewardDate | ', style: TextStyle(color: Colors.grey), textAlign: TextAlign.left,),
                  Text(rewardState, style: TextStyle(color: Colors.amber)),
                  Text(" ("+rewardContent+")", style: TextStyle(color: Colors.amber),),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('${NumberFormat('###,###,###,###').format(rewardAmount)}개')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}