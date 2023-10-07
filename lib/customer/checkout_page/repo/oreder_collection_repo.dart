import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class OrderCollectionRepo {
  Future<void> createOrderCollection(
      QuerySnapshot<Map<String, dynamic>> cartData,
      BuildContext context) async {
    final uuid = Uuid();
    final orderId = uuid.v4();

    final _auth = FirebaseAuth.instance;
    final CollectionReference orderRef =
        FirebaseFirestore.instance.collection('ordercollection');

    try {
      await orderRef.doc(orderId).set({
        'userid': _auth.currentUser!.uid,
        'orderid': orderId,
        'status': 'pending',
        'quantity': '',
        'subtotal': '',
        'productid': '',
      });
    } catch (e) {
      throw Exception('Failed to add to cart');
    }
  }
}
