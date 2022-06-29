import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '/presentation/bloc/create_post/create_post_bloc.dart';
import '/presentation/bloc/create_post/create_post_state.dart';
import '/presentation/colors.dart';
import '/presentation/screens/filters/filter_screen.dart';
import '/presentation/screens/search/search_city_screen.dart';
import '../../widgets/base_text_field.dart';
import '../../widgets/custom_dialog_box.dart';
import '../../widgets/menu_button.dart';
import '../../widgets/segmented_control.dart';
import '../../widgets/submit_button.dart';

import '../../widgets/loading.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({Key? key}) : super(key: key);

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  List<CategoryCard> items = [
    CategoryCard(title: 'Фотограф', isSelected: false),
    CategoryCard(title: 'Модель', isSelected: false),
    CategoryCard(title: 'Другое', isSelected: false),
  ];
  int _selectedCategoryIndex = 0;
  bool showItems = false;
  bool hasTattoo = false;
  bool hasInternPassword = false;
  int gender = 0;
  List<File> photo = [];
  var city = "";
  var category = "";
  var selectedDate = "";
  final TextEditingController titleController = TextEditingController();
  final dateController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  final TextEditingController ageFromController = TextEditingController();
  final TextEditingController ageToController = TextEditingController();
  final TextEditingController heightFromController = TextEditingController();
  final TextEditingController heightToController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  var currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreatePostBloc>(
      create: (context) => CreatePostBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: const Padding(
            padding: EdgeInsets.only(left: 24),
            child: MenuButton(
              iconPath: 'assets/images/ic_back.svg',
            ),
          ),
          title: const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              'Создание объявления',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'GloryRegular',
                color: Color(0xff062226),
              ),
            ),
          ),
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
                  BaseTextField(
                    controller: titleController,
                    title: "Название объявления:",
                    hintText: "",
                    inputType: TextInputType.text,
                    isVisibleTitle: true,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Дата:",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "GloryMedium",
                                      color: mineShaft2GrayColor)),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async => {
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(currentDate.year,
                                      currentDate.month, currentDate.day),
                                  maxTime: DateTime(
                                      currentDate.year + 1,
                                      currentDate.month,
                                      currentDate.day), onConfirm: (date) {
                                setState(() {
                                  selectedDate =
                                      DateFormat("dd.MM.yyyy").format(date);
                                });
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.ru)
                            },
                            child: Container(
                              height: 48,
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
                                child: Text(selectedDate),
                              ),
                            ),
                          ),
                        ],
                      )),
                      const SizedBox(width: 10),
                      Expanded(
                          child: BaseTextField(
                              controller: budgetController,
                              title: "Бюджет:",
                              hintText: "",
                              inputType: TextInputType.number,
                              isVisibleTitle: true,
                              textAlign: TextAlign.center))
                    ],
                  ),
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
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 15, bottom: 9),
                    child: const Text(
                      'Подробнее:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          fontFamily: "GloryMedium",
                          color: mineShaft2GrayColor),
                    ),
                  ),
                  Visibility(
                    visible: photo.isNotEmpty,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: photo.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.file(
                                        File(photo[index].path),
                                        width: 110,
                                        height: 110,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 4, top: 10),
                                        child: GestureDetector(
                                            onTap: () {
                                              photo.removeAt(index);
                                              setState(() {
                                                photo;
                                              });
                                            },
                                            child: const Icon(Icons.close)),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  Container(),
                  DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    color: vikingColor,
                    strokeWidth: 1,
                    child: GestureDetector(
                      onTap: () async {
                        _getImageFromGallery();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0x1A1B877E),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "+ Загрузите фото",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: "GloryMedium",
                                color: mineShaft2GrayColor),
                          ),
                        ),
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
                    valueIndex: (int i) {
                      gender = i;
                    },
                  ),
                  Visibility(
                    visible: _selectedCategoryIndex == 1,
                    child: ModelContainer(
                      ageFrom: ageFromController,
                      ageTo: ageToController,
                      heightFrom: heightFromController,
                      heightTo: heightToController,
                      hasTattoo: hasTattoo,
                      hasInternPassword: hasInternPassword,
                    ),
                  ),
                  const SizedBox(height: 18.0),
                  const Text(
                    'Другие детали:',
                    style: TextStyle(
                      fontFamily: 'GloryRegular',
                      fontSize: 16.0,
                      height: 18.0 / 16.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextField(
                    maxLines: null,
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: "",
                        contentPadding: const EdgeInsets.all(15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: silverGrayColor,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: silverGrayColor,
                            width: 1.5,
                          ),
                        )),
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
                  Flexible(
                    child: FilterCategories(
                      selectedCategoryIndex: _selectedCategoryIndex,
                      onSelect: (index) =>
                          setState(() => _selectedCategoryIndex = index),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const HttpResultWidget(),
                  ButtonWidget(
                    title: titleController.text.toString(),
                    date: selectedDate,
                    city: city,
                    description: descriptionController.text.toString(),
                    photos: photo,
                    category: _selectedCategoryIndex,
                    ageTo: ageToController.text.toString(),
                    ageFrom: ageFromController.text.toString(),
                    heightTo: heightToController.text.toString(),
                    heightFrom: heightFromController.text.toString(),
                    hasTattoo: hasTattoo,
                    hasInternPassword: hasInternPassword,
                    budget: budgetController.text.toString(),
                    gender: gender,
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    var result = await picker.pickImage(
        source: ImageSource.gallery, maxHeight: 480, maxWidth: 640);
    photo.add(File(result!.path));
    setState(() {
      photo;
    });
  }
}

class ModelContainer extends StatefulWidget {
  TextEditingController ageFrom;
  TextEditingController ageTo;
  TextEditingController heightTo;
  TextEditingController heightFrom;
  bool hasTattoo;
  bool hasInternPassword;

  ModelContainer({
    Key? key,
    required this.ageFrom,
    required this.ageTo,
    required this.heightFrom,
    required this.heightTo,
    required this.hasTattoo,
    required this.hasInternPassword,
  }) : super(key: key);

  @override
  State<ModelContainer> createState() => _ModelContainerState();
}

class _ModelContainerState extends State<ModelContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 18.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                child: BaseTextField(
                    controller: widget.ageFrom,
                    title: "Возраст",
                    hintText: "От",
                    inputType: TextInputType.number,
                    isVisibleTitle: true,
                    textAlign: TextAlign.center)),
            const SizedBox(width: 10),
            Expanded(
                child: BaseTextField(
                    controller: widget.ageTo,
                    title: "",
                    hintText: "До",
                    inputType: TextInputType.number,
                    isVisibleTitle: true,
                    textAlign: TextAlign.center))
          ],
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: BaseTextField(
                controller: widget.heightFrom,
                title: "Рост:",
                hintText: "От",
                inputType: TextInputType.number,
                isVisibleTitle: true,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: BaseTextField(
                controller: widget.heightTo,
                title: "",
                hintText: "До",
                inputType: TextInputType.number,
                isVisibleTitle: true,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
        const SizedBox(height: 17),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: SelectCardItem(
                isSelected: widget.hasTattoo,
                onTap: () {
                  setState(() {
                    widget.hasTattoo = !widget.hasTattoo;
                  });
                },
                title: 'Татуировки/пирсинг',
                subTitle: widget.hasTattoo == true ? 'Имеется' : 'Нет',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SelectCardItem(
                isSelected: widget.hasInternPassword,
                onTap: () {
                  setState(() {
                    widget.hasInternPassword = !widget.hasInternPassword;
                  });
                },
                title: 'Загранпаспорт',
                subTitle: widget.hasInternPassword == true ? 'Имеется' : 'Нет',
              ),
            )
          ],
        ),
      ],
    );
  }
}

class HttpResultWidget extends StatelessWidget {
  const HttpResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreatePostBloc, CreatePostState>(
      listener: (context, state) {
        if (state is CreatePostLocalErrorState) {
          buildShowDialog(context, state.message!.toString());
        } else if (state is CreatePostErrorState) {
          buildShowDialog(context, state.message!.toString());
        } else if (state is CreatePostSuccess) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is CreatePostInitial) {
          return const Text('');
        } else if (state is CreatePostLoading) {
          return const LoadingIndicator();
        } else {
          return const Text('');
        }
      },
    );
  }
}

class ButtonWidget extends StatelessWidget {
  String title;
  String date;
  String city;
  int gender;
  int category;
  String description;
  String ageFrom;
  String ageTo;
  String heightTo;
  String heightFrom;
  bool hasTattoo;
  bool hasInternPassword;
  String budget;
  List<File> photos;

  ButtonWidget(
      {Key? key,
      required this.title,
      required this.date,
      required this.city,
      required this.gender,
      required this.category,
      required this.description,
      required this.ageFrom,
      required this.ageTo,
      required this.heightTo,
      required this.heightFrom,
      required this.hasTattoo,
      required this.hasInternPassword,
      required this.budget,
      required this.photos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SubmitButton(
      onTap: () {
        if (title.isEmpty) {
          buildShowDialog(context, "Заполните название");
        } else if (date.isEmpty) {
          buildShowDialog(context, "Заполните дату");
        } else if (city.isEmpty) {
          buildShowDialog(context, "Заполните город");
        } else if (description.isEmpty) {
          buildShowDialog(context, "Заполните описание");
        } else if (photos.isEmpty) {
          buildShowDialog(context, "Загрузите фотографии");
        } else if (budget.isEmpty) {
          buildShowDialog(context, "Заполните бюджет");
        } else if (category == 1 && ageFrom.isEmpty && ageTo.isEmpty) {
          buildShowDialog(context, "Заполните возраст");
        } else {
          context.read<CreatePostBloc>().createPost(
                title: title,
                date: date,
                city: city,
                gender: gender,
                photos: photos,
                ageFrom: ageFrom,
                ageTo: ageTo,
                heightTo: heightTo,
                heightFrom: heightFrom,
                hasTattoo: hasTattoo,
                hasInternPassword: hasInternPassword,
                budget: budget,
                description: description,
                category: getCategory(category),
              );
        }
      },
    );
  }

  String getCategory(int category) {
    if (category == 0) {
      return 'PHOTOGRAPHER';
    } else if (category == 1) {
      return 'MODEL';
    } else {
      return 'OTHER';
    }
  }
}

Future<dynamic> buildShowDialog(BuildContext context, String message) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogBox(
          title: "Ошибка ввода",
          descriptions: message,
          text: "Ok",
        );
      });
}

class SelectCardItem extends StatefulWidget {
  final bool isSelected;
  final String title;
  final String subTitle;
  final VoidCallback? onTap;

  const SelectCardItem({
    Key? key,
    this.onTap,
    required this.isSelected,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  State<SelectCardItem> createState() => _SelectCardItemState();
}

class _SelectCardItemState extends State<SelectCardItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: "GloryMedium",
                color: mineShaft2GrayColor),
          ),
          SizedBox(height: 9),
          InkWell(
            borderRadius: BorderRadius.circular(7.0),
            onTap: widget.onTap,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color:
                    widget.isSelected ? const Color(0xff6CC9E0) : Colors.white,
                border: widget.isSelected
                    ? null
                    : Border.all(color: const Color(0xffBBBBBB)),
              ),
              child: Center(
                child: FittedBox(
                  child: Text(
                    widget.subTitle,
                    style: TextStyle(
                      color: widget.isSelected
                          ? Colors.white
                          : const Color(0xff2B2B2B),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard {
  String title;
  bool isSelected;

  CategoryCard({
    required this.title,
    required this.isSelected,
  });
}
