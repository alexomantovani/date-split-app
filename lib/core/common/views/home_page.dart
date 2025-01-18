import 'package:date_split_app/core/services/persistent_home.dart';
import 'package:date_split_app/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryPeach,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: kPrimaryPeach,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: kPrimaryPeach,
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
          unselectedItemColor: kDescriptionText,
          selectedItemColor: kPrimaryBlueDark,
          currentIndex: PersistentHome.currentIndex!,
          onTap: (value) {
            PersistentHome.setCurrentIndex(value);
            setState(() {});
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(kIcUser),
              label: 'Conta',
              activeIcon: SvgPicture.asset(kIcUserSelected),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(kIcPostIt),
              label: 'Nota',
              activeIcon: SvgPicture.asset(kIcPostItSelected),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(kIcAdd),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(kIcCalendar),
              label: 'Atividade',
              activeIcon: SvgPicture.asset(kIcCalendarSelected),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(kIcHouse),
              label: 'Rolês',
              activeIcon: SvgPicture.asset(kIcHouseSelected),
            ),
          ],
        ),
      ),
    );
  }
}
