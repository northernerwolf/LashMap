import 'package:flutter/cupertino.dart';

class CustomLashProvider extends ChangeNotifier {
  PageController pageController = PageController();
  double zoneValue = 2;
  double volumeValue = 0.5;
  List<double> volumeTextList = [0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4];
  List<double> zoneValues = List.generate(14, (index) => 0);
  bool isBlack = true;

  Future<void> setZoneValue(double value) async {
    zoneValue = value;
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
