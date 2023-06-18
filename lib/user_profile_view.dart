import 'package:anglara/login_view.dart';
import 'package:anglara/products_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfileView extends StatefulWidget {
  const MyProfileView({super.key});

  @override
  State<MyProfileView> createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('My Profile')),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.indigo.shade200
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
            height: MediaQuery.of(context).size.height*0.15,
            width: MediaQuery.of(context).size.height*0.15,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200.0),
            color: Colors.white
            ),
            child: Icon(Icons.person,size: 50,color: Colors.indigo.shade200,),
            ),
            const SizedBox(height: 20,),
             Text(FirebaseAuth.instance.currentUser!.email??"",style:const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700
            ),),
            const SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: InkWell(
                    onTap: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        Get.to(()=>const LoginView());
                      });
                    },
                    child: const  CircleAvatar(
                      child: Icon(Icons.logout),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: InkWell(
                    onTap: () {
                      Get.to(()=>const ProductsView());
                    },
                    child: const CircleAvatar(
                      child: Icon(Icons.shopping_cart),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                  width: 50,
                  child: CircleAvatar(
                    child: Icon(Icons.edit),
                  ),
                ),
                
              ],
            )
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}