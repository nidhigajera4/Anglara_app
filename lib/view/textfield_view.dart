import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFeildView extends StatefulWidget {
  TextEditingController? controller;
  void Function()? onIconTap;
  void Function(String)? onChanged;
  bool? obscure;
  IconData? icon;
  String? labeltext;
   TextFeildView({super.key,this.icon,this.onIconTap,this.controller,this.onChanged,this.obscure,this.labeltext});

  @override
  State<TextFeildView> createState() => _TextFeildViewState();
}

class _TextFeildViewState extends State<TextFeildView> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: 20.0,bottom: 20.0),
      child: TextFormField(
            obscureText: widget.obscure??false,
            validator:(value) {
              if(value!.isEmpty){
                return 'Required field';
              }
              return null;
            }, 
            style:const TextStyle(color: Colors.black
            ),
            controller: widget.controller,
            onChanged: widget.onChanged,
            
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(fontWeight: FontWeight.w700,fontSize: 20),
                          label: Text(widget.labeltext??""),
                          suffixIcon: InkWell(
                            onTap: widget.onIconTap,
                            child: Icon(widget.icon)),
                            errorBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),borderSide:const BorderSide(color: Colors.red,width: 3.0))  ,
                          focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),borderSide:const BorderSide(color: Color.fromARGB(255, 27, 52, 193),width: 3.0)) ,
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),borderSide:const BorderSide(color: Color.fromARGB(255, 27, 52, 193),width: 3.0)),
                          
                        ),
                      ),
    );
  }
}