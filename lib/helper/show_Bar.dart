
import 'package:flutter/material.dart';

void showBar(BuildContext context, String massage) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(massage)));
  }