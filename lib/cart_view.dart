import 'dart:convert';
import 'package:anglara/Model/products_model.dart';
import 'package:anglara/products_view.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:anglara/Model/cart_model.dart';
import 'package:flutter/material.dart';

class Cartview extends StatefulWidget {
  const Cartview({super.key});

  @override
  State<Cartview> createState() => _CartviewState();
}

class _CartviewState extends State<Cartview> {
  List<CartModel> cartList=[];
  @override
  void initState() {
    getCartAPI().then((value) {
      setState(() {
        
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: () {
              Get.to(()=>const ProductsView());
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.add_shopping_cart,size: 30),
            ))
        ],
      ),
      body: FutureBuilder(
        future: getCartAPI(),
        builder: (context, snapshot) {
        if(snapshot.hasData){
          final products=snapshot.data!.products;
          return ListView.builder(
        itemCount: products?.length,
        itemBuilder: (context, index) {
          final product=products![index];
        return FutureBuilder(
          future: getProductsAPI(product.productId!),
          builder: (context, snapshot) {
          if(snapshot.hasData){
            return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
             color: Colors.blueGrey.shade200,
                           elevation: 5.0,
                           child: Row(
                             children: [
                              
                               SizedBox(
                                height: 100,
                                width: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(snapshot.data!.image??""),
                                )),
                              //const SizedBox(width: 2,),
                               SizedBox(
                                   width: MediaQuery.of(context).size.width*0.5,
                                   child: Expanded(
                                     child: Column(
                                       crossAxisAlignment:
                                           CrossAxisAlignment.start,
                                       children: [
                                         const SizedBox(
                                           height: 5.0,
                                         ),
                                         RichText(
                                           overflow: TextOverflow.ellipsis,
                                           maxLines: 1,
                                           text: TextSpan(
                                               text: 'Name: ',
                                               style: TextStyle(
                                                   color: Colors.blueGrey.shade800,
                                                   fontSize: 16.0),
                                               children: [
                                                 TextSpan(
                                                  text: snapshot.data!.title,
                                                     style: const TextStyle(
                                                         fontWeight:
                                                             FontWeight.bold)),
                                               ]),
                                         ),
                                         RichText(
                                           maxLines: 1,
                                           text: TextSpan(
                                               text: 'Quantity: ',
                                               style: TextStyle(
                                                   color: Colors.blueGrey.shade800,
                                                   fontSize: 16.0),
                                               children: [
                                                 TextSpan(
                                                     text:
                                                         product.quantity.toString(),
                                                     style: const TextStyle(
                                                         fontWeight:
                                                             FontWeight.bold)),
                                               ]),
                                         ),
                                         RichText(
                                           maxLines: 1,
                                           text: TextSpan(
                                               text: 'Price: ' r"₹",
                                               style: TextStyle(
                                                   color: Colors.blueGrey.shade800,
                                                   fontSize: 16.0),
                                               children: [
                                                 TextSpan(
                                                     text:
                                                         snapshot.data!.price.toString(),
                                                     style: const TextStyle(
                                                         fontWeight:
                                                             FontWeight.bold)),
                                               ]),
                                         ),
                                       ],
                                     ),
                                   ),
                                 ),
                                 const SizedBox(width: 5,),
                                 IconButton(onPressed: () {
                                   
                                 }, icon: const Icon(Icons.delete,size: 30,))
                             ],
                           ),
          ),
        );
          }
          return  Container();
        },);
      },);
        }
        return  Container();
      },)
    );

  }
 Future<CartModel> getCartAPI()async{
  var response=await http.get(Uri.parse('https://fakestoreapi.com/carts/1'));
  if(response.statusCode==200){
    final parsed = json.decode(response.body); 
    //cartList= parsed.map<CartModel>((json) => CartModel.fromJson(json)).toList();
    return CartModel.fromJson(parsed);
  }
  else{
    throw Exception(response.reasonPhrase);
  }
}

 Future<ProductsModel> getProductsAPI(int id)async{
  var response=await http.get(Uri.parse('https://fakestoreapi.com/products/$id'));
  if(response.statusCode==200){
    final parsed = json.decode(response.body); 
    return ProductsModel.fromJson(parsed);
  }
  else{
    throw Exception(response.reasonPhrase);
  }
}


}