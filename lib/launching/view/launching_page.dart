import 'package:ecommerceapp/customer/login_customer/login_customer.dart';
import 'package:ecommerceapp/customer/register_customer/register_customer.dart';
import 'package:ecommerceapp/seller/launching_seller/launching_seller.dart';
import 'package:ecommerceapp/seller/login/login_seller.dart';
import 'package:flutter/material.dart';

class LaunchingPage extends StatefulWidget {
  const LaunchingPage({super.key});

  @override
  State<LaunchingPage> createState() => _LaunchingPageState();
}

class _LaunchingPageState extends State<LaunchingPage> {
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
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/background_image_snowman.png',
            fit: BoxFit.fill,
          ),
          Container(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 6, 6, 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      )),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LaunchingSellerPage(),
                        ));
                  },
                  child: Text(
                    'Become Sellor',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold,fontSize: 15),
                  )),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 241, 225, 169)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPageCustomer(),
                          ));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
                Text(
                  'OR',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 164, 132, 14)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPageCustomer(),
                          ));
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
