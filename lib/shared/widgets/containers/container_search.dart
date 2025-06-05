import 'package:flutter/material.dart';

class ContainerSearch extends StatelessWidget {
  final String texto;
  TextEditingController controller;
  dynamic Function(String) function;
  ContainerSearch(
      {super.key,
      required this.texto,
      required this.function,
      required this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.4,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) => function(value),
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                hintStyle: TextStyle(color: Colors.grey[500]),
                hintText: texto,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
