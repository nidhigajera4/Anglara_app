import 'dart:convert';

import 'package:anglara/Model/products_model.dart';
import 'package:anglara/single_product_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'Model/cart_update.dart';
import 'Model/slider_model.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final TextEditingController _searchcontroller=TextEditingController();
    List<SliderModel> sliderList=[];
    List<ProductsModel> productList=[];
    List<ProductsModel> searchProduct=[];
@override
  void initState() {
    
      getImageAPI().then((value) {setState(() {
        
      });});
      getProductsAPI().then((value){
        setState(() {
        
      });});
   
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /* actions: [
          InkWell(
            onTap: () {
              Get.to(()=>ProductsView());
            },
            child: Icon(Icons.add_shopping_cart,size: 30))
        ], */
        toolbarHeight: MediaQuery.of(context).size.height*0.1,
        
        title:  TextFormField(
          controller: _searchcontroller,
          onChanged: (value) {
            setState(() {
              
            });
           onSearchTextChanged(value);
          },
            decoration: InputDecoration(
              border:const OutlineInputBorder(),
              hintText: 'Search here',
              suffixIcon: InkWell(
                onTap: () async{
                  
                },
                child: const Icon(Icons.search))
            ),
          ),
      ),
      body: Column(
        
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
                   child: ListView.builder(
                    itemCount:_searchcontroller.text.isNotEmpty?searchProduct.length: productList.length,
                    itemBuilder: (context, index) {
                     return InkWell(
                      onTap: () {
                        Get.to(()=> ProductDeatailView(obj:_searchcontroller.text.isNotEmpty?searchProduct[index]:productList[index]));
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Colors.indigo.shade200,
                              child: SizedBox(
                                height: 120,
                                child: Center(
                                  child: ListTile(
                                    leading: SizedBox(
                                      height: 100,
                                      width: 90,
                                      child: Image.network(_searchcontroller.text.isNotEmpty? searchProduct[index].image??"":productList[index].image??"",fit: BoxFit.fill,)),
                                      trailing: InkWell(
                                        onTap: () async{
                                          await addCartAPI(productList[index].id!);
                                        },
                                        child: const Icon(Icons.add_shopping_cart_sharp)),
                                    title:Text(_searchcontroller.text.isNotEmpty?searchProduct[index].title??"": productList[index].title??"",
                                    maxLines: 2,
                                    style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
                                    subtitle:Text(_searchcontroller.text.isNotEmpty?searchProduct[index].category??"":productList[index].category??"",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
                                                            
                                  ),
                                ),
                              ),
                            ),
                          ),                              
                        ],
                    
                      ),
                    );  
                   },))
                     
                     
                     
                    
      
        ],
      ),
    );
  }
  Future<void> getImageAPI()async{
  var response=await http.get(Uri.parse('https://picsum.photos/v2/list'));
  if(response.statusCode==200){
    
    final parsed = json.decode(response.body); 
    sliderList= (parsed.map<SliderModel>((json) => SliderModel.fromJson(json)).toList());
    
  }
  else{
    throw Exception(response.reasonPhrase);
  }
}
 Future<void> getProductsAPI()async{
  var response=await http.get(Uri.parse('https://fakestoreapi.com/products'));
  if(response.statusCode==200){
    final parsed = json.decode(response.body); 
    productList= parsed.map<ProductsModel>((json) => ProductsModel.fromJson(json)).toList();
    // ignore: avoid_print
    print(productList);
  }
  else{
    throw Exception(response.reasonPhrase);
  }
}
 Future<void> addCartAPI(int productId)async{
  final cart=CartUpdate(userId: 1,date: DateTime.now(),products: [
    {'productId':productId,'quantity':1}
  ]);
  var response=await http.post(Uri.parse('https://fakestoreapi.com/carts'),body: json.encode(cart.toJson()));
  if(response.statusCode==200){
     json.decode(response.body); 
   
  }
  else{
    throw Exception(response.reasonPhrase);
  }
}


 Future<void> updateCartAPI(int productId)async{
  final cart=CartUpdate(userId: 1,date: DateTime.now(),products: [
    {'productId':productId,'quantity':1}
  ]);
  var response=await http.put(Uri.parse('https://fakestoreapi.com/carts/1'),body: json.encode(cart.toJson()));
  if(response.statusCode==200){
     json.decode(response.body); 
   
  }
  else{
    throw Exception(response.reasonPhrase);
  }
}


onSearchTextChanged(String text)   {
    searchProduct = productList
        .where((element) => element.title
            .toString()
            .toLowerCase()
            .contains(text.toLowerCase()))
        .toList();
  }
}
