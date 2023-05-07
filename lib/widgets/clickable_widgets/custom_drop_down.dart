import 'package:flutter/material.dart';

Widget customDropDown(List<String> item, String value, void onChange(val)) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
    child: DropdownButton<String>(
      value: value,
      onChanged: (val) {
        onChange(val);
      },
      items: item.map<DropdownMenuItem<String>>((String val) {
        return DropdownMenuItem(
          value: val,
          child: Text(val),
        );
      }).toList(),
    ),
  );
}
