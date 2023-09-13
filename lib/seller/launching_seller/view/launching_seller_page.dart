import 'package:ecommerceapp/seller/login/login_seller.dart';
import 'package:ecommerceapp/seller/register/register_seller.dart';
import 'package:flutter/material.dart';

class LaunchingSellerPage extends StatelessWidget {
  const LaunchingSellerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: Text(
          'ECommerceApp',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 241, 225, 169)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPageSeller(),
                      ));
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w300),
                )),
            Text(
              'OR',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 164, 132, 14)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPageSeller(),
                      ));
                },
                child: Text(
                  'Register',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w300),
                )),
          ],
        ),
      ),
    );
  }
}
