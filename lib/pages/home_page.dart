import 'package:alarm_clock_task/models/alarm_model.dart';
import 'package:alarm_clock_task/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Alarm> alarms = [];

  void loadAlarms() {
    setState(() {
      alarms = DBService.loadAlarms();
    });
  }

  String chackWeek(int index) {
    switch(index) {
      case 1 : {return "Dushanba";}
      case 2 : {return "Seshanba";}
      case 3 : {return "Chorshanba";}
      case 4 : {return "Payshanba";}
      case 5 : {return "Juma";}
      case 6 : {return "Shanba";}
      default: {return "Yakshanba";}
    }
  }

  @override
  void initState() {
    loadAlarms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2D2F41),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("Alarm Clock"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (alarms.isNotEmpty) ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: alarms.length,
              itemBuilder: (context,index) {
                return GestureDetector(
                  onTap: () {
                    FlutterAlarmClock.showAlarms();
                  },
                  child: Container(
                    height: 142,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.purple, Colors.red],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 2,
                          offset: const Offset(4, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                "${alarms[index].alarmTime.day}.${alarms[index].alarmTime.month}.${alarms[index].alarmTime.year}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          chackWeek(alarms[index].alarmTime.weekday),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          "${alarms[index].alarmTime.hour}:${alarms[index].alarmTime.minute}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ) else const SizedBox.shrink(),
            GestureDetector(
              onTap: () {
                DatePicker.showTimePicker(context, onConfirm: (date) {
                  FlutterAlarmClock.createAlarm(date.hour, date.minute);
                  List<Alarm> item = DBService.loadAlarms();
                  Alarm clock = Alarm(alarmTime: date);
                  item.add(clock);
                  setState(() {
                    alarms = item;
                    DBService.storeAlarms(item);
                  });
                });
              },
              child: Container(
                height: 150,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blueGrey,
                  border: Border.all(color: Colors.white, width: 0.5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.add_alarm,
                      color: Colors.blue,
                      size: 45,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Add Alarm",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
