import 'package:anglara/login_view.dart';
import 'package:anglara/main_home_screen.dart';
import 'package:anglara/view/button_view.dart';
import 'package:anglara/view/textfield_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpview extends StatefulWidget {
  const SignUpview({super.key});

  @override
  State<SignUpview> createState() => _SignUpviewState();
}

class _SignUpviewState extends State<SignUpview> {
  bool isvisible=false;
  final TextEditingController _emailcontroller=TextEditingController();
  final TextEditingController _passwordcontroller=TextEditingController();
  final formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset('assets/images/bg.jpg',fit: BoxFit.fitWidth)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Sign Up',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800),),
                      TextFeildView(labeltext: 'E-mail',icon: Icons.email,controller: _emailcontroller,),
                  TextFeildView(labeltext: 'Password',icon:isvisible? Icons.visibility_off:Icons.visibility,obscure: isvisible,controller: _passwordcontroller,onIconTap: () {
                    setState(() {
                      isvisible=!isvisible;
                    });
                  },),
                   ButtonView(data: 'Sign Up',onTap: () async{
                     if(formkey.currentState!.validate()){
                      await signUpUser(email: _emailcontroller.text, password: _passwordcontroller.text);
                      Get.to(()=>const MainHomeView());
                     }
                   },),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Do you have an account?",style:  TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                      TextButton(onPressed: () {
                        Get.to(()=>const LoginView());
                      }, child: const Text('Login',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))
                    ],
                   )
                    ],
                  ),
                )
                
            ],
          ),
        ),
      ),
    );
  }
 signUpUser({
    required String email,
    required String password,
  }) async {   
        UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email, password: password);
        // ignore: avoid_print
        print(user.user!.uid);
  }
}