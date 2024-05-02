import 'package:flutter/material.dart';

import '../../utils/petite_storage.dart';

class NavigationProvider extends ChangeNotifier {
  NavigationProvider() {
    getInitialRoute();
  }
  bool _fromNotification = false;
  get fromNotification => _fromNotification;
  void getInitialRoute() {
    _fromNotification =
        StorageUtil.getString(key: 'from_notification') ==
            'true';
    if (_fromNotification) {
      _selectedIndex = 2;
    }
  }

  void tapNotificationDestinations(context) {
    getInitialRoute();
  }

  int _selectedIndex = 0;
  get selectedIndex => _selectedIndex;
  void setSelectedIndex(int index) async {
    _selectedIndex = index;
    notifyListeners();
    var permissionRequested =
        StorageUtil.getString(key: 'permission')
                .toString() ==
            '1';
    notifyListeners();
  }
}
