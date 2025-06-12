import 'package:flutter/material.dart';

class ContainerDadosMatricula extends StatelessWidget {
  final String? textoTopo;
  final String? textoDados;
  final Widget? widget;
  const ContainerDadosMatricula(
      {super.key, this.textoTopo, this.textoDados, this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 2, 15, 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              textoTopo!,
              style: TextStyle(
                  color: Colors.grey[700], fontWeight: FontWeight.w600),
            ),
          ),
          textoDados != null
              ? Row(
                  children: [
                    Text(textoDados!, style: TextStyle(color: Colors.grey)),
                    widget ?? Container()
                  ],
                )
              : widget ?? Container()
        ],
      ),
    );
  }
}
