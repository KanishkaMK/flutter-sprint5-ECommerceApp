import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/customer/cart_page/cart_page.dart';
import 'package:ecommerceapp/customer/product_details/product_details.dart';
import 'package:ecommerceapp/customer/home_customer/view/widgets/product_list.dart';
import 'package:flutter/material.dart';

class HomePageCustomer extends StatelessWidget {
  const HomePageCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: Text(
          'ECommerceApp',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          // IconButton(onPressed: () {
          //   Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(),));

          // }, icon: Icon(Icons.add_to_photos)),

          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(),
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(Icons.shopping_cart),
              )),
        ],
      ),
      // body: GestureDetector(
      //   onTap: () {
      //     Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsPage(), ));
      //   },
      //   child: CradWidget()),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('productcollection').snapshots(),
        builder: (context, snapshot) {

           if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final products = snapshot.data!.docs;



          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 0,
              childAspectRatio: 0.5,
            ),
             itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              return ProductList(productData: products[index]);
            },
          );
        },
      ),
    );
  }
}
