import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({this.onChanged,required this.hintText, required this.labelText ,this.obscureText=false});
  String hintText;
  String labelText;
  Function(String)? onChanged;
  bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: (data){
        if(data!.isEmpty)
        {
          return 'The field is empty';
        }
        return null;
      },
     onChanged: onChanged,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.white),
        
        hintText: hintText,
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white),),
        label: Text(
          labelText,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
