import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/customer/product_details/view/product_details_page.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  ProductList({Key? key, required this.productDataDocIndex}) : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>> productDataDocIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProductDetailsPage(productDataDocIndex: productDataDocIndex),
              ));
        },
        child: Center(
          child: Container(
            color: Color.fromARGB(255, 180, 180, 178),
            height: 200,
           // width: 200,
            child: Card(
              margin: EdgeInsets.all(16.0),
              elevation: 4.0,
              child: Column(
                children: [
                  //  Text('PRODUCT DETAILS',
                  //  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),

                  Expanded(
                    child: Image.network(
                      productDataDocIndex['image'][0].toString(),
                      fit: BoxFit.cover,
                      width: 200
                    ),
                  ),
                  Text(productDataDocIndex['name'].toString()),
                  Text(productDataDocIndex['price'].toString()),
                ],
              ),
            ),
          ),
        ),


        // child: Card(
        //     //  margin: EdgeInsets.all(16.0),
        //       elevation: 0.1,
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.stretch,
        //         children: [
        //           //  Text('PRODUCT DETAILS',
        //           //  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),

        //           Image.network(
        //             productDataDocIndex['image'][0].toString(),
        //             fit: BoxFit.cover,
        //             width: 200
        //           ),
        //           Text(productDataDocIndex['name'].toString()),
        //           Text(productDataDocIndex['price'].toString()),
        //         ],
        //       ),
        //     ),
      ),
    );
  }
}
