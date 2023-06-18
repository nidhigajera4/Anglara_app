import 'package:flutter/material.dart';

import 'Model/products_model.dart';

// ignore: must_be_immutable
class ProductDeatailView extends StatefulWidget {
  ProductsModel obj;
   ProductDeatailView({super.key,required this.obj});

  @override
  State<ProductDeatailView> createState() => _ProductDeatailViewState();
}

class _ProductDeatailViewState extends State<ProductDeatailView> {
  ProductsModel? productList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: const Center(child:  Text("Product Deatials")),
        actions: const [
          Icon(Icons.shopping_cart)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.4,
                
                child: Image.network(widget.obj.image??"")),
                         const SizedBox(height: 20,),
                          Text(widget.obj.title??"",style: const TextStyle(fontWeight: FontWeight.w900,fontSize: 25),),
                         const SizedBox(height: 10,),
                         Row(
                          children: [
            const Text("Price: ",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20),),
            Text('${widget.obj.price}/-',style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),

                          ],
                         ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(widget.obj.category??"",style: const TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.w700,fontSize: 18),)),
              
              const SizedBox(height: 20,),
              Text(widget.obj.description??"",style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 20),),
            ],
          ),
        ),
      ),
    );
  }



}