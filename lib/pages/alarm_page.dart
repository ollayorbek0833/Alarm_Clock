import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../data.dart';
import '../constants/theme.dart';
import '../main.dart';
import '../models/alarm_info.dart';
import'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Alarm',
              style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.w700,
                color: CustomColors.primaryTextColor,
                fontSize: 24,
              )),
          Expanded(
            child: ListView(
              children: alarms
                  .map<Widget>((alarm) {
                    var alarmTime = DateFormat('hh:mm aa').format(alarm.alarmDateTime);
                    return Container(
                      margin: const EdgeInsets.only(bottom: 32),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: alarm.gradientColors!.last
                                    .withOpacity(0.4),
                                blurRadius: 8,
                                spreadRadius: 2,
                                offset: const Offset(4, 4)),
                          ],
                          gradient: LinearGradient(
                              colors: alarm.gradientColors!.toList(),
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(24))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: [
                                  const Icon(
                                    Icons.label,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Office',
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              Switch(
                                onChanged: (bool value) {},
                                value: true,
                                activeColor: Colors.white,
                              )
                            ],
                          ),
                          Text(
                            'Mon-Fri',
                            style: GoogleFonts.nunitoSans(
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                alarmTime ,
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                                size: 36,
                              )
                            ],
                          )
                        ],
                      ),
                    );
              })
                  .followedBy([
                    if(alarms.length<5)
                      DottedBorder(
                        strokeWidth: 2,
                        color: CustomColors.clockOutline,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(24),
                        dashPattern: const [5, 4],
                        child: Container(
                          width: double.infinity  ,
                          decoration: BoxDecoration(
                              color: CustomColors.clockBG,
                              borderRadius: const BorderRadius.all(Radius.circular(24))),
                          child: TextButton(
                            onPressed: () {
                              scheduleAlarm();
                              print(tz.TZDateTime.now(tz.getLocation('Asia/Tashkent')));
                              print(DateTime.now());
                            },
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/add_alarm.png',
                                  scale: 1.5,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Add Alarm',
                                  style: GoogleFonts.nunitoSans(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                else const Text('Only 5 alarms allowed')
              ]).toList(),
            ),
          )
        ],
      ),
    );
  }

  void scheduleAlarm() async {
    var scheduleNotificationDateTime = tz.TZDateTime.now(tz.local).add(Duration(seconds: 10));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      channelDescription: 'Channel for Alarm notification',
      icon: 'logo',
      sound: RawResourceAndroidNotificationSound('sound'),
      largeIcon: DrawableResourceAndroidBitmap('logo'),
    );

    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Office',
        'Good Morning',
        scheduleNotificationDateTime,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      );
  }

}
