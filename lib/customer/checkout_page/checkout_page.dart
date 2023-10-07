import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/customer/checkout_page/repo/update_oreder_repo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class CheckOutPage extends StatelessWidget {
//   const CheckOutPage({super.key, required this.cartCheckOutData});
//   final QuerySnapshot<Map<String,dynamic>> cartCheckOutData;

//   @override
//   Widget build(BuildContext context) {
// return Scaffold(
//   appBar: AppBar(
//     backgroundColor: Colors.amber,
//     centerTitle: true,
//     title: Text(
//       'CheckOut Page',
//       style: TextStyle(
//           color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
//     ),
//   ),
//   body: Column(
//     children: [
//       Container(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text(
//                 'GRAND TOTAL :',
//                 style:
//                     TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 '1000',
//                 style: TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.red),
//               ),
//             ],
//           ),
//         ),
//       ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                   backgroundColor:
//                       const Color.fromARGB(255, 241, 225, 169)),
//               onPressed: () {

//               },
//               child: Text(
//                 'COD',
//                 style: TextStyle(
//                     color: Colors.black, fontWeight: FontWeight.bold),
//               )),
//           ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                   backgroundColor:
//                       Color.fromARGB(255, 104, 230, 239)),
//               onPressed: () {
//                 //  Navigator.push(context, MaterialPageRoute(builder: (context) => CheckOutPage(),));
//               },
//               child: Text(
//                 'Razor Pay',
//                 style: TextStyle(
//                     color: Colors.black, fontWeight: FontWeight.bold),
//               ))
//         ],
//       ),

//       Expanded(
//         child: ListView.builder(
//           itemCount: cartCheckOutData.docs.length,
//           itemBuilder: (context, index) {
//             dynamic grandTotal = 0;
//             final item = cartCheckOutData.docs[index];
//             final totalForItem = item['price'].toDouble() * item['quantity'].toDouble();
//             grandTotal += totalForItem;

//             return ListTile(
//               title: Text('${index + 1} : ${item['productName'].toString()}'),
//              // subtitle: Text('$totalForItem'),
//               trailing: Text('${item['quantity'].toString()}'),
//             );

//           },
//           ),
//       )
//     ],
//   ),
// );
//   }
// }

class CheckOutPage extends StatefulWidget {
   CheckOutPage({super.key,required this.grandTotal});

  double grandTotal;

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {

late Razorpay _razorpay ;
//double grandTotal = 0;

//CartCheckoutItem? cartCheckoutItem;


  // loadGrandTotal() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   double grandTotal = prefs.getDouble('grandTotal') ?? 0.0;
  //   setState(() {
  //     grandTotal = grandTotal;
  //   });
  // }

  // void saveGrandTotal(double grandTotal) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setDouble('grandTotal', grandTotal);
  // }

@override
  void initState() {
    // TODO: implement initState
    super.initState();

    //loadGrandTotal();

     _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response){
    Fluttertoast.showToast(msg: 'Success: ${response.paymentId}',toastLength: Toast.LENGTH_SHORT);
    // final newStatus = 'Success';
    // final newQuantity = cartCheckoutItem!.getQuantity();
    // final subTotal = grandTotal;
    // UpdateOrderRepo().updateOrder(newStatus,newQuantity,subTotal);

  }

  void _handlePaymentError(PaymentFailureResponse response){
    Fluttertoast.showToast(msg: 'Error: ${response.code.toString()}',toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response){
    Fluttertoast.showToast(msg: 'ExternalWallet: ${response.walletName}',toastLength: Toast.LENGTH_SHORT);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //super.dispose();
    _razorpay.clear();
  }

  void openPayement()async{
    var options = {
      'key': 'rzp_test_OcZJ6KqVEkWZF2',
      'key secret': 'ZyZyQ468mO1QSwbN3o5hM7F0',
      'amount': widget.grandTotal*100,
      'name': 'ECommerceApp',
      'description': 'Flutter',
      'retry': {
        'enabled': true,
        'max_count': 1
        },
      'send_sms_hash': true,
      'prefill': {
        'contact': '9876543321',
        'email': 'company@gmail.com',
      },
      'external':{
        'wallet': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      
      debugPrint('Error:$e');
    }
  }




  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: Text(
          'CheckOut Page',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'GRAND TOTAL :',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${widget.grandTotal}',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 241, 225, 169)),
                  onPressed: () {},
                  child: Text(
                    'COD',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 104, 230, 239)),
                  onPressed: () {
                    openPayement();
                  },
                  child: Text(
                    'Razor Pay',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
          // Expanded(
          //   child: StreamBuilder(
          //       stream:
          //           FirebaseFirestore.instance.collection('cart').snapshots(),
          //       builder: (context, snapshot) {
          //         if (!snapshot.hasData) {
          //           return CircularProgressIndicator();
          //         }

          //         if (snapshot.hasError) {
          //           return Text('Error: ${snapshot.error}');
          //         }
          //         final cartItems = snapshot.data!.docs.map((document) {
          //           final data = document.data() as Map<String, dynamic>;

          //           final productName = data['productName']
          //               as String; // Explicitly cast to String

          //           // Safely parse 'price' as a double
          //         //   final price = data['price'];
          //         //   double priceValue = 0.0;
          //         //   if (price is num) {
          //         //     priceValue = price.toDouble();
          //         //   } else if (price is String) {
          //         //     double? parsedPrice = double.tryParse(price);
          //         //     if (parsedPrice != null) {
          //         //       priceValue = parsedPrice;
          //         //     }
          //         //   }

          //         //   // Safely parse 'quantity' as an int
          //         //   final quantity = data['quantity'];
          //         //   int quantityValue = 0;
          //         //   if (quantity is int) {
          //         //     quantityValue = quantity;
          //         //   } else if (quantity is String) {
          //         //     int? parsedQuantity = int.tryParse(quantity);
          //         //     if (parsedQuantity != null) {
          //         //       quantityValue = parsedQuantity;
          //         //     }
          //         //   }

          //         //   final totalForItem = priceValue * quantityValue;
          //         // grandTotal += totalForItem; // Update grandTotal
          //         // saveGrandTotal(grandTotal);



          //         //   return cartCheckoutItem = CartCheckoutItem(
          //         //     productName: productName,
          //         //     price: priceValue,
          //         //     quantity: quantityValue,
          //         //   );
          //         // }).toList();

          //         //   return CartCheckoutItem(

          //         //     productName: data['productName'] as String,
          //         //      price: (data['price']as num).toDouble(),
          //         //     quantity: data['quantity'] as int,
          //         //   );
          //         // }).toList();

                    

          //         return ListView.builder(
          //             itemCount: cartItems.length,
          //             itemBuilder: (context, index) {
          //               final item = cartItems[index];
          //               final totalForItem = item.price * item.quantity;
          //               // grandTotal += totalForItem;
          //               // saveGrandTotal(grandTotal);


          //               return ListTile(
          //                 title: Text(item.productName),
          //                 subtitle:
          //                     Text('Price: ${item.price.toStringAsFixed(2)}'),
          //                 trailing: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.end,
          //                   children: [
          //                     Text('Qty: ${item.quantity}'),
          //                     Text('Total: ${totalForItem.toStringAsFixed(2)}'),
          //                   ],
          //                 ),
          //               );
          //             });
          //       }),
          // ),
        ],
      ),
    );
  }
} 












// class CartCheckoutItem {
//   final String productName;
//   final double price;
//   final int quantity;

//   CartCheckoutItem({
//     required this.productName,
//     required this.price,
//     required this.quantity,
//   });
//   int getQuantity(){
//     return quantity;

//   }
//   double getPrice(){
//     return price;
//   }
// }
