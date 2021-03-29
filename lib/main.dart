import 'package:absi_calc_lab1/absi_calc.dart';
import 'package:absi_calc_lab1/sexdropdown.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController waistController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (BuildContext context) => AbsiCalc(),
        child: Scaffold(
          backgroundColor: Color(0xff424642),
          appBar: AppBar(
            backgroundColor: Color(0xcff424642),
            title: Center(
              child: Text(
                'ABSI Calculator',
                style: TextStyle(
                  color: Color(0xfff3f4ed),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.fromLTRB(16, 24, 16, 12),
                    color: Colors.orange,
                    child: Consumer<AbsiCalc>(
                      builder: (BuildContext context, absiCalc, _) {
                        return Column(
                          children: [
                            Text(
                              'ABSI: ${absiCalc.absi}',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 24),
                            ),
                            Text(
                              'ABSI z-score: ${absiCalc.absiz}',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 24),
                            ),
                            Text(
                              absiCalc.result != ''
                                  ? 'According to your ABSI z score, your premature mortality risk is  ${absiCalc.result}'
                                  : 'According to your ABSI z score, your premature mortality risk is -',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Color(0xffc06014),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        labelInput(
                          title: 'Sex',
                          content: SexDropDown(),
                        ),
                        labelInput(
                          title: 'Age',
                          content: Container(
                            width: 50,
                            child: TextField(
                                controller: ageController,
                                style: TextStyle(color: Colors.white70),
                                decoration: InputDecoration(
                                  helperStyle: TextStyle(color: Colors.white54),
                                  suffix: Text(
                                    'years',
                                    style: TextStyle(color: Colors.white54),
                                  ),
                                ),
                                textAlign: TextAlign.center,
                                maxLength: 3,
                                keyboardType: TextInputType.number),
                          ),
                        ),
                        labelInput(
                          title: 'Height',
                          content: Container(
                            width: 50,
                            child: TextField(
                                controller: heightController,
                                style: TextStyle(color: Colors.white70),
                                decoration: InputDecoration(
                                  helperStyle: TextStyle(color: Colors.white54),
                                  suffix: Text(
                                    'cm',
                                    style: TextStyle(color: Colors.white54),
                                  ),
                                ),
                                textAlign: TextAlign.center,
                                maxLength: 3,
                                keyboardType: TextInputType.number),
                          ),
                        ),
                        labelInput(
                          title: 'Weight',
                          content: Container(
                            width: 50,
                            child: TextField(
                                controller: weightController,
                                style: TextStyle(color: Colors.white70),
                                decoration: InputDecoration(
                                  helperStyle: TextStyle(color: Colors.white54),
                                  suffix: Text(
                                    'kg',
                                    style: TextStyle(color: Colors.white54),
                                  ),
                                ),
                                textAlign: TextAlign.center,
                                maxLength: 3,
                                keyboardType: TextInputType.number),
                          ),
                        ),
                        labelInput(
                          title: 'Waist Circumference',
                          content: Container(
                            width: 50,
                            child: TextField(
                                controller: waistController,
                                style: TextStyle(color: Colors.white70),
                                decoration: InputDecoration(
                                  helperStyle: TextStyle(color: Colors.white54),
                                  suffix: Text(
                                    'cm',
                                    style: TextStyle(color: Colors.white54),
                                  ),
                                ),
                                textAlign: TextAlign.center,
                                maxLength: 3,
                                keyboardType: TextInputType.number),
                          ),
                        ),
                        Consumer<AbsiCalc>(
                          builder: (context, absiCalc, _) => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.orange, // background
                              onPrimary: Colors.white, // foreground
                            ),
                            onPressed: () {
                              if (heightController.text == '' ||
                                  weightController.text == '' ||
                                  waistController.text == '' ||
                                  heightController.text == '' ||
                                  ageController.text == '') {
                                final snackBar = SnackBar(
                                  duration: Duration(seconds: 2),
                                  content:
                                      Text('Please fill in the form properly!'),
                                );

                                // Find the ScaffoldMessenger in the widget tree
                                // and use it to show a SnackBar.
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                int height = int.parse(heightController.text);
                                int weight = int.parse(weightController.text);
                                int waist = int.parse(waistController.text);
                                int age = int.parse(ageController.text);

                                absiCalc.setData(
                                  age: age,
                                  height: height,
                                  waist: waist,
                                  weight: weight,
                                );
                                absiCalc.calculateABSI();
                                absiCalc.calculateABSIzScore();
                                absiCalc.makeInterpretation();
                                final snackBar = SnackBar(
                                  duration: Duration(seconds: 2),
                                  content: Text('Successfully calculated!'),
                                );

                                // Find the ScaffoldMessenger in the widget tree
                                // and use it to show a SnackBar.
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            child: Text(
                              'Calculate Result',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container labelInput({String title, Widget content}) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Color(0xfff3f4ed),
              ),
            ),
          ),
          Expanded(child: content)
        ],
      ),
    );
  }
}
