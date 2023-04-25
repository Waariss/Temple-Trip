import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

PreferredSizeWidget customAppBar({
  dynamic titleElement,
  BuildContext? context,
}) {
  return AppBar(
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: const Color(0xFFFDB741),
    title: GestureDetector(
      child: titleElement ??
        Text(
          'Temple Trip',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
          color: Colors.black,
          ),
          ),
    ),
    toolbarHeight: kToolbarHeight,
  );
}
