import 'package:flutter/material.dart';

import 'package:date_split_app/core/common/features/account/presentation/views/account_page.dart';
import 'package:date_split_app/core/common/views/activity_page.dart';
import 'package:date_split_app/core/common/views/expense_page.dart';
import 'package:date_split_app/core/common/views/night_out_page.dart';
import 'package:date_split_app/core/common/views/notes_page.dart';

class PersistentHome {
  PersistentHome._();
  static int? _currentIndex = 0;

  static setCurrentIndex(int? value) {
    _currentIndex = value;
  }

  static int? get currentIndex => _currentIndex;

  static const List<Widget> pages = <Widget>[
    AccountPage(),
    NotesPage(),
    AddExpensePage(),
    ActivityPage(),
    NightOutPage(),
  ];
}
