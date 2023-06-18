import 'dart:convert';

import 'package:anglara/Model/products_model.dart';
import 'package:anglara/single_product_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// ignore: must_be_immutable
class CategoryProductView extends StatefulWidget {
  String? category;
   CategoryProductView({super.key,this.category});

  @override
  State<CategoryProductView> createState() => _CategoryProductViewState();
}

class _CategoryProductViewState extends State<CategoryProductView> {
  final TextEditingController _searchcontroller=TextEditingController();
  List<ProductsModel> searchCategotyProduct=[];
  List<ProductsModel> productList=[];
  List<ProductsModel> categoryproductList=[];
  @override
  void initState() {
    getProductsAPI().then((value) {setState(() {
      
    });});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
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
          
          Expanded(
                   child: ListView.builder(
                    itemCount:_searchcontroller.text.isNotEmpty?searchCategotyProduct.length: categoryproductList.length,
                    itemBuilder: (context, index) {
                     return InkWell(
                      onTap: () {
                        Get.to(()=> ProductDeatailView(obj:_searchcontroller.text.isNotEmpty?searchCategotyProduct[index]:categoryproductList[index]));
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
                                      child: Image.network(_searchcontroller.text.isNotEmpty? searchCategotyProduct[index].image??"":categoryproductList[index].image??"",fit: BoxFit.fill,)),
                                      trailing: const Icon(Icons.add_shopping_cart_sharp),
                                    title:Text(_searchcontroller.text.isNotEmpty?searchCategotyProduct[index].title??"": categoryproductList[index].title??"",
                                    maxLines: 2,
                                    style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
                                    subtitle:Text(_searchcontroller.text.isNotEmpty?searchCategotyProduct[index].category??"":categoryproductList[index].category??"",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
                                                            
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

   Future<void> getProductsAPI()async{
  var response=await http.get(Uri.parse('https://fakestoreapi.com/products'));
  if(response.statusCode==200){
    final parsed = json.decode(response.body); 
    productList= parsed.map<ProductsModel>((json) => ProductsModel.fromJson(json)).toList();
    categoryproductList = productList
                      .where((element) => element.category
                          .toString()
                          .contains(widget.category??""))
                      .toList();
  }
  else{
    throw Exception(response.reasonPhrase);
  }
}

  onSearchTextChanged(String text)   {
    searchCategotyProduct = categoryproductList
        .where((element) => element.title
            .toString()
            .toLowerCase()
            .contains(text.toLowerCase()))
        .toList();
         }


}