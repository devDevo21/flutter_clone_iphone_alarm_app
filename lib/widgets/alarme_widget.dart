import 'package:flutter/material.dart';

class AlarmItem extends StatefulWidget {
  const AlarmItem({super.key});

  @override
  State<AlarmItem> createState() => _AlarmItemState();
}

class _AlarmItemState extends State<AlarmItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        SwitchListTile.adaptive(
          title: const ListTile(
            title: Text('data'),
          ),
          value: true, 
          onChanged: (v){}
        )
      ],),
    );
  }
}