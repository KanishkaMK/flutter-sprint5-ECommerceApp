import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Image.asset(
              'assets/images/teddy-bear.png',
              height: 300,
              width: 300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('NAME',style: TextStyle(color: Colors.black,
            fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('PRICE',style: TextStyle(color: Colors.black,
            fontWeight: FontWeight.bold),),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 235, 208, 128)),
            onPressed: () {
            
          }, child: Text('ADD TO CART',style: TextStyle(color: Colors.black,
            fontWeight: FontWeight.bold),))
        ],
      ),
    );
  }
}