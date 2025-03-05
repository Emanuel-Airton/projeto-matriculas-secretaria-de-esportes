import 'package:flutter/material.dart';

class CustomContainerTextformfield extends StatelessWidget {
  Widget? child;
  CustomContainerTextformfield({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }
}
