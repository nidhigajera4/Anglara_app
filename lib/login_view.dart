import 'package:anglara/main_home_screen.dart';
import 'package:anglara/signup_view.dart';
import 'package:anglara/view/button_view.dart';
import 'package:anglara/view/textfield_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isvisible=false;
  final TextEditingController _emailcontroller=TextEditingController();
  final TextEditingController _passwordcontroller=TextEditingController();
  final formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.white,
      //appBar: AppBar(title: const Text('hello mini'),),
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
                      const Text('Login',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800),),
                      TextFeildView(controller: _emailcontroller,labeltext: 'E-mail',icon: Icons.email,),
                  TextFeildView(controller: _passwordcontroller,labeltext: 'Password',icon:isvisible? Icons.visibility:Icons.visibility_off,obscure: isvisible,onIconTap: () {
                    setState(() {
                      isvisible=!isvisible;
                    });
                  },),
                   ButtonView(data: 'Login',onTap: () {
                     //Get.to(()=>const MainHomeView());
                     if(formkey.currentState!.validate()){
                                           logInUser(email: _emailcontroller.text, password: _passwordcontroller.text);

                     }
                   },),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have any account?",style:  TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                      TextButton(onPressed: () {
                        Get.to(()=>const SignUpview());
                      }, child: const Text('Sign Up',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))
                    ],
                   ),
                  /*  Container(
                    height: 60,
                    width: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black,width: 4),borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person),
                          const Text('hello  ini'),
                            ],
                          ),
                          
                          Icon(Icons.more)
                        ],
                      ),
                    ),
                   ) */
                    ],
                  ),
                )
                
            ],
          ),
        ),
      ),
    );
  }
  
   logInUser({
    required String email,
    required String password,
  }) async {
   
   await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email, password: password).then((value) {
              Get.to(()=>const MainHomeView());
            });
      /* if(response==null){
        Get.snackbar('Error!', 'Invalid data,please enter right information.');
      }  */
      
   
  }
}