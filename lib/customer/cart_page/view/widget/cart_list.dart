import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/customer/product_details/view/product_details_page.dart';
import 'package:flutter/material.dart';

class CartList extends StatelessWidget {
  CartList({Key? key, required this.cartData}) : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>> cartData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
         
        },
        child: Center(
          child: Container(
            height: 200,
            width: 200,
            child: Card(
              margin: EdgeInsets.all(16.0),
              elevation: 4.0,
              child: Column(
            
                children: [
                  //  Text('PRODUCT DETAILS',
                  //  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),

                  Image.network(
                    cartData['imageUrl'].toString(),
                    height: 100,
                    width: 100,
                  ),
                  Text(cartData['productName'].toString()),
                  Text(cartData['price'].toString()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
