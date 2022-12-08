import 'package:chat_app/features/domain/entities/user/user_entity.dart';
import 'package:chat_app/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:chat_app/features/presentation/widget/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../const.dart';
import '../../cubit/user/get_single_users/get_single_user_cubit.dart';

class HomePage extends StatefulWidget {
  final String uid;

  const HomePage({
    super.key,
    required this.uid,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

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
          debugPrint("HomePage: currentUser($currentUser)");
          return Scaffold(
            backgroundColor: ColorConst().backGroundColor,
            appBar: AppBar(
              backgroundColor: ColorConst().backGroundColor,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.all(6.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: profileWidget(imageUrl: currentUser.profileUrl),
                ),
              ),
              title: Text(
                "${currentUser.name == "" ? currentUser.username : currentUser.name}",
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: InkWell(
                    onTap: () {
                      _openModalBottomSheet(context, currentUser);
                    },
                    child: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 29,
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search and add button
                  _searchAddButton(),
                  sizeVer(20),

                  // Status
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: _subTitle("Status"),
                  ),
                  sizeVer(10),
                  SizedBox(
                    height: 160,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      separatorBuilder: (context, index) => sizeHor(10),
                      itemBuilder: (context, index) {
                        return Container(
                          width: 90,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: NetworkImage(
                                'https://raw.githubusercontent.com/kisahtegar/Test-API/main/picture/naruto.png',
                              ),
                            ),
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(
                              top: 120,
                              left: 10,
                            ),
                            child: Text(
                              "Username",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  sizeVer(20),

                  // List chat
                  const Divider(
                    indent: 20,
                    endIndent: 20,
                    color: Colors.white,
                    // thickness: 1,
                  ),
                  Container(
                    // color: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                      ),
                      title: Text(
                        "Username",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "Join the conversation as ...",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(
            color: ColorConst().primaryColor,
          ),
        );
      },
    );
  }

  Text _subTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 23,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Row _searchAddButton() {
    return Row(
      children: [
        // Search widget
        Flexible(
          flex: 14,
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 36, 30, 56),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      border: InputBorder.none,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 117, 116, 116),
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 31,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            color: Colors.red,
          ),
        ),
        // add button
        InkWell(
          onTap: () {},
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  // showModalBottomSheet()
  Future<dynamic> _openModalBottomSheet(
      BuildContext context, UserEntity currentUser) {
    // final UserEntity currentUsers;

    return showModalBottomSheet(
      context: context,
      backgroundColor: ColorConst().backGroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      builder: (context) {
        return Container(
          height: 300,
          decoration: BoxDecoration(
            color: ColorConst().backGroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(
              children: [
                Text(
                  "More Options",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorConst().primaryColor,
                  ),
                ),
                sizeHor(15),
                const Divider(thickness: 1, color: Colors.grey),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(
                      context,
                      PageConst.settingPage,
                      arguments: widget.uid,
                    );
                  },
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  leading: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Settings",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  leading: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "friends",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  leading: const Icon(
                    Icons.question_mark,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "About",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
                ListTile(
                  onTap: () {
                    BlocProvider.of<AuthCubit>(context).loggedOut();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      PageConst.signInPage,
                      (route) => false,
                    );
                  },
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
