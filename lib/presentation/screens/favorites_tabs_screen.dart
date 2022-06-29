import 'package:flutter/material.dart';
// import '/presentation/colors.dart';
import '/presentation/screens/announcement/announcement_screen.dart';
// import '/presentation/screens/favorite/favorites_for_model_screen.dart';
import '/presentation/theme/button_style.dart';
import 'models/model_screen.dart';

class FavoritesTabsScreen extends StatefulWidget {
  final int? index;
  const FavoritesTabsScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<FavoritesTabsScreen> createState() => _FavoritesTabsScreenState();
}

class _FavoritesTabsScreenState extends State<FavoritesTabsScreen> {
  int currentIndex = 0;

  @override
  void didChangeDependencies() {
    if (widget.index != null) {
      currentIndex = widget.index!;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final outlinStyle = AppButtonsStyle.outileWhiteStyle(
        textStyle: const TextStyle(fontFamily: 'GloryMedium'));
    // final outlineStyle30 = AppButtonsStyle.vikingStyle(
    //     textStyle: const TextStyle(fontFamily: 'GloryMedium', fontSize: 30));
    final vikingStyle = AppButtonsStyle.vikingStyle(
        textStyle: const TextStyle(fontFamily: 'GloryMedium'));
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 8.0),
                  child: Text(
                    'Избранное',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'GloryMedium',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: (currentIndex == 0) ? vikingStyle : outlinStyle,
                        child: const Text('Oбъявления'),
                        onPressed: () {
                          setState(() => currentIndex = 0);
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: (currentIndex == 1) ? vikingStyle : outlinStyle,
                        child: const Text('Модели'),
                        onPressed: () {
                          setState(() => currentIndex = 1);
                        },
                      ),
                    ),
                  ],
                )),
            Expanded(
              child: IndexedStack(
                index: currentIndex,
                children: const [
                  AnnouncementScreen(),
                  ModelsScreen(),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
