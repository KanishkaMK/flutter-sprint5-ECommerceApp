import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/customer/checkout_page/repo/oreder_collection_repo.dart';
import 'package:ecommerceapp/customer/cart_page/view/widget/cart_list.dart';
import 'package:ecommerceapp/customer/checkout_page/checkout_page.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double grandTotal = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: Text(
          'Cart Page',
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

          final cartDataDoc = snapshot.data!.docs;
          final cartData = snapshot.data!;

          // return GridView.builder(
          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //     mainAxisSpacing: 5,
          //     crossAxisSpacing: 0,
          //     childAspectRatio: 0.5,
          //   ),
          //    itemCount: cartData.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     return CartList(cartData:  cartData[index]);
          //   },
          // );

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartDataDoc.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartDataDoc[index];

                    final quantity = int.parse(cartItem['quantity'].toString());
                    final price = double.parse(cartItem['price'].toString());
                    final subtotal = quantity * price;
                    grandTotal += subtotal;

                    return CartList(cartDataDocIndex: cartDataDoc[index]);
                  },
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 241, 225, 169)),
                  onPressed: () {
                    //  await OrderCollectionRepo().createOrderCollection(cartData, context);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CheckOutPage(grandTotal: grandTotal),
                        ));
                  },
                  child: Text(
                    'Checkout',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w300),
                  ))
            ],
          );
        },
      ),
    );
  }
}
