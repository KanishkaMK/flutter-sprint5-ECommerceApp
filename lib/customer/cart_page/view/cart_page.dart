import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/customer/checkout_page/repo/oreder_collection_repo.dart';
import 'package:ecommerceapp/customer/cart_page/view/widget/cart_list.dart';
import 'package:ecommerceapp/customer/checkout_page/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late double grandTotal;
  //late double subtotal;

  List<Map<String, dynamic>> productsToBuyList = [];

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

          print(
              ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.$cartData");

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

            grandTotal = 0;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartDataDoc.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartDataDoc[index];

                 //   grandTotal = 0;

                    // final quantity = int.parse(cartItem['quantity'].toString());
                    // final price = double.parse(cartItem['price'].toString());
                    // final subtotal = quantity * price;
                    // grandTotal += subtotal;

                    // return CartList(cartDataDocIndex: cartDataDoc[index], quantity: quantity,);
                    
                   // subtotal = 0;
                    return FutureBuilder<DocumentSnapshot>(
                        future:
                            getProductDetails(cartItem['productId'] as String),
                        builder: (context, productSnapshot) {
                          if (!productSnapshot.hasData) {
                            return CircularProgressIndicator();
                          }

                          if (productSnapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }

                           final productData = productSnapshot.data!;

                          final quantity =
                              int.parse(cartItem['quantity'].toString());
                          final price =
                              double.parse(productData['price'].toString());
                          final subtotal = quantity * price;
                          grandTotal += subtotal;

                         
                          final productStock =
                              int.parse(productData['stock'].toString());


                              final singleToBuy = {
                                'productid': '${productData['productid']}',
                                'name': '${productData['name']}',
                                'price': '${productData['price']}',
                                'quantity': '${cartItem['quantity']}',
                              };

                              productsToBuyList.add(singleToBuy);





                          return ListTile(
                            title: Text(productData['name'].toString()),
                            // leading: CircleAvatar(
                            //   backgroundColor: Colors.blue),
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(productData['image'].toString()),
                            ),
                            subtitle: Text(productData['price'].toString()),

                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (quantity < productStock) {
                                          FirebaseFirestore.instance
                                              .collection('cart')
                                              .doc(cartItem.id)
                                              .update(
                                                  {'quantity': quantity + 1});
                                        } else {
                                          print('exceeding stock');
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            duration: Duration(seconds: 1),
                                            content: Text(
                                              'Exeeding Stock',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            backgroundColor: Colors.red,
                                          ));
                                        }
                                      });
                                    },
                                    child: Icon(Icons.add),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(cartItem['quantity'].toString()),
                                ),
                                if (quantity >= 1)
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        FirebaseFirestore.instance
                                            .collection('cart')
                                            .doc(cartItem.id)
                                            .update({'quantity': quantity - 1});
                                      });
                                    },
                                    child: Icon(Icons.remove),
                                  )
                                else
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        FirebaseFirestore.instance
                                            .collection('cart')
                                            .doc(cartItem.id)
                                            .delete();
                                      });
                                    },
                                    child: Icon(Icons.delete_forever),
                                  )
                              ],
                            ),
                          );
                        });
                  },
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 228, 213, 157)),
                  onPressed: () async {
                    final orderId = await OrderCollectionRepo()
                        .placeOrder(cartData, context);

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => CheckOutPage(
                    //         grandTotal: grandTotal,
                    //         cartData: cartData,
                    //         orderId: orderId,
                    //       ),
                    //     ));

                    await Get.off(CheckOutPage(
                      grandTotal: grandTotal,
                      productsToBuyList: productsToBuyList.toSet().toList(),
                      orderId: orderId,
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

  Future<DocumentSnapshot> getProductDetails(String productId) async {
    final productDocument = await FirebaseFirestore.instance
        .collection('productcollection')
        .doc(productId)
        .get();
    return productDocument;
  }
}
