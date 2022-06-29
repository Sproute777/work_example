import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/presentation/screens/auth/login_screen.dart';

class ProfileCard extends StatelessWidget {
  final Widget? image;
  final Widget? name;
  final Widget? email;

  const ProfileCard({
    this.email,
    this.name,
    this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(25, 20, 25, 0),
      child: Material(
        color: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        child: Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            shape: BoxShape.rectangle,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: image ??
                      Image.network(
                        'https://picsum.photos/seed/595/600',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 10, 0, 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
                        child: name ??
                            const Text(
                              'Тимур Тест',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'GloryBold',
                                color: Color(0xFF6CC9E0),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
                        child: email ??
                            const Text(
                              'Test@gmailcom',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'GloryMedium',
                                color: Color(0xFFAAAAAA),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    await preferences.clear();
                    Navigator.of(context, rootNavigator: true)
                        .pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (route) => false);
                  },
                  child: Align(
                    alignment: const AlignmentDirectional(0, 0),
                    child: SvgPicture.asset(
                      'assets/images/ic_logout.svg',
                      width: 20,
                      height: 19,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
