import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '/presentation/bloc/profile/profile_model_screen_bloc.dart';
import '/presentation/bloc/profile/profile_model_screen_state.dart';
import '/presentation/colors.dart';
import '/presentation/screens/profile/show_profile_model_screen.dart';
import '/presentation/screens/profile/widget/profile_card.dart';
import '/presentation/screens/registration/registration_employer_screen.dart';
import '/presentation/widgets/submit_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var isTurnOnNotification = false;
  late ProfileModelScreenBloc _bloc;

  @override
  void initState() {
    _bloc = ProfileModelScreenBloc();
    _bloc.getProfileSelf();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: _bloc,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: primaryBackgroundColor,
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                    child: Text(
                      'Настройки',
                      style: TextStyle(
                        fontFamily: 'GloryMedium',
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                BlocBuilder<ProfileModelScreenBloc, ProfileModelScreenState>(
                  bloc: _bloc,
                  builder: (context, state) {
                    if (state is ProfileLoadingState) {
                      return const LoadingIndicator();
                    } else if (state is ProfileLoadedeState) {
                      return ProfileCard(
                          email: Text(
                            state.profileEntity.website.toString(),
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontFamily: 'GloryMedium',
                              color: Color(0xFFAAAAAA),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          image: Image.network(
                            state.profileEntity.photo.toString(),
                            errorBuilder: (context, error, stackTrace) =>
                                Image.network(
                              'https://picsum.photos/seed/595/600',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                          name: Text(
                            state.profileEntity.name.toString(),
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontFamily: 'GloryBold',
                              color: Color(0xFF6CC9E0),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ));
                    }
                    return const ProfileCard();
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ShowProfileModelScreen(
                                profileId: 0,
                                isEdit: true,
                              )),
                    );
                  },
                  child: const ItemProfileMenu(
                    iconPath: "assets/images/ic_profile.svg",
                    title: "Данные",
                    isDivider: true,
                    leftPadding: 45,
                    rightPadding: 25,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const ItemProfileMenu(
                  iconPath: "assets/images/ic_my_respond_settings.svg",
                  title: "Мои отклики",
                  isDivider: true,
                  leftPadding: 45,
                  rightPadding: 25,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 45, right: 35),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                              "assets/images/ic_notif_settings.svg",
                              width: 30,
                              height: 30),
                          const Expanded(
                            flex: 4,
                            child: Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                "Уведомление",
                                style: TextStyle(
                                  fontFamily: 'GloryMedium',
                                  fontSize: 15,
                                  color: vikingColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Switch(
                              value: isTurnOnNotification,
                              onChanged: (value) {
                                setState(() {
                                  isTurnOnNotification = value;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(25, 34, 25, 0),
                      child: Container(
                        width: double.infinity,
                        height: 145,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            ItemProfileMenu(
                              iconPath:
                                  "assets/images/ic_change_password_settings.svg",
                              title: "Изменить пароль",
                              isDivider: true,
                              leftPadding: 20,
                              rightPadding: 0,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ItemProfileMenu(
                              iconPath:
                                  "assets/images/ic_change_email_settings.svg",
                              title: "Изменить почту",
                              isDivider: false,
                              leftPadding: 20,
                              rightPadding: 0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 50),
                  child: SubmitButton(
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemProfileMenu extends StatelessWidget {
  const ItemProfileMenu(
      {Key? key,
      required this.iconPath,
      required this.title,
      required this.isDivider,
      required this.leftPadding,
      required this.rightPadding})
      : super(key: key);
  final String iconPath;
  final String title;
  final bool isDivider;
  final double leftPadding;
  final double rightPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding, right: rightPadding),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(iconPath, width: 30, height: 30),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'GloryMedium',
                      fontSize: 15,
                      color: vikingColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SvgPicture.asset("assets/images/ic_arrow_right.svg",
                    width: 6, height: 12),
              )
            ],
          ),
          Visibility(
            visible: isDivider,
            child: const Padding(
              padding: EdgeInsets.only(right: 25.0, top: 10.0),
              child: Divider(color: Color(0xffc9c9c9)),
            ),
          )
        ],
      ),
    );
  }
}
