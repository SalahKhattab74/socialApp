import 'package:flutter/material.dart';

// void signOut (context){
//   CacheHelper.removeData(key: 'token').then((value) => {
//     if(value){
//       navigateAndFinish(context,ShopLoginScreen()),
//     }
//   });
// }
void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';
String uId = '';

const String myText =
    'Software engineering is the systematic application of engineering approaches to the development of software. A software engineer is a person who applies the principles of software engineering to design, develop, maintain, test, and evaluate computer software. ... Modern processes use software versioning';
const defaultImge =
    'https://scontent.fcai19-4.fna.fbcdn.net/v/t1.6435-9/242310966_2078994598915064_2364866162395182050_n.jpg?_nc_cat=105&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=_lUrSJv72mQAX-Kyrts&_nc_ht=scontent.fcai19-4.fna&oh=3c8baf812cc9c655809fb9fc94351458&oe=6178838C';
