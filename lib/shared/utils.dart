// ignore_for_file: unnecessary_this

import 'package:flutter/widgets.dart';

extension StringExtension on String 
{
    String capitalize() {
      return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
    }
}


bool ifThereAreMoreWidgets(BuildContext context) {
  final route = ModalRoute.of(context);
  return route?.canPop ?? false;
}


