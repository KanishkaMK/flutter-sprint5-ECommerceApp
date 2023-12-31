import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewOrder extends StatefulWidget {
  const ViewOrder({super.key});

  @override
  State<ViewOrder> createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {
  List<Map<String, dynamic>> finalMap = [];
   final sellerID = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: Text(
          'View Confirmed Order here...',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('ordercollection')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final orders = snapshot.data!.docs;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                 final productIDMap = orders[index]['productid'] as Map<String, dynamic>;
                final quantityMap = orders[index]['quantity'] as Map<String, dynamic>;
                final userID = orders[index]['userid'] as String;

                return FutureBuilder(
                 future: fetchProductData(productIDMap),
                 builder: (context, productSnapshot) {
                    if (productSnapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (productSnapshot.hasError) {
                      return Text('Error: ${productSnapshot.error}');
                    } else if (!productSnapshot.hasData || productSnapshot.data!.isEmpty) {
                      return const Text('No Products Found');
                    } else {
                      final List<Widget> productWidgets = [];
                      final productData = productSnapshot.data as Map<String, dynamic>;

                       final Future<Map<String, dynamic>> userDataFuture = fetchUserData(userID);

                       return FutureBuilder(
                        future: userDataFuture, 
                        builder: (context, userSnapshot) {
                           if (userSnapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (userSnapshot.hasError) {
                            return Text('Error: ${userSnapshot.error}');
                          } else {
                            final userName = userSnapshot.data?['name'] as String?;
                            final userPhoneNum = userSnapshot.data?['phone'] as String?;
                            for (final pid in productIDMap.values) {
                              if (productData.containsKey(pid) &&
                                  productData[pid]['userid'] == sellerID) {
                                final product = productData[pid];

                                productWidgets.add(
                                  Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.all(15),
                                    padding: const EdgeInsets.all(15),
                                    color: Colors.grey.shade300,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'User: ${userName},  Phone: ${userPhoneNum}',
                                          style:
                                              TextStyle(fontSize: 16), // Adjust font size as needed
                                        ),
                                        const Divider(),
                                        Text(
                                          '${quantityMap[pid]} X ${product['name']}',
                                          style: const TextStyle(
                                              fontSize: 16), // Adjust font size as needed
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            }
                            return Column(
                              children: productWidgets,
                           );
                          }
                        },
                      );
                    }
                  },
                );
              },
            );
          }
           return const Center(child: Text('No Order Data'));
        },
      ),
    );
  }




Future<Map<String, dynamic>> fetchProductData(Map<String, dynamic> productIDMap) async {
    final List<Future<Map<String, dynamic>>> productFutures = [];

    for (final pid in productIDMap.values) {
      final productSnapshot = await FirebaseFirestore.instance
          .collection('productcollection')
          .doc(pid.toString())
          .get();

      if (productSnapshot.exists) {
        productFutures.add(Future.value(productSnapshot.data() as Map<String, dynamic>));
      } else {
        productFutures.add(Future.value({}));
      }
    }

    final List<Map<String, dynamic>> productDataList = await Future.wait(productFutures);
    final Map<String, dynamic> productData = {};

    for (int i = 0; i < productDataList.length; i++) {
      productData[productIDMap.values.elementAt(i).toString()] = productDataList[i];
    }

    return productData;
  }

  Future<Map<String, dynamic>> fetchUserData(String userID) async {
    final userSnapshot =
        await FirebaseFirestore.instance.collection('customercollection').doc(userID).get();

    if (userSnapshot.exists) {
      return userSnapshot.data() as Map<String, dynamic>;
    } else {
      return {};
    }
  }
}

