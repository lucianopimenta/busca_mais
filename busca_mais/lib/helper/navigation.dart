import 'package:buscamais/helper/transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future openPage(BuildContext context, Widget page, {bool replace}) {
  if (replace)
    return Navigator.pushReplacement(context, SlideRightRoute(page: page));
  else
    return Navigator.push(context, SlideRightRoute(page: page));
}

Future openPageTransition(BuildContext context, PageRouteBuilder builder) {
  return Navigator.push(context, builder);
}

void closePage(BuildContext context, Widget page) {
  Navigator.pop(context, null);
}