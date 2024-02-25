import 'package:flutter/material.dart';

import '../colors.dart';

class RadioListComponent extends StatefulWidget {
  final Function(String) feedBackList;
  final String timeFormat;
  const RadioListComponent({super.key, required this.feedBackList, required this.timeFormat});

  @override
  State<RadioListComponent> createState() => _RadioListComponentState();
}

class _RadioListComponentState extends State<RadioListComponent> {
  String group = '24h';

  void setvalue(String? val) {
    if (val == null || val == group) return;
    setState(() {
      group = val;
    });

    widget.feedBackList(group);
  }

  @override
  void initState() {
    group=widget.timeFormat;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant RadioListComponent oldWidget) {
    // TODO: implement didUpdateWidget
    group=widget.timeFormat;
    super.didUpdateWidget(oldWidget);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        itemRadio(
          title: '15 Minutes',
          value: '15m',
          group: group,
          onChanged: setvalue,
        ),
        itemRadio(
          title: '30 Minutes',
          value: '30m',
          group: group,
          onChanged: setvalue,
        ),
        itemRadio(
          title: '1 Hour',
          value: '1h',
          group: group,
          onChanged: setvalue,
        ),
        itemRadio(
          title: '5 Hour',
          value: '5h',
          group: group,
          onChanged: setvalue,
        ),
        itemRadio(
          title: '10 Hour',
          value: '10h',
          group: group,
          onChanged: setvalue,
        ),
        itemRadio(
          title: '24 Hour',
          value: '24h',
          group: group,
          onChanged: setvalue,
        ),
      ],
    );
  }

  Widget itemRadio(
      {required String title,
      required String value,
      required String group,
      required Function(String?) onChanged}) {
    return RadioListTile(
      value: value,
      groupValue: group,
      onChanged: onChanged,
      title: Text(
        title,
        style: const TextStyle(color: MyColors.activeTextColor),
      ),
      activeColor: Colors.lightGreen,
    );
  }
}
