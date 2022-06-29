// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/data/api/constants.dart';
import '/domain/model/profile/profile_entity.dart';
import '/presentation/bloc/profile/profile_model_screen_bloc.dart';
import '/presentation/bloc/profile/profile_model_screen_state.dart';
import '/presentation/colors.dart';
import '/presentation/screens/registration/registration_employer_screen.dart';
import '/presentation/widgets/menu_button.dart';

class ShowProfileModelScreen extends StatefulWidget {
  final int profileId;
  final bool isEdit;

  const ShowProfileModelScreen(
      {Key? key, required this.profileId, required this.isEdit})
      : super(key: key);

  @override
  State<ShowProfileModelScreen> createState() => _ShowProfileModelScreenState();
}

class _ShowProfileModelScreenState extends State<ShowProfileModelScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late ProfileModelScreenBloc _bloc;

  @override
  void initState() {
    _bloc = ProfileModelScreenBloc();
    if (widget.isEdit) {
      _bloc.getProfileSelf();
    } else {
      _bloc.getProfile(widget.profileId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: primaryBackgroundColor,
      body: BlocBuilder<ProfileModelScreenBloc, ProfileModelScreenState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return LoadingIndicator();
          } else if (state is ProfileLoadedeState) {
            print(
                'ProfileLoadedeState========${state.profileEntity.profilePhotos}');
            return SafeArea(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(25, 20, 25, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.05, 0),
                            child: MenuButton(
                              iconPath: "assets/images/ic_back.svg",
                            ),
                          ),
                          Stack(
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(26.0),
                                  child: Image.network(
                                    (ApiConstants.BASE_URL_IMAGE +
                                        (state.profileEntity.photo?.replaceAll(
                                                "http://127.0.0.1", "") ??
                                            '')),
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Icon(Icons.error_outline, size: 90),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(1, -0.5),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      26, 80, 20, 0),
                                  child: SvgPicture.asset(
                                    'assets/images/ic_photo.svg',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 5.0),
                                    blurRadius: 15.0,
                                    color: Colors.black.withOpacity(0.1),
                                  )
                                ],
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/images/ic_edit.svg",
                                  width: 16.0,
                                  height: 16.0,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        state.profileEntity.name.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'GloryRegular',
                          color: Color(0xFF2B2B2B),
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Нет отзывов',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'GloryRegular',
                          color: Color(0xFF2B2B2B),
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              print(ApiConstants.BASE_URL_IMAGE +
                                  state.profileEntity.profilePhotos![0]);
                            },
                            child: SvgPicture.asset(
                              'assets/images/ic_vk_show_profile.svg',
                              width: 38,
                              height: 38,
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/images/ic_instagram_show_profile.svg',
                            width: 38,
                            height: 38,
                          ),
                          SvgPicture.asset(
                            'assets/images/ic_phone_show_profile.svg',
                            width: 38,
                            height: 38,
                          ),
                          SvgPicture.asset(
                            'assets/images/ic_mail_show_profile.svg',
                            width: 38,
                            height: 38,
                          ),
                          SvgPicture.asset(
                            'assets/images/ic_favorite_show_profile.svg',
                            width: 38,
                            height: 38,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: DefaultTabController(
                          length: 2,
                          initialIndex: 0,
                          child: Column(
                            children: [
                              TabBar(
                                labelColor: vikingColor,
                                unselectedLabelColor: grayColor,
                                labelStyle: TextStyle(
                                  fontFamily: 'GloryItalic',
                                  fontStyle: FontStyle.italic,
                                  fontSize: 16,
                                ),
                                indicatorColor: vikingColor,
                                tabs: [
                                  Tab(
                                    text: 'Фото',
                                  ),
                                  Tab(
                                    text: 'Данные',
                                  ),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    TabPhoto(
                                      profileEntity: state.profileEntity,
                                    ),
                                    InfoTab(
                                      profileEntity: state.profileEntity,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return LoadingIndicator();
          }
        },
      ),
    );
  }
}

class InfoTab extends StatelessWidget {
  final ProfileEntity profileEntity;

  const InfoTab({
    required this.profileEntity,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              width: double.infinity,
              height: 210,
              padding: const EdgeInsets.only(
                  left: 18, right: 20, top: 12, bottom: 14),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: LineWidgetInfo(
                        title: 'Рост:',
                        description: '${profileEntity.growth} cm'),
                  ),
                  Divider(color: Color(0xffc9c9c9)),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: LineWidgetInfo(
                        title: 'Грудь-Талия-Бедра:',
                        description:
                            '${profileEntity.bust} ${profileEntity.waist} ${profileEntity.hips}'),
                  ),
                  Divider(color: Color(0xffc9c9c9)),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: LineWidgetInfo(
                        title: 'Размер обуви:',
                        description: profileEntity.shoesSize.toString()),
                  ),
                  Divider(color: Color(0xffc9c9c9)),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: LineWidgetInfo(
                        title: 'Размер одежды:',
                        description: profileEntity.closeSize.toString()),
                  ),
                  Divider(color: Color(0xffc9c9c9))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              width: double.infinity,
              height: 80,
              padding: const EdgeInsets.only(
                  left: 18, right: 20, top: 12, bottom: 14),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Знание языков:",
                      style: TextStyle(
                          fontFamily: 'GloryItalic',
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                          color: vikingColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        profileEntity.isHaveEnglish
                            ? "Русский язык, Английский язык"
                            : "Русский язык",
                        style: TextStyle(
                            fontFamily: 'GloryRegular',
                            fontSize: 16,
                            color: grayColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              width: double.infinity,
              height: 120,
              padding: const EdgeInsets.only(
                  left: 18, right: 20, top: 12, bottom: 14),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Опыт работы:",
                      style: TextStyle(
                          fontFamily: 'GloryItalic',
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                          color: vikingColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        profileEntity.about.toString(),
                        style: TextStyle(
                            fontFamily: 'GloryRegular',
                            fontSize: 16,
                            color: grayColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LineWidgetInfo extends StatelessWidget {
  final String title;
  final String description;

  const LineWidgetInfo(
      {Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontFamily: 'GloryRegular', fontSize: 16, color: grayColor),
        ),
        Text(
          description,
          style: TextStyle(
            fontFamily: 'GloryItalic',
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic,
            color: vikingColor,
            fontSize: 16,
          ),
        )
      ],
    );
  }
}

class TabPhoto extends StatelessWidget {
  final ProfileEntity profileEntity;

  const TabPhoto({
    required this.profileEntity,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.custom(
          gridDelegate: SliverWovenGridDelegate.count(
            crossAxisCount: 2,
            pattern: [
              WovenGridTile(1),
              WovenGridTile(
                6 / 7,
                crossAxisRatio: 0.95,
                alignment: AlignmentDirectional.centerEnd,
              ),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
              (context, index) => ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      ApiConstants.BASE_URL_IMAGE +
                          ('/media/' +
                              (profileEntity.profilePhotos?[index].toString() ??
                                  '')),
                      fit: BoxFit.cover,
                    ),
                  ),
              childCount: (profileEntity.profilePhotos?.length) ?? 0),
        ));
  }
}
