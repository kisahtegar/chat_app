import 'dart:io';

import 'package:chat_app/features/domain/usecases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../const.dart';
import '../../../../injection_container.dart' as di;
import '../../../domain/entities/user/user_entity.dart';
import '../../cubit/user/user_cubit.dart';
import '../../widget/profile_widget.dart';
import 'widget/profile_form_widget.dart';

class EditProfilePage extends StatefulWidget {
  final UserEntity currentUser;

  const EditProfilePage({
    super.key,
    required this.currentUser,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController? _nameController;
  TextEditingController? _usernameController;
  TextEditingController? _bioController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentUser.name);
    _usernameController =
        TextEditingController(text: widget.currentUser.username);
    _bioController = TextEditingController(text: widget.currentUser.bio);
  }

  bool _isUpdating = false;
  File? _image;

  @override
  Widget build(BuildContext context) {
    debugPrint("EditProfilePage: currentUser(${widget.currentUser})");
    return Scaffold(
      backgroundColor: ColorConst().backGroundColor,
      appBar: AppBar(
        backgroundColor: ColorConst().backGroundColor,
        title: const Text('Edit Profile'),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.close, size: 32),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: _updateUserProfileData,
              child: const Icon(Icons.done, size: 32, color: Colors.blue),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              // Image Profile
              sizeVer(15),
              Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: profileWidget(
                      imageUrl: widget.currentUser.profileUrl,
                      image: _image,
                    ),
                  ),
                ),
              ),
              sizeVer(10),
              Center(
                child: TextButton(
                  onPressed: _selectImage,
                  child: const Text(
                    'Change profile photo',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),

              // Name form
              ProfileFormWidget(
                controller: _nameController,
                title: "Name",
              ),
              sizeVer(15),
              // Username form
              ProfileFormWidget(
                controller: _usernameController,
                title: "Username",
              ),
              sizeVer(15),
              // Bio form
              ProfileFormWidget(
                controller: _bioController,
                title: "Bio",
              ),
              sizeVer(15),
              _isUpdating == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Please wait...",
                          style: TextStyle(color: Colors.white),
                        ),
                        sizeHor(10),
                        const CircularProgressIndicator(),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Future _selectImage() async {
    try {
      final pickedFile =
          // ignore: invalid_use_of_visible_for_testing_member
          await ImagePicker.platform.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          debugPrint("$_image");
        } else {
          debugPrint("No image has been selected");
        }
      });
    } catch (e) {
      toast("Some error occured");
    }
  }

  _updateUserProfileData() {
    setState(() => _isUpdating = true);

    if (_image == null) {
      _updateUserProfile("");
    } else {
      di
          .sl<UploadImageToStorageUsecase>()
          .call(_image!, false, "profileImages")
          .then((profileUrl) {
        _updateUserProfile(profileUrl);
      });
    }
  }

  _updateUserProfile(String profileUrl) {
    BlocProvider.of<UserCubit>(context)
        .updateUser(
          userEntity: UserEntity(
            uid: widget.currentUser.uid,
            username: _usernameController!.text,
            name: _nameController!.text,
            bio: _bioController!.text,
            profileUrl: profileUrl,
          ),
        )
        .then((_) => _clear());
  }

  _clear() {
    setState(() {
      _isUpdating = false;
      _usernameController!.clear();
      _nameController!.clear();
      _bioController!.clear();
    });
    Navigator.pop(context);
  }
}
