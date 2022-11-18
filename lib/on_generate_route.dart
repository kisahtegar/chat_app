import 'package:chat_app/features/domain/entities/user/user_entity.dart';
import 'package:chat_app/features/presentation/pages/setting/edit_profile_page.dart';
import 'package:flutter/material.dart';

import 'const.dart';
import 'features/presentation/pages/credential/sign_in_page.dart';
import 'features/presentation/pages/credential/sign_up_page.dart';
import 'features/presentation/pages/setting/setting_page.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageConst.signInPage:
        {
          return routeBuilder(const SignInPage());
        }
      case PageConst.signUpPage:
        {
          return routeBuilder(const SignUpPage());
        }
      case PageConst.settingPage:
        {
          if (args is String) {
            return routeBuilder(SettingPage(uid: args));
          } else {
            return routeBuilder(const NoPageFound());
          }
        }
      case PageConst.editProfilePage:
        {
          if (args is UserEntity) {
            return routeBuilder(EditProfilePage(currentUser: args));
          } else {
            return routeBuilder(const NoPageFound());
          }
        }
      default:
        {
          const NoPageFound();
        }
    }
    return null;
  }
}

dynamic routeBuilder(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

class NoPageFound extends StatelessWidget {
  const NoPageFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst().backGroundColor,
      body: const Center(
        child: Text("No Page Found"),
      ),
    );
  }
}
