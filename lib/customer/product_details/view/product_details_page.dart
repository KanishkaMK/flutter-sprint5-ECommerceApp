import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/customer/product_details/repo/add_to_cart_repo.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key,required this.productDataDocIndex});
  final QueryDocumentSnapshot<Map<String, dynamic>> productDataDocIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: Text(
          'ECommerceApp',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),

      
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            // child: Image.asset(
            //   'assets/images/teddy-bear.png',
            //   height: 300,
            //   width: 300,
            // ),
            child: Image.network(productDataDocIndex['image'][0].toString(),
            height: 300,
            width: 300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Product Name : ${productDataDocIndex['name'].toString()}',
            style: TextStyle(color: Colors.black,
            fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Product Price : ${productDataDocIndex['price'].toString()}',
            style: TextStyle(color: Colors.black,
            fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Product code : ${productDataDocIndex['code'].toString()}',
            style: TextStyle(color: Colors.black,
            fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Product Description : ${productDataDocIndex['description'].toString()}',
            style: TextStyle(color: Colors.black,
            fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Product Stock : ${productDataDocIndex['stock'].toString()}',
            style: TextStyle(color: Colors.black,
            fontWeight: FontWeight.bold),),
          ),




          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 235, 208, 128)),
            onPressed: () async {
            await AddToCartRepo().addToCart(productDataDocIndex, context);
            Navigator.pop(context);
          }, child: Text('ADD TO CART',style: TextStyle(color: Colors.black,
            fontWeight: FontWeight.bold),))
        ],
      ),
    );
  }
}