import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../widgets/segmented_control.dart';
// import '../main_screen.dart';
import '../search/search_city_screen.dart';
import '/presentation/bloc/auth/registration_model_bloc.dart';
import '/presentation/colors.dart';
import '/presentation/models/RequestProfileModel.dart';
import '/presentation/widgets/base_text_field.dart';
import '/presentation/widgets/custom_dialog_box.dart';
import '/presentation/widgets/submit_button.dart';
import '/router/router_cubit.dart';

class RegistrationModelScreen extends StatefulWidget {
  final http.Client? client;

  const RegistrationModelScreen({Key? key, this.client}) : super(key: key);

  @override
  State<RegistrationModelScreen> createState() =>
      _RegistrationModelScreenState();
}

class _RegistrationModelScreenState extends State<RegistrationModelScreen> {
  late RegistrationModelBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = RegistrationModelBloc();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  var isPassport = false;
  var isTattoo = false;
  var isEnglish = false;
  var isModelType = true;
  var gender = 0;
  var typeModel = 0;
  var city = "";

  final List<String> showAppearanceTypeItems = [
    "европейская",
    "африканская",
    "мулат",
    "кавказская",
    "азиатская",
    "индийская",
    "испанская",
    "другая"
  ];
  var appearanceType = "Выбрать";

  final List<String> skinTypeItems = [
    "бледный",
    "светлый",
    "смуглый",
    "темный",
    "другой"
  ];
  var skinType = "Выбрать";

  final List<String> hairColorItems = [
    "белокурые",
    "русые",
    "каштановые",
    "брюнет",
    "черные",
    "рыжие",
    "другие"
  ];
  var hairColor = "Выбрать";

  final List<String> hairLengthItems = [
    "очень длинные",
    "длинные",
    "средние",
    "короткие",
    "без волос"
  ];
  var hairLength = "Выбрать";
  List<File?> photo = [];
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var cityController = TextEditingController();
  var facebookController = TextEditingController();
  var instagramController = TextEditingController();
  var linkedinController = TextEditingController();
  var siteController = TextEditingController();
  var sizeClothesController = TextEditingController();
  var sizeShoesController = TextEditingController();
  var sizeGrowthController = TextEditingController();
  var sizeBustController = TextEditingController();
  var sizeWaistController = TextEditingController();
  var sizeHipsController = TextEditingController();
  var aboutController = TextEditingController();
  final List<String> customMask = [
    '+7 (000) 000-00-00', //Россия / Казахстан
    '(00) 000-00-00', // Беларусь
  ];
  late MaskedTextController phoneController =
      MaskedTextController(mask: customMask.first);

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: bloc,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 25, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Image.asset(
                            'assets/images/ic_back_arrow.png',
                            width: 60,
                            height: 60,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        const Expanded(
                          child: Align(
                            alignment: AlignmentDirectional(-0.25, -0.15),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                              child: Text(
                                'Профиль',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'GloryMedium',
                                  color: Color(0xFF062226),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      children: <Widget>[
                        BaseTextField(
                            controller: nameController,
                            title: "Имя, Фамилия:",
                            hintText: "Имя",
                            inputType: TextInputType.text,
                            isVisibleTitle: true,
                            textAlign: TextAlign.center),
                        const SizedBox(
                          height: 15,
                        ),
                        SegmentedControl(
                          title: 'Пол:',
                          items: const [
                            'Девушка',
                            'Мужчина',
                          ],
                          valueIndex: (value) => {gender = value},
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: BaseTextField(
                                    controller: ageController,
                                    title: "Возраст:",
                                    hintText: "23",
                                    inputType: TextInputType.number,
                                    isVisibleTitle: true,
                                    textAlign: TextAlign.center)),
                            const SizedBox(width: 10),
                            Expanded(
                                child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Город:",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "GloryMedium",
                                            color: mineShaft2GrayColor)),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async => {
                                    city = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SearchPage()),
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
                              ],
                            ))
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Flexible(
                                flex: 1,
                                child: SvgPicture.asset(
                                    "assets/images/ic_phone.svg")),
                            const SizedBox(width: 10),
                            Flexible(
                                flex: 5,
                                child: BaseTextField(
                                    controller: phoneController,
                                    title: "Город:",
                                    hintText: "Телефон для связи",
                                    inputType: TextInputType.phone,
                                    isVisibleTitle: false,
                                    textAlign: TextAlign.start))
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Flexible(
                                flex: 1,
                                child: SvgPicture.asset(
                                    "assets/images/ic_instagram.svg")),
                            const SizedBox(width: 10),
                            Flexible(
                                flex: 5,
                                child: BaseTextField(
                                    controller: instagramController,
                                    title: "Город:",
                                    hintText: "www.instagram.com",
                                    inputType: TextInputType.text,
                                    isVisibleTitle: false,
                                    textAlign: TextAlign.start))
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Flexible(
                                flex: 1,
                                child: SvgPicture.asset(
                                    "assets/images/ic_website_employer.svg")),
                            const SizedBox(width: 10),
                            Flexible(
                                flex: 5,
                                child: BaseTextField(
                                    controller: siteController,
                                    title: "Город:",
                                    hintText: "Сайт",
                                    inputType: TextInputType.text,
                                    isVisibleTitle: false,
                                    textAlign: TextAlign.start))
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SegmentedControl(
                          title: 'Тип работы:',
                          items: const [
                            'Модель',
                            'Фотограф',
                            'Другое',
                          ],
                          onPressed: (value) => {},
                          valueIndex: (int) {
                            if (int == 0) {
                              isModelType = true;
                            } else {
                              isModelType = false;
                            }
                            typeModel = int;
                            setState(() {
                              isModelType;
                            });
                          },
                        ),
                        Visibility(
                          visible: isModelType,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: BaseTextField(
                                          controller: sizeClothesController,
                                          title: "Размер одежды:",
                                          hintText: "23",
                                          inputType: TextInputType.number,
                                          isVisibleTitle: true,
                                          textAlign: TextAlign.center)),
                                  const SizedBox(width: 10),
                                  Expanded(
                                      child: BaseTextField(
                                          controller: sizeShoesController,
                                          title: "Размер обуви:",
                                          hintText: "75",
                                          inputType: TextInputType.number,
                                          isVisibleTitle: true,
                                          textAlign: TextAlign.center))
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: BaseTextField(
                                          controller: sizeGrowthController,
                                          title: "Рост:",
                                          hintText: "23",
                                          inputType: TextInputType.number,
                                          isVisibleTitle: true,
                                          textAlign: TextAlign.center)),
                                  const SizedBox(width: 10),
                                  Expanded(
                                      child: BaseTextField(
                                          controller: sizeBustController,
                                          title: "Грудь:",
                                          hintText: "75",
                                          inputType: TextInputType.number,
                                          isVisibleTitle: true,
                                          textAlign: TextAlign.center))
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: BaseTextField(
                                        controller: sizeWaistController,
                                        title: "Талия:",
                                        hintText: "23",
                                        inputType: TextInputType.number,
                                        isVisibleTitle: true,
                                        textAlign: TextAlign.center),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                      child: BaseTextField(
                                          controller: sizeHipsController,
                                          title: "Бедра:",
                                          hintText: "75",
                                          inputType: TextInputType.number,
                                          isVisibleTitle: true,
                                          textAlign: TextAlign.center))
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Tип внешности:",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "GloryMedium",
                                                color: mineShaft2GrayColor),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _showAppearanceTypeDialog();
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: const Color(0xFFCCCCCC),
                                                width: 1.5,
                                              ),
                                            ),
                                            child: Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                      0, 0),
                                              child: Text(
                                                appearanceType,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Цвет кожи:",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "GloryMedium",
                                                color: mineShaft2GrayColor),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _showSkinTypeDialog();
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: const Color(0xFFCCCCCC),
                                                width: 1.5,
                                              ),
                                            ),
                                            child: Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                      0, 0),
                                              child: Text(
                                                skinType,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Цвет волос:",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "GloryMedium",
                                                color: mineShaft2GrayColor),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _showHairColorDialog();
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: const Color(0xFFCCCCCC),
                                                width: 1.5,
                                              ),
                                            ),
                                            child: Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                      0, 0),
                                              child: Text(
                                                hairColor,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Длина волос:",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "GloryMedium",
                                                color: mineShaft2GrayColor),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _showHairLengthDialog();
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: const Color(0xFFCCCCCC),
                                                width: 1.5,
                                              ),
                                            ),
                                            child: Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                      0, 0),
                                              child: Text(
                                                hairLength,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SwitchListTile(
                                value: isPassport,
                                onChanged: (newValue) =>
                                    setState(() => isPassport = newValue),
                                title: const Text(
                                  'Загранпаспорт:',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "GloryMedium",
                                      color: mineShaft2GrayColor),
                                ),
                                dense: false,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SwitchListTile(
                                value: isTattoo,
                                onChanged: (newValue) =>
                                    setState(() => isTattoo = newValue),
                                title: const Text(
                                  'Татуировки/Пирсинг:',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "GloryMedium",
                                      color: mineShaft2GrayColor),
                                ),
                                dense: false,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SwitchListTile(
                                value: isEnglish,
                                onChanged: (newValue) =>
                                    setState(() => isEnglish = newValue),
                                title: const Text(
                                  'Английский язык:',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "GloryMedium",
                                      color: mineShaft2GrayColor),
                                ),
                                dense: false,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "О себе",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                fontFamily: "GloryMedium",
                                color: mineShaft2GrayColor),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          maxLines: null,
                          controller: aboutController,
                          keyboardType: TextInputType.multiline,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: "О себе",
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
                        const SizedBox(
                          height: 15,
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
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: Image.file(
                                                  File(photo[index]!.path),
                                                  width: 110,
                                                  height: 110,
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 4, top: 10),
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          photo.removeAt(index);
                                                          setState(() {
                                                            photo;
                                                          });
                                                        },
                                                        child: const Icon(
                                                            Icons.close)),
                                                  ))
                                            ],
                                          ));
                                    }),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                        DottedBorder(
                          color: vikingColor,
                          radius: const Radius.circular(10),
                          strokeWidth: 1,
                          child: GestureDetector(
                            onTap: () {
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
                        const SizedBox(
                          height: 15,
                        ),
                        SubmitButton(
                          onTap: () {
                            if (isModelType) {
                              updateProfileModelType();
                            } else {
                              updateProfileOtherType();
                            }
                          },
                        ),
                        HttpResultWidget()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSkinTypeDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
            height: 300,
            color: Colors.white,
            child: ListView.builder(
                itemCount: skinTypeItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(skinTypeItems[index]),
                    onTap: () {
                      setState(() {
                        skinType = skinTypeItems[index];
                      });
                      Navigator.pop(context);
                    },
                  );
                }));
      },
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

  void _showAppearanceTypeDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
            height: 500,
            color: Colors.white,
            child: ListView.builder(
                itemCount: showAppearanceTypeItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(showAppearanceTypeItems[index]),
                    onTap: () {
                      setState(() {
                        appearanceType = showAppearanceTypeItems[index];
                      });
                      Navigator.pop(context);
                    },
                  );
                }));
      },
    );
  }

  void _showHairColorDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
            height: 440,
            color: Colors.white,
            child: ListView.builder(
                itemCount: hairColorItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(hairColorItems[index]),
                    onTap: () {
                      setState(() {
                        hairColor = hairColorItems[index];
                      });
                      Navigator.pop(context);
                    },
                  );
                }));
      },
    );
  }

  void _showHairLengthDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
            height: 300,
            color: Colors.white,
            child: ListView.builder(
                itemCount: hairLengthItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(hairLengthItems[index]),
                    onTap: () {
                      setState(() {
                        hairLength = hairLengthItems[index];
                      });
                      Navigator.pop(context);
                    },
                  );
                }));
      },
    );
  }

  void updateProfileOtherType() {
    try {
      if (nameController.text.isEmpty) {
        showDialogError("Заполните поле Имя");
      } else if (ageController.text.isEmpty) {
        showDialogError("Заполните поле Возраст");
      } else if (city.isEmpty) {
        showDialogError("Заполните поле Город");
      } else if (phoneController.text.isEmpty) {
        showDialogError("Заполните поле Номер телефона");
      } else if (aboutController.text.isEmpty) {
        showDialogError("Заполните поле О себе");
      } else if (photo.isEmpty) {
        showDialogError("Загрузите фото");
      } else {
        var body = RequestProfileModel(
            email: nameController.text,
            password: ageController.text,
            name: nameController.text,
            userType: "MODEL",
            gender: gender,
            workerType: typeModel,
            age: int.parse(ageController.text),
            city: city,
            phone: phoneController.text,
            instagram: instagramController.text,
            website: siteController.text,
            about: aboutController.text);
        bloc.registration(body, photo, 'OTHER');
      }
    } on Exception catch (e) {
      showDialogError("Ошибка");
    }
  }

  void updateProfileModelType() {
    try {
      if (nameController.text.isEmpty) {
        showDialogError("Заполните поле Имя");
      } else if (ageController.text.isEmpty) {
        showDialogError("Заполните поле Возраст");
      } else if (city.isEmpty) {
        showDialogError("Заполните поле Город");
      } else if (phoneController.text.isEmpty) {
        showDialogError("Заполните поле Номер телефона");
      } else if (sizeClothesController.text.isEmpty) {
        showDialogError("Заполните поле Размер одежды");
      } else if (sizeShoesController.text.isEmpty) {
        showDialogError("Заполните поле Размер обуви");
      } else if (sizeGrowthController.text.isEmpty) {
        showDialogError("Заполните поле Рост");
      } else if (sizeWaistController.text.isEmpty) {
        showDialogError("Заполните поле Талия");
      } else if (sizeHipsController.text.isEmpty) {
        showDialogError("Заполните поле Бедра");
      } else if (aboutController.text.isEmpty) {
        showDialogError("Заполните поле О себе");
      } else if (photo.isEmpty) {
        showDialogError("Загрузите фото");
      } else {
        var body = RequestProfileModel(
          email: nameController.text,
          password: ageController.text,
          name: nameController.text,
          userType: "MODEL",
          gender: gender,
          workerType: typeModel,
          age: int.parse(ageController.text),
          city: city,
          phone: phoneController.text,
          instagram: instagramController.text,
          website: siteController.text,
          about: aboutController.text,
          closeSize: int.parse(sizeClothesController.text),
          shoesSize: int.parse(sizeShoesController.text),
          growth: int.parse(sizeGrowthController.text),
          bust: int.parse(sizeBustController.text),
          waist: int.parse(sizeWaistController.text),
          hips: int.parse(sizeHipsController.text),
          lookType: appearanceType,
          skinColor: skinType,
          hairColor: hairColor,
          hairLength: hairLength,
          isHaveInternationalPassport: isPassport,
          isHaveTattoo: isTattoo,
          isHaveEnglish: isEnglish,
        );
        bloc.registration(body, photo, 'MODEL');
      }
    } on Exception catch (e) {
      showDialogError("Ошибка");
    }
  }

  void showDialogError(String text) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: "Ошибка валидации",
            descriptions: text,
            text: "Ok",
          );
        });
  }
}

class HttpResultWidget extends StatelessWidget {
  HttpResultWidget({Key? key}) : super(key: key);
  late RegistrationModelBloc bloc;

  void myCallback(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<RegistrationModelBloc>(context, listen: false);
    return StreamBuilder<RegistrationModelScreenState>(
        stream: bloc.observeRegistrationState(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const SizedBox();
          }
          final RegistrationModelScreenState state = snapshot.data!;
          switch (state) {
            case RegistrationModelScreenState.loading:
              return const LoadingIndicator();
            case RegistrationModelScreenState.justScreen:
              return Container();
            case RegistrationModelScreenState.registrationSuccess:
              context.read<RouterCubit>().goToMainPage("Flutter is number 1.");
              return Container();
            case RegistrationModelScreenState.registrationError:
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    bloc.errorMessage,
                    style: const TextStyle(color: Colors.redAccent),
                  )
                ],
              );
          }
        });
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: CircularProgressIndicator(
          color: vikingColor,
          strokeWidth: 4,
        ),
      ),
    );
  }
}
