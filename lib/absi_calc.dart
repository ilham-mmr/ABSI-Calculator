import 'dart:math';

import 'package:absi_calc_lab1/absi_data.dart';
import 'package:flutter/cupertino.dart';

class AbsiCalc with ChangeNotifier {
  int _height = 0;
  int _weight = 0;
  int _waist = 0;
  int _age = 0;
  AbsiData _absiData = AbsiData();
  double _absiMean = 0.0;
  double _absiSD = 0.0;
  double _absi = 0.0;
  double _absiZ = 0.0;
  String _result = '';

  String gender = 'male';

  void setData({age, height, waist, weight}) {
    this._age = age;
    this._height = height;
    this._weight = weight;
    this._waist = waist;
  }

  void getABSIData() {
    var data = [];
    if (gender == 'male') {
      data = _absiData.dataMale;
      data.forEach((element) {
        if (_age == int.parse(element['name'])) {
          _absiMean = double.parse(element['values']['ABSIMean']);
          _absiSD = double.parse(element['values']['ABSISD']);
        }
      });
    } else {
      data = _absiData.dataFemale;
      data.forEach((element) {
        if (_age == int.parse(element['name'])) {
          _absiMean = double.parse(element['values']['ABSIMean']);
          _absiSD = double.parse(element['values']['ABSISD']);
        }
      });
    }
  }

  void setGender(String gender) {
    this.gender = gender;
  }

  double _convertToM(int num) {
    return num / 100.00;
  }

  double _calculateBMI(int height, int weight) {
    double heightInCM = _convertToM(height);
    return weight / (pow(heightInCM, 2));
  }

  void _calculateABSI() {
    double waistInCM = _convertToM(_waist);
    double bmi = _calculateBMI(_height, _weight);
    double heightInCm = _convertToM(_height);

    _absi = waistInCM / (pow(bmi, 2 / 3) * pow(heightInCm, 1 / 2));
  }

  void _calculateABSIzScore() {
    getABSIData();
    _absiZ = (_absi - _absiMean) / _absiSD;
  }

  void calculateAbsiAndAbsiZ() {
    _calculateABSI();
    _calculateABSIzScore();
    calculateResult();
    notifyListeners();
  }

  get absi {
    return _absi.toStringAsFixed(4);
  }

  get absiz {
    return _absiZ.toStringAsFixed(4);
  }

  get result {
    return _result;
  }

  String calculateResult() {
    if (_absiZ < -0.868) {
      _result = 'very low 👌';
    } else if (_absiZ >= -0.868 && _absiZ < -0.272) {
      _result = 'low 👍';
    } else if (_absiZ >= -0.272 && _absiZ < 0.229) {
      _result = 'average ✔️';
    } else if (_absiZ >= 0.229 && _absiZ < 0.798) {
      _result = 'high ❗';
    } else if (_absiZ >= 0.798) {
      _result = '❗❗';
    }

    return _result;
  }
}
