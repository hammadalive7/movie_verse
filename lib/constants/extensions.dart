import 'package:flutter/material.dart';

extension MediaQueryExtension on BuildContext{

  Size? size(){
    return MediaQuery.sizeOf(this);
  }

  TextTheme? textTheme(){
    return Theme.of(this).textTheme;
  }
}