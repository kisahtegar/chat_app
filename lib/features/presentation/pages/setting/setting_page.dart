import 'package:chat_app/const.dart';
import 'package:chat_app/features/presentation/cubit/user/get_single_users/get_single_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widget/profile_widget.dart';

class SettingPage extends StatefulWidget {
  final String uid;
  const SettingPage({
    super.key,
    required this.uid,
  });

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
      builder: (context, getSingleUserState) {
        if (getSingleUserState is GetSingleUserLoaded) {
          final currentUser = getSingleUserState.userEntity;
          return Scaffold(
            backgroundColor: ColorConst().backGroundColor,
            appBar: AppBar(
              backgroundColor: ColorConst().backGroundColor,
              title: const Text('Settings'),
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Card
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        PageConst.editProfilePage,
                        arguments: currentUser,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 18, 15, 43),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ListTile(
                        leading: SizedBox(
                          width: 60,
                          height: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: profileWidget(
                              imageUrl: currentUser.profileUrl,
                            ),
                          ),
                        ),
                        title: Text(
                          "${currentUser.username}",
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        subtitle: Text(
                          "${currentUser.email}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.keyboard_arrow_right,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: ColorConst().primaryColor,
            ),
          );
        }
      },
    );
  }
}
