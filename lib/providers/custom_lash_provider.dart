import 'package:flutter/cupertino.dart';

class CustomLashProvider extends ChangeNotifier {
  PageController pageController = PageController();
  double zoneValue = 10;
  double volumeValue = 0.5;
  List<double> volumeTextList = [0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4];
  List<double> zoneValues = List.generate(15, (index) => 0);
  List<String?> customBendValues = List.generate(15, (index) => null);
  List<bool> zoneValuesEnabled = List.generate(15, (index) => true);
  bool isBlack = true;
  List<String> bendSizes = ["B", "C", "C+", "D", "CC", "L", "M", "LC", "LD"];
  int selectedBend = 0;

  Future<void> setZoneValue(double value) async {
    int len = 0;
    zoneValue = value;
    customBendValues = List.generate(15, (index) => null);
    while (value != len - 1) {
      len++;
      customBendValues[len] = 'B';
    }
    notifyListeners();
  }

  Future<void> updateZoneValuesEnabled(index) async {
    zoneValuesEnabled[index] = !zoneValuesEnabled[index];
    notifyListeners();
  }

  Future<void> updateIsBlack() async {
    isBlack = !isBlack;
    notifyListeners();
  }

  Future<void> setVolumeValue(double value) async {
    volumeValue = value;
    notifyListeners();
  }

  Future<void> setSelectedBend(int index) async {
    selectedBend = index;
    notifyListeners();
  }

  Future<void> setCustomBendValue(int zoneIndex, int index) async {
    customBendValues[zoneIndex] = bendSizes[index];
    notifyListeners();
  }

  Future<void> setZoneValues(int index, double value) async {
    zoneValues[index] = value;
    notifyListeners();
  }

  goToNext() {
    if (pageController.page != 6) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  goToPrevious() {
    if (pageController.page != 0) {
      pageController.previousPage(
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }
}
