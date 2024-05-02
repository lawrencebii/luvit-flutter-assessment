import 'package:flutter/cupertino.dart';

import '../../utils/constants.dart';

class HomeProvider extends ChangeNotifier {
  Profile _currentProfile = Profile.MP01;
  Profile get currentProfile => _currentProfile;
  int _currentIndex = 0;
  get currentIndex => _currentIndex;

  void tapLeft() {
    if (_currentProfile == Profile.MP03) {
      _currentProfile = Profile.MP02;
      notifyListeners();
    }
    if (_currentProfile == Profile.MP02) {
      _currentProfile = Profile.MP01;
      notifyListeners();
    }
    if (_currentIndex > 0) {
      _currentIndex = _currentIndex - 1;
    }
    notifyListeners();
  }

  void tapRight() {
    if (_currentProfile == Profile.MP03) {
      _currentProfile = Profile.MP02;
    }
    if (_currentProfile == Profile.MP02) {
      _currentProfile = Profile.MP01;
    }
    if (_currentIndex < 4) {
      _currentIndex = _currentIndex + 1;
    }
    notifyListeners();
  }

  void resetIndex() {
    _currentIndex = 0;
    notifyListeners();
  }

  var _mangos = [];
  get mangos => _mangos;
  void setMangos() {
    _mangos = mangosMain;
    print("setting$mangosMain");
    notifyListeners();
  }

  void removeMango(mango) {
    _mangos.removeWhere((element) => element['id'] == mango['id']);
    notifyListeners();
  }

  // var _dmangos = [];
  // get dmangos => _dmangos;
  // void getDisplayMangos() {
  //   _dmangos = _mangos.where((element) => element['visible']).toList();
  //   notifyListeners();
  // }
}

enum Profile {
  MP01,
  MP02,
  MP03,
}
