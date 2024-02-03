import 'package:alarm_clock_app/constants/theme.dart';
import 'package:alarm_clock_app/enum.dart';

import 'models/menu_info.dart';
import 'models/alarm_info.dart';

List<MenuInfo> menuItems = [
  MenuInfo(MenuType.clock, title: 'Clock', imageSource: 'assets/clock.png'),
  MenuInfo(MenuType.alarm, title: 'Alarm', imageSource: 'assets/alarm.png'),
  MenuInfo(MenuType.timer, title: 'Timer', imageSource: 'assets/timer.png'),
  MenuInfo(MenuType.stopwatch, title: 'Stopwatch', imageSource: 'assets/stopwatch.png'),
];


List<AlarmInfo> alarms = [
  AlarmInfo(DateTime.now().add(Duration(hours: 1)),description: 'Office',gradientColors: GradientColors.fire),
  AlarmInfo(DateTime.now().add(Duration(hours: 2)),description: 'Sport',gradientColors: GradientColors.mango),
];