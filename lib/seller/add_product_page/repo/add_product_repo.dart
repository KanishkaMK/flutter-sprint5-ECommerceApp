import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddProductRepo {
  Future<void> addProduct(String name, String code, String price, String description,
      String stock,List<XFile> images, BuildContext context) async {
        final uuid = Uuid();
        final productId = uuid.v4();
        List<String> productImages = [];
    final _auth = FirebaseAuth.instance;
    final CollectionReference productRef =
        FirebaseFirestore.instance.collection('productcollection');
    try {

       for(final element in images){
    final ref = FirebaseStorage.instance.ref().child('productimages').child(element.name);
    final file = File(element.path);
    await ref.putFile(file);
    final imageUrl = await ref.getDownloadURL();
    productImages.add(imageUrl);

  }
      

      await productRef.doc(productId).set({
        'userid': _auth.currentUser!.uid,
        'productid': productId,
        'name': name,
        'code': code,
        'price': price,
        'description': description,
        'stock': stock,
        'image': productImages
      });
    } on FirebaseAuthException catch (e) {
      throw Exception('Failed to add Product');
    }
  }
}
