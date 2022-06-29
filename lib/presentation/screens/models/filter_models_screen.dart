import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/presentation/bloc/models/list_models_bloc.dart';
import '/presentation/bloc/models/list_models_screen_state.dart';
import '/presentation/colors.dart';
import '/presentation/screens/announcement/announcement_screen.dart';
import '/presentation/screens/filters/filter_screen.dart';
import '/presentation/screens/search/search_city_screen.dart';
import '/presentation/widgets/menu_button.dart';
import '/presentation/widgets/segmented_control.dart';
import '/presentation/widgets/submit_button.dart';

class FilterModelsScreen extends StatefulWidget {
  Map<String, String> filtersValue;
  final ListModelsBloc customBloc;

  FilterModelsScreen({
    Key? key,
    required this.filtersValue,
    required this.customBloc,
  }) : super(key: key);

  @override
  State<FilterModelsScreen> createState() => _FilterModelsScreenState();
}

class _FilterModelsScreenState extends State<FilterModelsScreen> {
  List<CategoryCard> items = [
    CategoryCard(title: 'Фотограф', isSelected: false),
    CategoryCard(title: 'Модель', isSelected: false),
    CategoryCard(title: 'Другое', isSelected: false),
  ];
  bool showItems = false;
  var city = "";
  int? genderIndex = 0;

  @override
  void dispose() {
    // widget.customBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ListModelsBloc, ListModelsScreenState>(
      bloc: widget.customBloc,
      listener: (context, state) {
        if (state.status == ListModelScreenStatus.success) {
          Navigator.pop(context, widget.filtersValue);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: const Padding(
            padding: EdgeInsets.only(left: 24.0),
            child: MenuButton(
              iconPath: 'assets/images/ic_back.svg',
            ),
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
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 18.0),
                  SegmentedControl(
                    title: 'Пол исполнителя:',
                    items: const [
                      'Женщины',
                      'Мужчины',
                      'Все',
                    ],
                    valueIndex: (int) {
                      genderIndex = int;
                    },
                  ),
                  const SizedBox(height: 15.0),
                  const Text(
                    'Категория:',
                    style: TextStyle(
                      fontFamily: 'GloryRegular',
                      fontSize: 16.0,
                      height: 18.0 / 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  InkWell(
                    onTap: () {
                      setState(() {
                        showItems = !showItems;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(18.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xffF5F6F7),
                        border: Border.all(
                          color: const Color(0xffDDDDDD),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Кого искать',
                              style: TextStyle(
                                color: Color(0xffAAAAAA),
                                fontSize: 16.0,
                                fontFamily: 'GloryRegular',
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          Icon(
                            showItems
                                ? Icons.keyboard_arrow_down_rounded
                                : Icons.chevron_right,
                            color: const Color(0xffAAAAAA),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18.0),
                  showItems
                      ? Flexible(
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                return LabeledRadioButtonItem(
                                  onTap: () {
                                    setState(() {
                                      items[index].isSelected =
                                          !items[index].isSelected;
                                    });
                                  },
                                  isSelected: items[index].isSelected,
                                  title: items[index].title,
                                );
                              }))
                      : const SizedBox(),
                  const SizedBox(height: 16.0),
                  SubmitButton(
                    onTap: () {
                      widget.filtersValue['city'] = city;
                      widget.customBloc.add(ListModelsFetched(
                          city: city, type: '', gender: genderIndex));
                    },
                  ),
                  const SizedBox(height: 24.0),
                ]),
          ),
        ),
      ),
    );
  }
}
