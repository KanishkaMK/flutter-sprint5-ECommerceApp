import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/customer/product_details/repo/add_to_cart_repo.dart';
import 'package:ecommerceapp/customer/product_details/view/product_details_page.dart';
import 'package:flutter/material.dart';

class CartList extends StatefulWidget {
   CartList({
    super.key,
    required this.cartDataDocIndex,
    required this.quantity,
  });
  final QueryDocumentSnapshot<Map<String, dynamic>> cartDataDocIndex;
  late int quantity;

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
 // late int quantity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // quantity = int.parse(widget.cartDataDocIndex['quantity'].toString());
  }

  // int quantity = 1;

  // void incrementQuantity() {
  //   setState(() {
  //     quantity++;
  //     FirebaseFirestore.instance
  //                         .collection('cart')
  //                         .doc(widget.cartDataDocIndex.id)
  //                         .update({'quantity':quantity});
  //   });
  // }

  // void decrementQuantity() {
  //   if (quantity > 1) {
  //     setState(() {
  //       quantity--;
  //       FirebaseFirestore.instance
  //                         .collection('cart')
  //                         .doc(widget.cartDataDocIndex.id)
  //                         .update({'quantity':quantity});
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.cartDataDocIndex['productName'].toString()),
      // leading: CircleAvatar(
      //   backgroundColor: Colors.blue),
      leading: CircleAvatar(
        backgroundImage:
            NetworkImage(widget.cartDataDocIndex['imageUrl'].toString()),
      ),
      subtitle: Text(widget.cartDataDocIndex['price'].toString()),
      // trailing: Row(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     if (quantity > 0)
      //       IconButton(
      //           onPressed: () async {
      //             if (quantity == 1) {
      //               setState(() {
      //                 quantity = 0;
      //                 FirebaseFirestore.instance
      //                     .collection('cart')
      //                     .doc(widget.cartDataDocIndex.id)
      //                     .update({'quantity':quantity});
      //               });
      //             } else {
      //               decrementQuantity();
      //             }
      //           },
      //           icon: Icon(quantity == 1 ? Icons.delete : Icons.remove)),
      //     // Text(widget.cartData['quantity'].toString()),
      //     Text(widget.cartDataDocIndex['quantity'].toString()),
      //     IconButton(
      //         onPressed: () {
      //           incrementQuantity();
      //         },
      //         icon: Icon(Icons.add))
      //   ],
      // ),

      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  FirebaseFirestore.instance
                      .collection('cart')
                      .doc(widget.cartDataDocIndex.id)
                      .update({'quantity': widget.quantity++});
                });
              },
              child: Icon(Icons.add),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(widget.cartDataDocIndex['quantity'].toString()),
          ),
          if (widget.quantity >= 1)
            InkWell(
              onTap: () {
                setState(() {
                  FirebaseFirestore.instance
                      .collection('cart')
                      .doc(widget.cartDataDocIndex.id)
                      .update({'quantity': widget.quantity--});
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
                      .doc(widget.cartDataDocIndex.id)
                      .delete();
                });
              },
              child: Icon(Icons.delete_forever),
            )
        ],
      ),
    );
  }
}

// return Scaffold(
//   body: InkWell(
//     onTap: () {

//     },
//     child: Center(
//       child: Container(
//         height: 200,
//         width: 200,
//         child: Card(
//           margin: EdgeInsets.all(16.0),
//           elevation: 4.0,
//           child: Column(

//             children: [
//               //  Text('PRODUCT DETAILS',
//               //  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),

//               Image.network(
//                 cartData['imageUrl'].toString(),
//                 height: 100,
//                 width: 100,
//               ),
//               Text(cartData['productName'].toString()),
//               Text(cartData['price'].toString()),
//             ],
//           ),
//         ),
//       ),
//     ),
//   ),
// );
