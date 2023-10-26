import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class OrderCollectionRepo {

final CollectionReference _orderRef = FirebaseFirestore.instance.collection('ordercollection');

  Future<String> placeOrder(

      QuerySnapshot<Map<String, dynamic>> cartData,
      BuildContext context) async {
    final uuid = Uuid();
    final orderId = uuid.v4();

    final _auth = FirebaseAuth.instance;
    
    try {
      await _orderRef.doc(orderId).set({
        'userid': _auth.currentUser!.uid,
        'orderid': orderId,
        'status': 'pending',
        'quantity': {}, // Initialize as an empty map
        'subtotal': {},
        'productid': {},
      });
      return orderId;
    } catch (e) {
      throw Exception('Failed to add to cart');
    }
  }


  Future<void> updateOrder(List<Map<String,dynamic>> toBuyCartItems, String oderId) async {
 
  try {

    for(final toBuyCartItem in toBuyCartItems ){
      final productId = toBuyCartItem['productid'] as String;
      final quantity = toBuyCartItem['quantity'];
      final subtotal = toBuyCartItem['subtotal'];

    await _orderRef.doc(oderId).update({
      // 'status': 'Success',
      // 'quantity':quantity,
      // 'subtotal':subTotal,

          'quantity.$productId': quantity,
          'subtotal.$productId': subtotal,
          'productid.$productId': productId,
          'status': 'Success',
      
    });
    }
  } catch (e) {
    print('Error updating order status: $e');
  }
}



}
