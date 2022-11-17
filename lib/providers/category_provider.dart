import 'package:flutter/cupertino.dart';

class CategoryProvider extends ChangeNotifier {
  bool isCategoryExpanded = false;
  bool isServicesExpanded = false;
  bool isAddingNewCategory = false;

  Future<void> updateIsCategoryExpanded() async {
    isCategoryExpanded = !isCategoryExpanded;
    notifyListeners();
  }

  Future<void> updateIsServiceExpanded() async {
    isServicesExpanded = !isServicesExpanded;
    notifyListeners();
  }

  Future<void> setIsAddingNewCategory(bool value) async {
    isAddingNewCategory = value;
    notifyListeners();
  }
}
