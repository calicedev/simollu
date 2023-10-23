import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/default_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simollu_front/models/notification_model.dart';
import 'package:simollu_front/viewmodels/notification_view_model.dart';
import 'package:simollu_front/views/review_management_page.dart';
import 'package:simollu_front/widgets/custom_appBar.dart';

import '../root.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late Future<List<NotificationModel>> alerts = Future<List<NotificationModel>>.value([]);
  final NotificationViewModel _notificationViewModel = NotificationViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // alerts = NotificationViewModel.fetchAlerts();
    // print(alerts);
    alerts = _notificationViewModel.fetchAlerts();
    alerts.then((res) => 
      _notificationViewModel.processIsRead(res)
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '알림 보기',
        leading: Image.asset('assets/backBtn.png'),
        actions: [Image.asset('assets/bell.png')],
      ),
      body: FutureBuilder(
          future: alerts,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.notifications_off_outlined,
                        size: 90,
                      ),
                      SizedBox(height: 20),
                      Text('확인 가능한 알림이 없습니다.',
                        style: TextStyle(
                          fontSize: 18
                        ),
                      )
                    ],
                  )
                );
              }
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  NotificationModel alert = snapshot.data![index];
                  String? registDate = alert.alertRegistDate?.split('T')[0];
                  return Padding(
                    padding: EdgeInsets.fromLTRB(10, 8, 10, 10),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black12,
                          ),
                        ),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.fromLTRB(20, 5, 12, 12),
                        horizontalTitleGap: 20,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(alert.alertTitle as String,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(alert.alertContent as String),
                            SizedBox(height: 8),
                          ],
                        ),
                        leading: Icon(Icons.edit_outlined, size: 40),
                        trailing: alert.alertTitle == '리뷰 작성' ?
                        IconButton(
                            onPressed: () {
                              RootController.to.setRootPageTitles("작성 리뷰");
                              RootController.to.setIsMainPage(false);
                              Navigator.push(
                                context,
                                GetPageRoute(
                                  curve: Curves.fastOutSlowIn,
                                  page: () => ReviewManagementPage(),
                                ),
                              );
                            },
                            icon: Icon(Icons.arrow_forward_ios)
                        ) : null,
                        subtitle: Text(registDate as String),
                        iconColor: Colors.black,
                      ),
                    ),
                  );
                },
              );
            } else {
              return Card();
            }
          }
      )

      // body: SingleChildScrollView(
      //   child: Container(
      //     width: double.infinity,
      //     color: Colors.white,
      //     child: buildListView(),
      //   ),
      // ),
    );
  }

  ListView buildListView() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.fromLTRB(10, 8, 10, 10),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black12,
                ),
              ),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.fromLTRB(20, 10, 15, 15),
              horizontalTitleGap: 30,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('동래정 맛있게 드셨나요?'),
                  Text('리뷰 쓰고 포크 받아보세요~!'),
                  SizedBox(height: 8),
                ],
              ),
              leading: Icon(Icons.edit_outlined, size: 40),
              trailing: Icon(Icons.arrow_forward_ios),
              subtitle: Text('3일 전'),
              iconColor: Colors.black,
            ),
          ),
        );
      },
    );
  }

}
