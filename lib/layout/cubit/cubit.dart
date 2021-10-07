// ignore_for_file: prefer_const_constructors, invalid_required_positional_param, avoid_function_literals_in_foreach_calls, curly_braces_in_flow_control_structures

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/models/post_model.dart';
import 'package:social/models/user_model.dart';
import 'package:social/moduels/chats/chats_screen.dart';
import 'package:social/moduels/feeds/feeds_screen.dart';
import 'package:social/moduels/new_post/new_post_screen.dart';
import 'package:social/moduels/settings/settings_screen.dart';
import 'package:social/moduels/users/users_screen.dart';
import 'package:social/shared/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel socialUserModel;
  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      value.data();
      socialUserModel = SocialUserModel.fromJson(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> titles = [
    'Home',
    'Chats',
    'News',
    'Users',
    'Settings',
  ];
  void changeBottomNav(int index) {
    if (index == 1) getUsers();
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  // void uploadProfileImage({
  //   @required String name,
  //   @required String phone,
  //   @required String bio,
  // }) {
  //   emit(SocialUserUpdateLoadingState());
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('users/${Uri.file(profileImage.path).pathSegments.last}')
  //       .putFile(profileImage)
  //       .then((value) => {
  //             value.ref
  //                 .getDownloadURL()
  //                 .then((value) => (value) {
  //                       // emit(SocialUploadProfileImageSuccessState());
  //                       print(value);
  //                       updateUser(
  //                           name: name, phone: phone, bio: bio, image: value);
  //                     })
  //                 .catchError((error) {
  //               emit(SocialUploadProfileImageErrorState());
  //             })
  //           })
  //       .catchError((error) {
  //     emit(SocialUploadProfileImageErrorState());
  //   });
  // }

  void uploadProfileImage({
    @required String name,
    @required String phone,
    @required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) => {
              value.ref
                  .getDownloadURL()
                  .then((value) => {
                        //  emit(SocialUploadProfileImageSuccessState()),
                        print(value),
                        updateUser(
                          name: name,
                          phone: phone,
                          bio: bio,
                          image: value,
                        )
                      })
                  .catchError((error) {
                emit(SocialUploadProfileImageErrorState());
              })
            })
        .catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    @required String name,
    @required String phone,
    @required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) => {
              value.ref
                  .getDownloadURL()
                  .then((value) => {
                        //emit(SocialUploadCoverImageSuccessState()),
                        updateUser(
                            name: name, phone: phone, bio: bio, cover: value)
                      })
                  .catchError((error) {
                emit(SocialUploadCoverImageErrorState());
              })
            })
        .catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }
  // void uploadCoverImage({
  //   @required String name,
  //   @required String phone,
  //   @required String bio,
  // }) {
  //   emit(SocialUserUpdateLoadingState());
  //
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('users/${Uri.file(coverImage.path).pathSegments.last}')
  //       .putFile(coverImage)
  //       .then((value) => {
  //             value.ref
  //                 .getDownloadURL()
  //                 .then((value) => (value) {
  //                       //    emit(SocialUploadCoverImageSuccessState());
  //                       updateUser(
  //                           name: name, phone: phone, bio: bio, cover: value);
  //                     })
  //                 .catchError((error) {
  //               emit(SocialUploadCoverImageErrorState());
  //             })
  //           })
  //       .catchError((error) {
  //     emit(SocialUploadCoverImageErrorState());
  //   });
  // }

  // void updateUserImages(
  //     {@required String name, @required String phone, @required String bio}) {
  //   emit(SocialUserUpdateLoadingState());
  //   if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null && profileImage != null) {
  //   } else {
  //     updateUser(name: name, phone: phone, bio: bio);
  //   }
  // }

  void updateUser(
      {@required String name,
      @required String phone,
      @required String bio,
      String cover,
      String image}) {
    SocialUserModel model = SocialUserModel(
        name: name,
        phone: phone,
        uId: socialUserModel.uId,
        bio: bio,
        email: socialUserModel.email,
        isEmailVerified: false,
        image: image ?? socialUserModel.image,
        cover: cover ?? socialUserModel.cover);
    FirebaseFirestore.instance
        .collection('users')
        .doc(socialUserModel.uId)
        .update(model.toMap())
        .then((value) => {
              getUserData(),
            })
        .catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  File postImage;
  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageErrorState());
  }

  void uploadPostImage({
    @required String dateTime,
    @required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          postImage: value,
          text: text,
          dateTime: dateTime,
        );
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    @required String dateTime,
    @required String text,
    String postImage,
  }) {
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
      name: socialUserModel.name,
      uId: socialUserModel.uId,
      image: socialUserModel.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) => {
              emit(SocialCreatePostSuccessState()),
            })
        .catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      });
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(socialUserModel.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users;
  void getUsers() {
    users = [];
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()[uId] != socialUserModel.uId)
          users.add(SocialUserModel.fromJson(element.data()));
      });
      emit(SocialGetAllUsersSuccessState());
    }).catchError((error) {
      emit(SocialGetAllUsersErrorState(error.toString()));
    });
  }
}
