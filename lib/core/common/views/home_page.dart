import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:date_split_app/core/services/persistent_home.dart';
import 'package:date_split_app/core/utils/assets.dart';
import 'package:date_split_app/core/utils/styles.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.kPrimaryPeach,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Styles.kPrimaryPeach,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Styles.kPrimaryPeach,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: PersistentHome.pages[PersistentHome.currentIndex!],
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
        ),
        child: BottomNavigationBar(
          elevation: 10.0,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          selectedItemColor: Styles.kPrimaryBlueDark,
          unselectedLabelStyle: Styles.bodySmall.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          selectedLabelStyle: Styles.bodySmall.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          currentIndex: PersistentHome.currentIndex!,
          onTap: (value) {
            PersistentHome.setCurrentIndex(value);
            setState(() {});
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.kIcUser),
              label: 'Conta',
              activeIcon: SvgPicture.asset(Assets.kIcUserSelected),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.kIcPostIt),
              label: 'Nota',
              activeIcon: SvgPicture.asset(Assets.kIcPostItSelected),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.kIcAdd),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.kIcCalendar),
              label: 'Atividade',
              activeIcon: SvgPicture.asset(Assets.kIcCalendarSelected),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.kIcHouse),
              label: 'Rolês',
              activeIcon: SvgPicture.asset(Assets.kIcHouseSelected),
            ),
          ],
        ),
      ),
    );
  }
}
