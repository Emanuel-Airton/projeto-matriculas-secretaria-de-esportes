import 'package:flutter/material.dart';

class CustomContainerTextformfield extends StatelessWidget {
  Widget? child;
  CustomContainerTextformfield({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }
}
