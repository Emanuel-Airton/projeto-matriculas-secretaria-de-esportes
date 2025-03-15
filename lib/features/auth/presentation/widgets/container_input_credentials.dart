import 'package:flutter/material.dart';

class ContainerInputCredentials extends StatelessWidget {
  final Widget child1;

  const ContainerInputCredentials({super.key, required this.child1});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.sizeOf(context).width * 0.25,
        height: MediaQuery.sizeOf(context).height * 0.05,
        padding: EdgeInsets.only(left: 15.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.grey[200]),
        child: child1);
  }
}
