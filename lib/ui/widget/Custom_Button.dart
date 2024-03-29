import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   CustomButton({super.key,this.text,this.onTap});
  String? text;
  VoidCallback ? onTap;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap:onTap ,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        width: double.infinity,
        height: 60.0,
        child: Center(child: Text('$text',style: TextStyle(fontSize: 18),)),
      ),
    );
    ;
  }
}
