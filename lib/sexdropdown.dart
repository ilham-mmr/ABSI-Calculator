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
          AbsiCalc absiCalc = Provider.of<AbsiCalc>(context, listen: false);
          absiCalc.gender = value;
          absiCalc.calculateABSI();
          absiCalc.calculateABSIzScore();
          absiCalc.makeInterpretation();
          final snackBar = SnackBar(
            duration: Duration(seconds: 2),
            content: Text(value == 'male'
                ? 'Successfully calculated for male!'
                : 'Successfully calculated for female!'),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
