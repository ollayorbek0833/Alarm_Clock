import 'package:alarm_clock_app/models/menu_info.dart';
import 'package:alarm_clock_app/pages/stopwatch_page.dart';
import 'package:alarm_clock_app/pages/timer_page.dart';
import 'package:alarm_clock_app/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../data.dart';
import '../enum.dart';
import 'alarm_page.dart';
import 'clock_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEE, d MMM').format(now);
    var timeZoneString = now.timeZoneOffset.toString().split(".").first;
    var offSetSign = '';
    if (!timeZoneString.startsWith('-')) offSetSign = '+';
    return Scaffold(
      backgroundColor: const Color(0xff2D2F41),
      body: Row(
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: menuItems
                  .map((currentMenuInfo) => buildMenuButton(currentMenuInfo))
                  .toList()),
          const VerticalDivider(
            color: Colors.white54,
            width: 1,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (BuildContext context, MenuInfo value, Widget? child) {
                if(value.menuType == MenuType.clock)return ClockPage();
                else if(value.menuType == MenuType.alarm) return AlarmPage();
                else if(value.menuType == MenuType.timer) return TimerPage();
                else return const StopwatchPage();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget? child) {
        return Container(
          width: 92,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topRight: Radius.circular(23)),
            color: currentMenuInfo.menuType == value.menuType
        ? CustomColors.menuBackgroundColor
        : Colors.transparent,),
          child: TextButton(
            onPressed: () {
              var menuInfo = Provider.of<MenuInfo>(context, listen: false);
              menuInfo.updateMenu(currentMenuInfo);
            },
            child: Column(
              children: <Widget>[
                Image.asset(currentMenuInfo.imageSource.toString(), width: 30),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  currentMenuInfo.title ?? "",
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
