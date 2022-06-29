import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/presentation/colors.dart';
import '/presentation/screens/search/search_city_screen.dart';
import '/presentation/widgets/segmented_control.dart';
import '/presentation/widgets/submit_button.dart';

import '../../widgets/menu_button.dart';
part 'filter_screen.widgets.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({
    Key? key,
  }) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<double> _prices = [0, 1000000];
  int _selectedCategoryIndex = -1;
  var city = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: const MenuButton(
          iconPath: 'assets/images/ic_back.svg',
        ),
        title: const Text(
          'Фильтр',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24.0,
            fontFamily: 'GloryRegular',
            color: Color(0xff062226),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 24.0),
            child: MenuButton(
              iconPath: 'assets/images/ic_close.svg',
            ),
          ),
        ],
        leadingWidth: 64.0,
        toolbarHeight: kToolbarHeight + 16.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text("Город:",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        fontFamily: "GloryMedium",
                        color: mineShaft2GrayColor)),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async => {
                    city = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchPage()),
                    ),
                    setState(() {
                      city;
                    })
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xffffffff),
                      border: Border.all(
                        color: silverGrayColor,
                        width: 1.5,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(city),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SegmentedControl(
                  title: 'Тип работы:',
                  items: const [
                    'Без оплаты',
                    'С оплатой',
                    'Все',
                  ],
                  valueIndex: (int i) {},
                ),
                const SizedBox(height: 18.0),
                SegmentedControl(
                  title: 'Пол исполнителя:',
                  items: const [
                    'Женщины',
                    'Мужчины',
                    'Все',
                  ],
                  valueIndex: (int i) {},
                ),
                const SizedBox(height: 18.0),
                const Text(
                  'Таблица цен',
                  style: TextStyle(
                    fontFamily: 'GloryRegular',
                    color: Color(0xff6CC9E0),
                    fontSize: 16.0,
                    height: 18.0 / 16.0,
                  ),
                ),
                Slider(
                  valueChanged: (List<double> range) {
                    setState(() => _prices = range);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '0.00',
                      style: TextStyle(
                        fontFamily: 'GloryRegular',
                        fontWeight: FontWeight.w500,
                        color: Color(0xffAAAAAA),
                      ),
                    ),
                    Text(
                      _prices[1].toStringAsFixed(0),
                      style: const TextStyle(
                        fontFamily: 'GloryRegular',
                        fontWeight: FontWeight.w500,
                        color: Color(0xff6CC9E0),
                      ),
                    ),
                    const Text(
                      '1000000',
                      style: TextStyle(
                        fontFamily: 'GloryRegular',
                        fontWeight: FontWeight.w500,
                        color: Color(0xffAAAAAA),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18.0),
                const Text(
                  'Категория',
                  style: TextStyle(
                    fontFamily: 'GloryRegular',
                    fontSize: 16.0,
                    height: 18.0 / 16.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  padding: const EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xffF5F6F7),
                    border: Border.all(
                      color: const Color(0xffDDDDDD),
                    ),
                  ),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Text(
                          'Выберите категорию',
                          style: TextStyle(
                            color: Color(0xffAAAAAA),
                            fontSize: 16.0,
                            fontFamily: 'GloryRegular',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Icon(
                        Icons.chevron_right,
                        color: Color(0xffAAAAAA),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: FilterCategories(
                    selectedCategoryIndex: _selectedCategoryIndex,
                    onSelect: (index) =>
                        setState(() => _selectedCategoryIndex = index),
                  ),
                ),
                const SizedBox(height: 16.0),
                SubmitButton(
                  onTap: () {},
                ),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
