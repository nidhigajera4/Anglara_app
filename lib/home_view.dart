import 'dart:convert';
import 'package:anglara/Model/slider_model.dart';
import 'package:anglara/category_products_view.dart';
import 'package:anglara/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<SliderModel> sliderList=[];
   List categoryList=[];
   List searchCategory=[];
   final TextEditingController _searchcontroller=TextEditingController();
  @override
  void initState() {
    getImageAPI().then((value) {setState(() {
      
    });});
    getCategoryAPI().then((value) {setState(() {
      
    });});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [ Colors.indigo.shade200,
                                Colors.indigo.shade300,
                                Colors.indigo.shade400,
                                Colors.indigo.shade500,
                               ]),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20,),
                    Container(
              height: MediaQuery.of(context).size.height*0.13,
              width: MediaQuery.of(context).size.height*0.13,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200.0),
              color: Colors.white
              ),
              child: Icon(Icons.person,size: 30,color: Colors.indigo.shade200,),
              ),
              const SizedBox(height: 20,),
               Text(FirebaseAuth.instance.currentUser!.email??"",style:const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700
              ),),
              ListTile(
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Get.offAll(()=>const LoginView());
                  });
                },
                title: const Text('LogOut',style: TextStyle(fontSize: 17,color: Colors.white),),leading: const Icon(Icons.logout,size: 25,color: Colors.white,),)
                  ],
                ),
          ),
        ),
      ),
      appBar: AppBar(
        leadingWidth: MediaQuery.of(context).size.width*0.06,
        toolbarHeight: MediaQuery.of(context).size.height*0.1,
        //automaticallyImplyLeading: false,
        title:  TextField(
          controller: _searchcontroller,
          onChanged: (value) {
            setState(() {
              
            });
            onSearchTextChanged(value);
          },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'Search here',
              suffixIcon: InkWell(
                onTap: () async{
                  
                },
                child: const Icon(Icons.search))
            ),
          ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          
               CarouselSlider.builder(itemCount: sliderList.length
         , itemBuilder: (context, index, realIndex) {
           return Container(
                  margin:const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(sliderList[index].downloadUrl?? ""),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
         }, options:  CarouselOptions(
                height: 180.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration:const Duration(milliseconds: 800),
                viewportFraction: 0.8,
              )),
             
               Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: GridView.builder(  
                     itemCount:_searchcontroller.text.isNotEmpty?searchCategory.length: categoryList.length,  
                     gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(  
                      crossAxisCount: 2,  
                      crossAxisSpacing: 50.0,  
                      mainAxisSpacing: 20.0  
                     ),  
                     itemBuilder: (BuildContext context, int index){  
                    return InkWell(
                      onTap: () {
                        Get.to(()=>CategoryProductView(category: categoryList[index],));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.02,
                       
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [ Colors.indigo.shade200,
                                Colors.indigo.shade300,
                                Colors.indigo.shade400,
                                Colors.indigo.shade500,
                               ]),
                          borderRadius: BorderRadius.circular(20.0)
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(_searchcontroller.text.isNotEmpty?searchCategory[index]:categoryList[index],style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),))),
                    );  
                     },  
                   ),
                 ),
               ),  
      
          

        ],
      ),
    );
  }
  Future<void> getImageAPI()async{
  var response=await http.get(Uri.parse('https://picsum.photos/v2/list'));
  if(response.statusCode==200){
    
    final parsed = json.decode(response.body); 
    sliderList= parsed.map<SliderModel>((json) => SliderModel.fromJson(json)).toList();
  }
  else{
    throw Exception(response.reasonPhrase);
  }
  }
 Future<void> getCategoryAPI()async{
  var response=await http.get(Uri.parse('https://fakestoreapi.com/products/categories'));
  if(response.statusCode==200){
   
    categoryList= json.decode(response.body);
  }
  else{
    throw Exception(response.reasonPhrase);
  }
}

onSearchTextChanged(String text) {
    searchCategory = categoryList
        .where((element) => element
            .toString()
            .toLowerCase()
            .contains(text.toLowerCase()))
        .toList();
  }
}


