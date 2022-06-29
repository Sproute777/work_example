import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '/presentation/bloc/favorite/model/favorite_model_screen_bloc.dart';
import '/presentation/bloc/favorite/model/favorite_model_screen_state.dart';
import '/presentation/colors.dart';
import '/presentation/widgets/blue_button.dart';
// import 'package:auto_size_text/auto_size_text.dart';
import '/presentation/widgets/submit_button.dart';

import '../../widgets/loading.dart';

class FavoritesForModelScreen extends StatefulWidget {
  const FavoritesForModelScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesForModelScreen> createState() =>
      _FavoritesForModelScreenState();
}

class _FavoritesForModelScreenState extends State<FavoritesForModelScreen> {
  late FavoriteModelScreenBloc bloc;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    bloc = FavoriteModelScreenBloc();
    bloc.getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
        value: bloc,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            elevation: 0.0,
            title: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Отклики',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'GloryRegular',
                  color: Color(0xff062226),
                ),
              ),
            ),
            leadingWidth: 54.0,
            toolbarHeight: kToolbarHeight + 16.0,
          ),
          body: const BodyWidget(),
        ));
  }
}

class BodyWidget extends StatefulWidget {
  const BodyWidget({Key? key}) : super(key: key);

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  late FavoriteModelScreenBloc? bloc;
  final double customHeight = 3.8;

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<FavoriteModelScreenBloc>(context, listen: false);
    return BlocBuilder<FavoriteModelScreenBloc, FavoriteModelScreenState>(
      builder: (BuildContext context, state) {
        if (state is FavoriteModelScreenInitial) {
          return const Text('');
        } else if (state is FavoriteModelScreenLoading) {
          return const LoadingIndicator();
        } else if (state is FavoriteModelScreenSuccess) {
          return ListView.separated(
              itemCount: favModelList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: ((context, index) {
                return SizedBox(
                  height: 240,
                  child: Column(children: [
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: FittedBox(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      width: 160,
                                      height: 180,
                                      margin:
                                          const EdgeInsets.only(right: 16.0),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: SizedBox.expand(
                                            child: Image.network(
                                              favModelList[index].imageUrl!,
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              favModelList[index].firstName!,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              favModelList[index].lastName!,
                                              style: const TextStyle(
                                                fontFamily: 'GloryRegular',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/images/ic_location.svg',
                                                      color: iconColor,
                                                      width: 11,
                                                      height: 11,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      favModelList[index]
                                                          .adress!,
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'GloryRegular',
                                                        fontSize: 8,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/images/ic_dollars.svg',
                                                      color: iconColor,
                                                      width: 11,
                                                      height: 11,
                                                    ),
                                                    // const SizedBox(width: 10),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      favModelList[index]
                                                          .price!,
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'GloryRegular',
                                                        fontSize: 8,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ]),
                                    ),
                                    const SizedBox(height: 8),
                                    Expanded(
                                        flex: 3,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: FavRowInfoCard(
                                                title: 'Рост',
                                                value: favModelList[index]
                                                        .height
                                                        .toString() +
                                                    ' cm',
                                              ),
                                              // ),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),

                                            Expanded(
                                              child: FavRowInfoCard(
                                                title: 'Грудь-Талия-Бедра:',
                                                value: favModelList[index]
                                                    .bodyParams!,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Expanded(
                                              child: FavRowInfoCard(
                                                title: 'Размер обуви:',
                                                value: favModelList[index]
                                                    .shoesSize
                                                    .toString(),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Expanded(
                                              child: FavRowInfoCard(
                                                title: 'Размер одежды:',
                                                value: favModelList[index]
                                                    .clothesSize
                                                    .toString(),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            // const Divider(),
                                          ],
                                        )),
                                  ],
                                ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 12.0, left: 12.0),
                          child: Row(
                            children: const [
                              Expanded(
                                child: CustomButton(
                                  text: 'Отказать',
                                  isRed: true,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: CustomButton(
                                  text: 'Принять',
                                ),
                              ),
                            ],
                          ),
                        ))
                  ]),
                );
              }));

          // );
        } else if (state is FavoriteModelScreenErrorState) {
          return Align(
            alignment: Alignment.topCenter,
            child: Text(state.message!.message.toString(),
                style: const TextStyle(
                    color: Colors.redAccent,
                    fontFamily: 'GloryRegular',
                    fontSize: 16)),
          );
        } else {
          return const Text('фывфы');
        }
      },
    );
  }
}

class FavRowInfoCard extends StatelessWidget {
  final String title;
  final String value;

  const FavRowInfoCard({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontFamily: 'GloryRegular',
                  fontSize: 9,
                  color: grayColor,
                  fontWeight: FontWeight.w300),
            ),
            Text(
              value,
              style: TextStyle(
                fontFamily: 'GloryRegular',
                fontWeight: FontWeight.w100,
                fontStyle: FontStyle.italic,
                color: const Color(0xff6CC9E0).withOpacity(0.6),
                fontSize: 9,
              ),
            ),
          ],
        ));
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1}) : super(key: key);
  final double height;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 2.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey[300]),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}

class WidgetItemAdvert extends StatelessWidget {
  const WidgetItemAdvert({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 24, right: 24),
          width: double.infinity,
          height: 180,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20), // Image border
                child: Image.network(
                  "https://art-assorty.ru/wp-content/uploads/2018/09/222547.jpg",
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 71,
                  height: 33,
                  decoration: const BoxDecoration(
                      color: vikingColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      '8000 ₽',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, 1),
                child: Container(
                  height: 230,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0x000f0f0f),
                          Color(0x660F0F0F),
                          Color(0x660F0F0F),
                        ],
                      )),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, 1),
                child: SizedBox(
                  height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 16, bottom: 20),
                          child: SizedBox(
                            width: 150,
                            child: Text(
                              "Модель для причёсики",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "GloryRegular",
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Москва, Россия",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "GloryRegular",
                                        fontSize: 16),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SvgPicture.asset(
                                      "assets/images/ic_location.svg")
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Row(
                                  children: [
                                    const Text(
                                      "29.03 - 30.03",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "GloryRegular",
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SvgPicture.asset(
                                        "assets/images/ic_calendar.svg")
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10, left: 24, right: 24),
          child: BlueButton(),
        )
      ],
    );
  }
}

class FavoriteModel {
  String? firstName;
  String? lastName;
  String? adress;
  String? price;
  int? height;
  int? shoesSize;
  String? bodyParams;
  int? clothesSize;
  String? imageUrl;

  FavoriteModel({
    this.firstName,
    this.lastName,
    this.adress,
    this.price,
    this.height,
    this.shoesSize,
    this.bodyParams,
    this.clothesSize,
    this.imageUrl,
  });
}

List<FavoriteModel> favModelList = [
  FavoriteModel(
    adress: 'Москва, Россия',
    firstName: 'Анастасия',
    lastName: 'Иванова',
    price: '\$ 50/час',
    height: 175,
    shoesSize: 36,
    clothesSize: 40,
    bodyParams: '75*62*89',
    imageUrl:
        'https://www.akamai.com/site/im-demo/perceptual-standard.jpg?imbypass=true',
  ),
  FavoriteModel(
    adress: 'Москва, Россия',
    firstName: 'TestName',
    lastName: 'Иванова',
    price: '\$ 100/час',
    height: 167,
    shoesSize: 36,
    clothesSize: 40,
    bodyParams: '90*62*89',
    imageUrl:
        'https://www.akamai.com/site/im-demo/perceptual-standard.jpg?imbypass=true',
  ),
  FavoriteModel(
    adress: 'Минск, Беларусь',
    firstName: 'Маша',
    lastName: 'Иванова',
    price: '\$ 50/час',
    height: 175,
    shoesSize: 36,
    clothesSize: 40,
    bodyParams: '75*62*89',
    imageUrl: 'https://art-assorty.ru/wp-content/uploads/2018/09/222547.jpg',
  ),
  FavoriteModel(
    adress: 'Москва, Россия',
    imageUrl: 'https://art-assorty.ru/wp-content/uploads/2018/09/222547.jpg',
    firstName: 'Даша',
    lastName: 'Иванова',
    price: '\$ 50/час',
    height: 175,
    shoesSize: 36,
    clothesSize: 40,
    bodyParams: '75*62*89',
  ),
];
