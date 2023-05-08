import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';

class NotificationTiles extends StatefulWidget {
  final String title, subtitle;
  final VoidCallback ontap;
  final bool enable;
  const NotificationTiles({
    super.key,
    required this.title,
    required this.subtitle,
    required this.ontap,
    required this.enable,
  });

  @override
  State<NotificationTiles> createState() => _NotificationTilesState();
}

class _NotificationTilesState extends State<NotificationTiles> {
  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    return ListTile(
      focusColor:
          themeListener.isDark ? darkBackroundContinarColor : secondeyTextColor,
      leading: SizedBox(
        height: 30.0,
        width: 30.0,
        child: CircleAvatar(
          backgroundColor: themeListener.isDark ? greyColor : greyTextColor,
          child: const Icon(
            Icons.notifications_on,
            color: mainColor,
          ),
        ),
      ),
      title: Text(widget.title,
          style: TextStyle(
            color: themeListener.isDark ? secondeyTextColor : Colors.black87,
            fontSize: 14,
          )),
      subtitle: Text(widget.subtitle,
          style: TextStyle(
            color: themeListener.isDark ? secondeyTextColor : Colors.black87,
            fontSize: 12,
          )),
      onTap: widget.ontap,
      enabled: widget.enable,
    );
  }
}
