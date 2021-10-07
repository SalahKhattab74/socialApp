// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, missing_required_param

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/moduels/new_post/new_post_screen.dart';
import 'package:social/shared/components.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:social/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState) {
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications_none_outlined),
              ),
              IconButton(
                icon: Icon(Icons.search_outlined),
              )
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavyBar(
            selectedIndex: cubit.currentIndex,
            onItemSelected: (index) {
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavyBarItem(
                icon: Icon(Icons.home_outlined),
                title: Text('Home'),
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.chat_bubble_outline_sharp),
                title: Text('Chats'),
              ),
              BottomNavyBarItem(
                icon: Icon(IconBroken.Paper_Upload),
                title: Text('Add Post'),
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.location_history_outlined),
                title: Text('Users'),
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.settings_applications_outlined),
                title: Text('Settings'),
              ),
            ],
          ),
          // body: SocialCubit.get(context).socialUserModel != null
          //     ? Column(
          //         children: [
          //           if (FirebaseAuth.instance.currentUser.emailVerified)
          //             Container(
          //               color: Colors.amber.withOpacity(0.6),
          //               child: Padding(
          //                 padding: EdgeInsets.symmetric(horizontal: 20.0),
          //                 child: Row(
          //                   children: [
          //                     Icon(Icons.info),
          //                     Expanded(
          //                       child: Text('Please Verify you email'),
          //                     ),
          //                     SizedBox(width: 15.0),
          //                     defaultTextButton(
          //                         function: () {
          //                           FirebaseAuth.instance.currentUser
          //                               .sendEmailVerification()
          //                               .then((value) {
          //                             showToast(
          //                                 text: 'Check Your mail',
          //                                 state: ToastStates.SUCCESS);
          //                           }).catchError((error) {
          //                             error.toString();
          //                           });
          //                         },
          //                         text: 'Send')
          //                   ],
          //                 ),
          //               ),
          //             ),
          //         ],
          //       )
          //     : CircularProgressIndicator(),
        );
      },
    );
  }
}
