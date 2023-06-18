import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextView extends StatefulWidget {
  String data;
   TextView({super.key,required this.data});

  @override
  State<TextView> createState() => _TextViewState();
}

class _TextViewState extends State<TextView> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.data,style:const TextStyle(),);
  }
}