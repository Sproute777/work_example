import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '/presentation/widgets/menu_button.dart';

import '../../bloc/home/detail_post/detail_post_bloc.dart';
import '../../bloc/home/detail_post/detail_post_state.dart';
import '../../colors.dart';
import '../../widgets/loading.dart';

class DetailScreen extends StatefulWidget {
  final int id;
  final String userType;
  const DetailScreen({Key? key, required this.id, required this.userType})
      : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late DetailPostBloc bloc;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    bloc = DetailPostBloc();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
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
              'Детали работы',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'GloryRegular',
                color: blackPearlColor,
              ),
            ),
          ),
          leadingWidth: 64.0,
          toolbarHeight: kToolbarHeight + 16.0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BlocBuilder<DetailPostBloc, DetailPostState>(
              builder: (context, state) {
                if (state is DetailPostScreenInitial) {
                  context.read<DetailPostBloc>().getPostById(widget.id);
                  return const SizedBox();
                } else if (state is DetailPostScreenError) {
                  return const Center(child: Text("Что-то пошло не так"));
                } else if (state is DetailPostScreenSuccess) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 24,
                          ),
                          CircleAvatar(
                            radius: 27,
                            backgroundColor: vikingColor,
                            child: CircleAvatar(
                              radius: 27,
                              backgroundImage:
                                  NetworkImage(state.data!.authorAvatar),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(state.data!.authorName,
                                  style: const TextStyle(
                                    fontSize: 19.15,
                                    fontFamily: "GloryMedium",
                                  )),
                              const Text("Автор",
                                  style: TextStyle(
                                      fontSize: 15.32,
                                      fontFamily: "GloryMedium",
                                      color: vikingColor)),
                            ],
                          ),
                          Expanded(child: Container()),
                          Text(getDate(state.data!.lastUpdatedDate),
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: "GloryMedium",
                              )),
                          const SizedBox(
                            width: 24,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            // Image border
                            child: CarouselSlider(
                              options: CarouselOptions(
                                aspectRatio: 16 / 9,
                                viewportFraction: 0.8,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: false,
                                enlargeCenterPage: true,
                                scrollDirection: Axis.horizontal,
                              ),
                              items: state.data!.photos.map((value) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        getPhoto(value),
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                      const SizedBox(height: 23.0),
                      Text(
                        state.data?.title ?? "",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'GloryRegular',
                          fontSize: 27.0,
                          fontWeight: FontWeight.w600,
                          color: mineShaft2GrayColor,
                        ),
                      ),
                      const SizedBox(height: 31.0),
                      SvgIconWithText(
                        description: state.data?.city ?? "Не указано",
                        svgPath: 'assets/images/ic_location.svg',
                      ),
                      const SizedBox(height: 9.0),
                      SvgIconWithText(
                        description:
                            'Состоится ${getDate(state.data!.executionDate)}',
                        svgPath: 'assets/images/ic_calendar.svg',
                      ),
                      const SizedBox(height: 9.0),
                      SvgIconWithText(
                        description: '${state.data?.budget ?? 0} P',
                        svgPath: 'assets/images/ic_dollars.svg',
                      ),
                      const SizedBox(height: 26.0),
                      Row(
                        children: const [
                          SizedBox(
                            width: 25,
                          ),
                          Text(
                            'Описание:',
                            style: TextStyle(
                              fontFamily: 'GloryRegular',
                              fontSize: 17.0,
                              height: 18.0 / 16.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.5,
                            color: borderGreyColor,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(
                                  10.0) //                 <--- border radius here
                              ),
                        ),
                        child: Text(
                          "${state.data!.otherDetails} ${state.data!.moreDescription}",
                          softWrap: true,
                          style: const TextStyle(
                            fontFamily: 'GloryRegular',
                            fontSize: 16.0,
                            height: 17.0 / 15.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14.0),
                      Row(
                        children: const [
                          SizedBox(
                            width: 25,
                          ),
                          Text(
                            'Требования:',
                            style: TextStyle(
                              fontFamily: 'GloryRegular',
                              fontSize: 17.0,
                              height: 18.0 / 16.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 25, right: 53),
                        child: Column(
                          children: [
                            RowItemElement(
                              description: 'Рост от: ${state.data!.growthFrom}',
                            ),
                            RowItemElement(
                              description:
                                  'Возраст: ${state.data!.ageFrom}-${state.data!.ageTo}',
                            ),
                            RowItemElement(
                              description:
                                  'Загранпаспорт: ${getBoolValue(state.data!.isForeignPassport)}',
                            ),
                            RowItemElement(
                              description:
                                  'Татуировка: ${getBoolValue(state.data!.isTatoo)}',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14.0),
                      Row(
                        children: const [
                          SizedBox(
                            width: 27,
                          ),
                          Text(
                            'Категория:',
                            style: TextStyle(
                              fontFamily: 'GloryRegular',
                              fontSize: 16.0,
                              height: 17.0 / 15.0,
                              color: darkGreyColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(left: 27, right: 23),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: vikingColor,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(
                                  10.0) //                 <--- border radius here
                              ),
                        ),
                        child: Center(
                          child: Text(
                            state.data?.category ?? "Не указано",
                            style: const TextStyle(
                                fontFamily: 'GloryMedium',
                                fontSize: 18.0,
                                height: 19.0 / 17.0,
                                color: vikingColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14.0),
                      Visibility(
                        visible: widget.userType == 'MODEL',
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.only(left: 27, right: 23),
                          decoration: const BoxDecoration(
                            color: vikingColor,
                            borderRadius: BorderRadius.all(Radius.circular(
                                    10.0) //                 <--- border radius here
                                ),
                          ),
                          child: const Center(
                            child: Text(
                              'Откликнуться',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'GloryMedium',
                                fontSize: 19.0,
                                height: 20.0 / 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: LoadingIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  String getDate(String date) {
    DateFormat dateFormatFrom = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    DateFormat dateFormatTo = DateFormat("dd.MM.yyyy");
    DateTime dateTime = dateFormatFrom.parse(date);
    return dateFormatTo.format(dateTime);
  }

  getBoolValue(bool value) {
    if (value) {
      return "Да";
    } else {
      return "Нет";
    }
  }

  String getPhoto(String value) {
    if (value.isNotEmpty && value != null) {
      return value;
    } else {
      return "https://www.signupgenius.com/cms/images/business/appointment-scheduling-tips-photographers-article-600x400.jpg";
    }
  }
}

class RowItemElement extends StatelessWidget {
  final String description;

  const RowItemElement({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 5,
          width: 5,
          margin: const EdgeInsets.all(8),
          decoration:
              const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
        ),
        Text(
          description,
          style: const TextStyle(
            fontFamily: 'GloryRegular',
            fontSize: 16.0,
            height: 17.0 / 15.0,
          ),
        ),
      ],
    );
  }
}

String getDate(String date) {
  DateFormat dateFormatFrom = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
  DateFormat dateFormatTo = DateFormat("dd.MM.yyyy");
  DateTime dateTime = dateFormatFrom.parse(date);
  return dateFormatTo.format(dateTime);
}

class SvgIconWithText extends StatelessWidget {
  final String svgPath;
  final String description;

  const SvgIconWithText({
    Key? key,
    required this.svgPath,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 27),
        SvgPicture.asset(
          svgPath,
          color: iconColor,
          width: 24,
          height: 24,
        ),
        const SizedBox(width: 16),
        Text(
          description,
          style: const TextStyle(
            fontFamily: 'GloryRegular',
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
