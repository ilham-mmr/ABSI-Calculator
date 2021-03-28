import 'package:absi_calc_lab1/absi_calc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SexDropDown extends StatefulWidget {
  @override
  _SexDropDownState createState() => _SexDropDownState();
}

class _SexDropDownState extends State<SexDropDown> {
  String _dropdownValue = 'male';

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      style: TextStyle(color: Colors.white70),
      dropdownColor: Color(0xffc06014),
      underline: Container(),
      onChanged: (value) {
        setState(() {
          _dropdownValue = value;
          Provider.of<AbsiCalc>(context, listen: false).gender = value;
        });
      },
      value: _dropdownValue,
      items: [
        DropdownMenuItem(
          child: Text("Male"),
          value: 'male',
        ),
        DropdownMenuItem(
          child: Text("Female"),
          value: 'female',
        ),
      ],
    );
  }
}
