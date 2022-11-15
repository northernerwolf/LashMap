import 'package:flutter/cupertino.dart';

class CustomLashProvider extends ChangeNotifier {
  final TextEditingController commentController = TextEditingController();
  PageController pageController = PageController();
  // Zone count
  double zoneValue = 3;
  List<double> zoneValues = List.generate(15, (index) => 0);
  List<bool> zoneValuesEnabled = List.generate(15, (index) => true);

  // Volume
  double volumeValue = 0.5;
  List<double> volumeTextList = [0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4];
  bool isBlack = true;

  // Bending
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

  // Thickness
  double thicknessValue = 0.05;
  List<double> thicknessTextList = [0.05, 0.07, 0.085, 0.10, 0.12, 0.15];
  bool isCustomSettingMode = false;
  List<String?> customThicknessValues = List.generate(15, (index) => null);
  List<int> currentThicknessSizes = List.generate(15, (index) => 0);

  // Length
  bool isLenghtRowEnabled = false;
  List<int> lengthTextList = List.generate(10, (index) => index + 1);
  List<String?> customLengthValues = List.generate(15, (index) => null);
  List<int> currentLengthSizes = List.generate(15, (index) => 0);
  List<List<String?>> customLengthValuesMode2 = List.generate(
      15,
      (index) => List.generate(
            3,
            (index) => null,
          ));
  List<List<int>> currentLengthSizesMode2 = List.generate(
      15,
      (index) => List.generate(
            3,
            (index) => 0,
          ));

  // Rays
  bool isRaysEnabled = false;
  int rayValue = 3;
  String rayBendValue = "B";
  double rayThickness = 0.05;
  int rayLength = 1;

  Future<void> setThicknessValue(double value) async {
    thicknessValue = value;
    notifyListeners();
  }

  Future<void> onCommentChange() async {
    notifyListeners();
  }

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

  Future<void> updateIsLenghtRowEnabled() async {
    isLenghtRowEnabled = !isLenghtRowEnabled;
    notifyListeners();
  }

  Future<void> updateIsRaysEnabled() async {
    isRaysEnabled = !isRaysEnabled;
    notifyListeners();
  }

  Future<void> updateIsCustomSettingMode() async {
    isCustomSettingMode = !isCustomSettingMode;
    notifyListeners();
  }

  Future<void> setVolumeValue(double value) async {
    volumeValue = value;
    notifyListeners();
  }

  Future<void> setRayValue(int value) async {
    rayValue = value;
    notifyListeners();
  }

  Future<void> setRayBendValue(String value) async {
    rayBendValue = value;
    notifyListeners();
  }

  Future<void> setRayThicknessValue(double value) async {
    rayThickness = value;
    notifyListeners();
  }

  Future<void> setRayLengthValue(int value) async {
    rayLength = value;
    notifyListeners();
  }

  Future<void> setBendSettingMode(int value) async {
    bendSettingMode = value;
    customBendValues = List.generate(15, (index) => null);
    currentBendSizes = List.generate(15, (index) => 0);
    customBendValuesMode2 = List.generate(
        15,
        (index) => List.generate(
              3,
              (index) => null,
            ));
    currentBendSizesMode2 = List.generate(
        15,
        (index) => List.generate(
              3,
              (index) => 0,
            ));
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

  Future<void> setCustomLengthValue(int zoneIndex, int index) async {
    customLengthValues[zoneIndex] = lengthTextList[index].toString();
    notifyListeners();
  }

  Future<void> setCurrentLengthSizes(int zoneIndex, int value) async {
    currentLengthSizes[zoneIndex] = value;
    notifyListeners();
  }

  Future<void> setCustomThicknessValue(int zoneIndex, int index) async {
    customThicknessValues[zoneIndex] = thicknessTextList[index].toString();
    notifyListeners();
  }

  Future<void> setCurrentThicknessSizes(int zoneIndex, int value) async {
    currentThicknessSizes[zoneIndex] = value;
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

  Future<void> seCustomLengthValuesMode2(
      int zoneIndex, int zoneListIndex, int index) async {
    customLengthValuesMode2[zoneIndex][zoneListIndex] =
        lengthTextList[index].toString();
    notifyListeners();
  }

  Future<void> setCurrentLengthSizesMode2(
      int zoneIndex, int zoneListIndex, int value) async {
    currentLengthSizesMode2[zoneIndex][zoneListIndex] = value;
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
