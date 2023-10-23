import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Widget leading;
  final List<Widget> actions;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.leading,
    required this.actions,
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  void _goBack(BuildContext context) {
    // Get.back();
    Navigator.pop(context);
  }

  void _showNotificationScreen(BuildContext context) {
    // 알림 화면을 표시하는 코드
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        style: TextStyle(
            color: Colors.black
        ),),
      centerTitle: true,
      leading: IconButton(
        onPressed: () => _goBack(context),
        icon: widget.leading,
      ),
      actions: [
        InkWell(
          onTap: () => _showNotificationScreen(context),
          child: widget.actions[0],
        ),
      ],
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
