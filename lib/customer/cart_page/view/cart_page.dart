import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/customer/cart_page/view/widget/cart_list.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const  CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('cart').snapshots(),
        builder: (context, snapshot) {

           if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final cartData = snapshot.data!.docs;



          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 0,
              childAspectRatio: 0.5,
            ),
             itemCount: cartData.length,
            itemBuilder: (BuildContext context, int index) {
              return CartList(cartData:  cartData[index]);
            },
          );
        },
      ),
    );
  }
}