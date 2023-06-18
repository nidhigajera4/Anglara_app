import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonView extends StatefulWidget {
  String? data;
  void Function()? onTap;
   ButtonView({super.key,this.data,this.onTap});

  @override
  State<ButtonView> createState() => _ButtonViewState();
}

class _ButtonViewState extends State<ButtonView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: MediaQuery.of(context).size.height*0.08,
        width: MediaQuery.of(context).size.width*0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200.0),
          boxShadow: const[BoxShadow(offset: Offset(2.0, 2.0),color: Colors.grey)],
          border: Border.all(color: Colors.indigo.shade100,width: 3),
          gradient: LinearGradient(colors: [
           
            Colors.indigo.shade200,
            Colors.indigo.shade300,
            Colors.indigo.shade400,
            Colors.indigo.shade500,
            Colors.indigo.shade600
          ])
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(widget.data??"",style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w600),)),
      ),
    );
  }
}