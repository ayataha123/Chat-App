
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Button extends StatelessWidget {
  Button({this.onTap,required this.text}) ;
  VoidCallback ?onTap;
String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
              onTap: onTap,
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Text(
                  text,
                  style: TextStyle(color: Color(0xff2B475E)),
                ),
              ),
            );
  }
}