import 'package:flutter/material.dart';

class TipCalculatorModel with ChangeNotifier {
  int _personCount = 1;
  double _tipPercentage = 0.0;
  double _billTotal = 0.0;
  double _totalPerPerson = 0.0;

  //getters
  double get billTotal => _billTotal;
  int get personCount => _personCount;
  double get tipPercentage => _tipPercentage;
  double get totalPerPerson => _totalPerPerson;
  void logDetails(int personCount, double tipPercentage, double billTotal,
      double totalPerPerson) {
    print(
        "Person: $personCount, TipPercentage: $tipPercentage, TotalBill: $billTotal, TotalBillPerPerson: $totalPerPerson");
  }

  void updateBillTotal(double billTotal) {
    _billTotal = billTotal;
    calculateTotalPerPerson();
    notifyListeners();
  }

  void updateTipPercentage(double tipPercentage) {
    _tipPercentage = tipPercentage;
    calculateTotalPerPerson();
    notifyListeners();
  }

  void incrementPersonCount() {
    _personCount++;
    calculateTotalPerPerson();
    notifyListeners();
  }

  void decrementPersonCount() {
    if (_personCount > 1) {
      _personCount--;
      calculateTotalPerPerson();
      notifyListeners();
    }
  }

  void calculateTotalPerPerson() {
    logDetails(personCount, tipPercentage, billTotal, totalPerPerson);
    _totalPerPerson =
        (_billTotal + (_billTotal * _tipPercentage)) / _personCount;
    notifyListeners();
  }
}
