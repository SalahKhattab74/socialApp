// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:social/models/user_model.dart';
import 'package:social/moduels/chat_details/chat_details_screen.dart';
import 'package:social/shared/components.dart';

Widget buildChatItem(SocialUserModel model, BuildContext context) {
  return InkWell(
    onTap: () {
      navigateTo(
        context,
        ChatDetailsScreen(
          userModel: model,
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage('${model.image}'),
          ),
          SizedBox(
            width: 15,
          ),
          Text('${model.name}', style: TextStyle(height: 1.4))
        ],
      ),
    ),
  );
}
