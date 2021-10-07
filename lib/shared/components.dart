// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social/shared/styles/colors.dart';
import 'package:social/shared/styles/icon_broken.dart';

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPass = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      validator: validate,
      obscureText: isPass,
      onTap: onTap,
      enabled: isClickable,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixPressed,
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );
void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (Route<dynamic> route) => false);
Widget defaultButton({
  width = double.infinity,
  background = Colors.blue,
  bool isUpperCase = true,
  double radius = 0.0,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      height: 40,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: background,
      ),
    );
Widget defaultAppbar({
  @required BuildContext context,
  String title,
  List<Widget> actions,
}) =>
    AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          IconBroken.Arrow___Left_2,
          color: Colors.black,
        ),
      ),
      titleSpacing: 5.0,
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      actions: actions,
    );
Widget defaultTextButton(
        {@required Function function, @required String text}) =>
    TextButton(
      onPressed: function,
      child: Text(text.toUpperCase()),
    );
void showToast({@required String text, @required ToastStates state}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );
enum ToastStates { SUCCESS, ERROR, WARNING }
Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget customMaterialButton({String text, BuildContext context}) {
  return Padding(
    padding: const EdgeInsetsDirectional.only(end: 6.0),
    child: Container(
      height: 20.0,
      child: MaterialButton(
        minWidth: 1.0,
        padding: EdgeInsets.zero,
        height: 25.0,
        onPressed: () {},
        child: Text(
          text,
          style:
              Theme.of(context).textTheme.caption.copyWith(color: defaultColor),
        ),
      ),
    ),
  );
}

Widget customExpanded(
    {BuildContext context,
    IconData icon,
    String text,
    MainAxisAlignment main,
    Function onTap}) {
  return Expanded(
    child: InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: main,
          children: [
            Icon(
              icon,
              color: Colors.red,
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      ),
      onTap: onTap,
    ),
  );
}

Widget buildNumbersField(
    {BuildContext context, String text1, String text2, Function onTap}) {
  return Expanded(
    child: InkWell(
      child: Column(
        children: [
          Text(
            text1,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(
            text2,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
      onTap: onTap,
    ),
  );
}
