import 'package:flutter/cupertino.dart';

class CustomLashProvider extends ChangeNotifier {
  PageController pageController = PageController();
  double zoneValue = 10;
  double volumeValue = 0.5;
  List<double> volumeTextList = [0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4];

  List<double> zoneValues = List.generate(15, (index) => 0);
  List<bool> zoneValuesEnabled = List.generate(15, (index) => true);
  bool isBlack = true;

  List<String?> customBendValues = List.generate(15, (index) => null);
  List<String> bendSizes = ["B", "C", "C+", "D", "CC", "L", "M", "LC", "LD"];
  List<int> currentBendSizes = List.generate(15, (index) => 0);
  int bendSettingMode = 0;
  int selectedBend = 0;

  List<List<String?>> customBendValuesMode2 = List.generate(
      15,
      (index) => List.generate(
            3,
            (index) => null,
          ));
  List<List<int>> currentBendSizesMode2 = List.generate(
      15,
      (index) => List.generate(
            3,
            (index) => 0,
          ));

  Future<void> setZoneValue(double value) async {
    zoneValue = value;
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

  Future<void> setBendSettingMode(int value) async {
    bendSettingMode = value;
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

  Future<void> setCurrentBendSizes(int zoneIndex, int value) async {
    currentBendSizes[zoneIndex] = value;
    notifyListeners();
  }

  Future<void> seCustomBendValuesMode2(
      int zoneIndex, int zoneListIndex, int index) async {
    customBendValuesMode2[zoneIndex][zoneListIndex] = bendSizes[index];
    notifyListeners();
  }

  Future<void> setCurrentBendSizesMode2(
      int zoneIndex, int zoneListIndex, int value) async {
    currentBendSizesMode2[zoneIndex][zoneListIndex] = value;
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
