import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/customer/product_details/view/product_details_page.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  ProductList({Key? key, required this.productData}) : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>> productData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProductDetailsPage(productData: productData),
              ));
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
                    productData['image'][0].toString(),
                    height: 50,
                    width: 50,
                  ),
                  Text(productData['name'].toString()),
                  Text(productData['price'].toString()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
