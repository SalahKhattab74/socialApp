// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_is_empty, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/models/post_model.dart';
import 'package:social/shared/components.dart';
import 'package:social/shared/constants.dart';
import 'package:social/shared/styles/colors.dart';
import 'package:social/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialCubit, SocialStates>(
      builder: (context, state) {
        if (SocialCubit.get(context).posts.length > 0 &&
            SocialCubit.get(context).socialUserModel != null) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  elevation: 5.0,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: const EdgeInsets.all(8),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        image: NetworkImage(
                            'https://image.freepik.com/free-photo/emotional-bearded-male-has-surprised-facial-expression-astonished-look-dressed-white-shirt-with-red-braces-points-with-index-finger-upper-right-corner_273609-16001.jpg'),
                        fit: BoxFit.cover,
                        height: 200.0,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text('communicate With friends',
                            style: Theme.of(context).textTheme.subtitle2),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPostItem(
                      context, SocialCubit.get(context).posts[index], index),
                  itemCount: SocialCubit.get(context).posts.length,
                  separatorBuilder: (context, index) => SizedBox(
                    height: 8.0,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation(Colors.pink),
            ),
          );
        }
      },
    );
  }
}

Widget buildPostItem(context, PostModel model, index) => Card(
      elevation: 5.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage('${model.image}'),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('${model.name}', style: TextStyle(height: 1.4)),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 16,
                          ),
                        ],
                      ),
                      Text(
                        '${model.dateTime}',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(height: 1.4),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_horiz_outlined,
                    size: 16.0,
                  ),
                  onPressed: () {},
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Text(
              '${model.text}',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 10, top: 5),
            //   child: Container(
            //     width: double.infinity,
            //     child: Wrap(
            //       children: [
            //         customMaterialButton(text: '#software', context: context),
            //         customMaterialButton(text: '#software', context: context),
            //         customMaterialButton(text: '#software', context: context),
            //         customMaterialButton(text: '#software', context: context),
            //         customMaterialButton(text: '#software', context: context),
            //         customMaterialButton(text: '#software', context: context),
            //         customMaterialButton(text: '#software', context: context),
            //         customMaterialButton(text: '#software', context: context),
            //       ],
            //     ),
            //   ),
            // ),
            if (model.postImage != '')
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 15.0),
                child: Container(
                  height: 150.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      image: DecorationImage(
                        image: NetworkImage('${model.postImage}'),
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  customExpanded(
                      onTap: () {},
                      main: MainAxisAlignment.start,
                      context: context,
                      icon: IconBroken.Heart,
                      text: '${SocialCubit.get(context).likes[index]}'),
                  customExpanded(
                      onTap: () {},
                      main: MainAxisAlignment.end,
                      context: context,
                      icon: IconBroken.Chat,
                      text: '0 comments'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18.0,
                          backgroundImage: NetworkImage(
                              '${SocialCubit.get(context).socialUserModel.image}'),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Write a comment ... ',
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(height: 1.4),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
                customExpanded(
                  text: 'Like',
                  icon: IconBroken.Heart,
                  onTap: () {
                    SocialCubit.get(context)
                        .likePost(SocialCubit.get(context).postsId[index]);
                  },
                  main: MainAxisAlignment.end,
                  context: context,
                )
              ],
            ),
          ],
        ),
      ),
    );
