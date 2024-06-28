import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttter_alarm_app/Utils/alarm_utils.dart';
import 'package:fluttter_alarm_app/models/alarm.dart';
import 'package:fluttter_alarm_app/provider/alarm_provider.dart';
// import 'package:google_fonts/google_fonts.dart';

class AlarmW extends ConsumerWidget {
  const AlarmW({super.key, required this.alarm, required this.id});

  final Alarm alarm;
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Alarm alarmParam = alarm;
    return Dismissible(
      key: Key(id.toString()),
      onDismissed: (direction) {
        ref.read(alarmProvider).deleteAlarm(id: id);
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 15),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 39, 23),
        ),
        child: const Text(
          'supprimer',
          textScaler: TextScaler.linear(1.3),
          style: TextStyle(color: Colors.white),
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: .3, color: Colors.grey))),
        child: SwitchListTile.adaptive(
            controlAffinity: ListTileControlAffinity.platform,
            contentPadding: const EdgeInsets.all(0),
            title: ListTile(
              subtitle: Text(
                'Alarme. Coder non stop',
                textScaler: const TextScaler.linear(1.2),
                style: TextStyle(color: alarmParam.activateAlarmColor),
              ),
              title: Text(
                "${addZero(alarmParam.effectiveTime.hour)}:${addZero(alarmParam.effectiveTime.minute)}",
                textScaler: const TextScaler.linear(2.6),
                style: TextStyle(
                    color: alarmParam.activateAlarmColor,
                    fontWeight: FontWeight.w400),
              ),
            ),
            value: alarmParam.isActivated,
            onChanged: (isDesable) {
              ref.watch(alarmProvider).toggleAlarm(id, isDesable);
            }),
      ),
    );
  }
}
