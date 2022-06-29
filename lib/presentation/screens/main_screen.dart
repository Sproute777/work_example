import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/presentation/screens/favorites_tabs_screen.dart';

import 'favorite/favorites_for_model_screen.dart';
import 'home/home_screen.dart';

import 'profile/profile_screen.dart';

extension _StringExt on String {
  List<int> toIndex() {
    switch (this) {
      case 'favorites':
        return [1];
      case 'favorites/announcment':
        return [1, 0];
      case 'fovorites/models':
        return [1, 1];

      case 'answers':
        return [2];
      case 'settings':
        return [3];

      case 'home':
      default:
        return [0];
    }
  }
}

class MainScreen extends StatefulWidget {
  ///  MainScreen автономен , но при необходимости можно переключить
  ///  вложенные табы из навигатора , для этого необходимо указать
  ///  в tabName имя нужного таба пример tabName = "home";
  ///  или указазать имя нужного таба и  имя вложеного
  ///  пример tabName = 'home/page2;
  final String tabName;

  const MainScreen({Key? key, required this.tabName}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // хранит стек старниц , а также анимирует переходы
  final pageController = PageController();

  // индекс главных табов
  int _currentIndex = 0;
  // индекс дочерних табов
  int? subIndex;

  // переключить таб станицу по главному индексу
  void jumpToPage(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (pageController.hasClients) {
        pageController.jumpToPage(index);
      }
    });
  }

  // после того как страница будет переключена
  // переключить индекс главного таба
  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

// если изменилось значение tabName
// обновить индексы
  @override
  void didChangeDependencies() {
    final tabsIndex = widget.tabName.toIndex();
    _currentIndex = tabsIndex[0];
    jumpToPage(_currentIndex);

    if (tabsIndex.length == 2) {
      subIndex = tabsIndex[1];
    } else {
      subIndex = null;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
        children: <Widget>[
          const HomeScreen(),
          FavoritesTabsScreen(index: subIndex),
          // const ModelsScreen(),
          const FavoritesForModelScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: jumpToPage,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/ic_tab_home.svg'),
              activeIcon:
                  SvgPicture.asset('assets/images/ic_tab_home_selected.svg'),
              label: ""),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/ic_tab_search.svg'),
              activeIcon:
                  SvgPicture.asset('assets/images/ic_tab_search_selected.svg'),
              label: ""),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/ic_tab_heart.svg'),
              activeIcon:
                  SvgPicture.asset('assets/images/ic_tab_heart_selected.svg'),
              label: ""),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/ic_tab_profile.svg'),
              activeIcon:
                  SvgPicture.asset('assets/images/ic_tab_profile_selected.svg'),
              label: "")
        ],
      ),
    );
  }
}
