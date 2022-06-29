// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../colors.dart';
import '../../widgets/loading.dart';
import '/data/api/constants.dart';
import '/domain/model/auth/post_entity.dart';
import '/domain/model/profile/profile_entity.dart';
import '/presentation/bloc/home/home_screen_bloc.dart';
import '/presentation/bloc/home/home_screen_state.dart';
import '/presentation/bloc/home/talents_widget_bloc.dart';
import '/presentation/bloc/home/talents_widget_state.dart';
import '/presentation/screens/announcement/announcement_screen.dart';
import '/presentation/screens/filters/filter_screen.dart';
import '/presentation/screens/home/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getUserType();
    });
  }

  var userType = "";

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<HomeScreenBloc>(create: (context) => HomeScreenBloc()),
          BlocProvider<TalentsWidgetBloc>(
            create: (context) => TalentsWidgetBloc(),
          ),
        ],
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              elevation: 0.0,
              toolbarHeight: 10),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Visibility(
                          visible: true,
                          child: Flexible(
                            flex: 1,
                            child: AddAdvertWidget(),
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: Text(
                            "Главная",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24,
                                fontFamily: "GloryMedium",
                                color: blackPearlColor),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FilterScreen()),
                              );
                            },
                            child: SvgPicture.asset(
                                "assets/images/ic_filter.svg",
                                width: 46,
                                height: 46),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Лучшие таланты:",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "GloryMedium",
                            color: vikingColor),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TalentsWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Топ объявлений:",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "GloryMedium",
                            color: vikingColor),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListAdvert(userType: userType),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void _getUserType() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userType = preferences.getString("TYPE") ?? "";
  }
}

class TalentsWidget extends StatefulWidget {
  const TalentsWidget({Key? key}) : super(key: key);

  @override
  State<TalentsWidget> createState() => _TalentsWidgetState();
}

class _TalentsWidgetState extends State<TalentsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TalentsWidgetBloc, TalentsWidgetState>(
      builder: (BuildContext context, state) {
        if (state is TalentsWidgetInitial) {
          return const Text('');
        } else if (state is TalentsWidgetLoading) {
          return const LoadingIndicator();
        } else if (state is TalentsWidgetSuccess) {
          return SizedBox(
            height: 120,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: state.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return CircleItem(item: state.data![index]);
              },
              separatorBuilder: (context, index) => SizedBox(
                width: 15,
              ),
            ),
          );
        } else if (state is TalentsWidgetErrorState) {
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

class ListAdvert extends StatefulWidget {
  String userType;
  ListAdvert({
    Key? key,
    required this.userType,
  }) : super(key: key);

  @override
  State<ListAdvert> createState() => _ListAdvertState();
}

class _ListAdvertState extends State<ListAdvert> {
  late HomeScreenBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<HomeScreenBloc>(context, listen: false);
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (BuildContext context, state) {
        if (state is HomeScreenInitial) {
          return const Text('');
        } else if (state is HomeScreenLoading) {
          return const LoadingIndicator();
        } else if (state is HomeScreenSuccess) {
          return ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return WidgetItemAdvert(
                  postEntity: state.data![index], userType: widget.userType);
            },
            separatorBuilder: (context, index) => SizedBox(
              height: 15,
            ),
          );
        } else if (state is HomeScreenErrorState) {
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

class AddAdvertWidget extends StatefulWidget {
  const AddAdvertWidget({Key? key}) : super(key: key);

  @override
  State<AddAdvertWidget> createState() => _AddAdvertWidgetState();
}

class _AddAdvertWidgetState extends State<AddAdvertWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        createPost();
      },
      child: SvgPicture.asset("assets/images/ic_add_advert.svg",
          width: 45, height: 45),
    );
  }

  void createPost() async {
    // TODO поправить это
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('TYPE') == 'MODEL') {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Создание додступно только для работников'),
        duration: const Duration(milliseconds: 700),
      ));
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AnnouncementScreen()),
      );
    }
  }
}

class WidgetItemAdvert extends StatelessWidget {
  final PostEntity postEntity;
  final String userType;

  const WidgetItemAdvert(
      {Key? key, required this.postEntity, required this.userType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailScreen(id: postEntity.id, userType: userType)),
          );
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20), // Image border
              child: Image.network(
                getPhoto(postEntity.photos),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 71,
                height: 33,
                decoration: BoxDecoration(
                    color: vikingColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '${postEntity.budget} ₽',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, 1),
              child: Container(
                height: 230,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x000f0f0f),
                        Color(0x1A0F0F0F),
                        Color(0x660F0F0F),
                      ],
                    )),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, 1),
              child: SizedBox(
                height: 200,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 26),
                        child: Text(
                          postEntity.category,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "GloryRegular",
                              fontSize: 16),
                        ),
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16, bottom: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text(
                                  postEntity.city,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "GloryRegular",
                                      fontSize: 16),
                                ),
                                SizedBox(
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
                                  Text(
                                    getPostDateFormat(postEntity.executionDate),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "GloryRegular",
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SvgPicture.asset(
                                      "assets/images/ic_location.svg")
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
            )
          ],
        ),
      ),
    );
  }

  String getPostDateFormat(String executionDate) {
    DateFormat dateFormatFrom = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    DateFormat dateFormatTo = DateFormat("dd.MM");
    DateTime dateTime = dateFormatFrom.parse(executionDate);
    return dateFormatTo.format(dateTime);
  }

  String getPhoto(List<String> photos) {
    if (postEntity.photos.isNotEmpty) {
      return postEntity.photos[0];
    } else {
      return "https://www.signupgenius.com/cms/images/business/appointment-scheduling-tips-photographers-article-600x400.jpg";
    }
  }
}

class CircleItem extends StatelessWidget {
  final ProfileEntity item;

  const CircleItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: vikingColor,
          child: CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage(getLinkPhoto(item.photo)),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(item.name?.replaceAll(" ", "\n") ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14, fontFamily: "GloryMedium", color: vikingColor))
      ],
    );
  }

  String getLinkPhoto(String? photo) {
    if (photo != null && photo.isNotEmpty) {
      return ApiConstants.BASE_URL_IMAGE + item.photo!;
    } else {
      return "https://www.seekpng.com/png/detail/73-730482_existing-user-default-avatar.png";
    }
  }
}
