class Alarm {
  late DateTime alarmTime;

  Alarm({
    required this.alarmTime,
  });

  Alarm.fromJson(Map<String, dynamic> json) {
    alarmTime = DateTime.parse(json['alarmTime']);
  }

  Map<String, dynamic> toJson() => {
    'alarmTime' : alarmTime.toString(),
  };
}