import 'package:ecommerceapp/customer/home_customer/view/home_customer_page.dart';
import 'package:flutter/material.dart';

class LoginPageCustomer extends StatefulWidget {
  const LoginPageCustomer({super.key});

  @override
  State<LoginPageCustomer> createState() => _LoginPageCustomerState();
}

class _LoginPageCustomerState extends State<LoginPageCustomer> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             TextFormField(
          controller: _usernameController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please fill the field';
            }
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: 'Username'),
        ),
         SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _passwordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please fill the field';
                }
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Password'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromARGB(255, 241, 225, 169)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageCustomer(),));
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w300),
                )),
           
          ],
        ),
      ),
    );
  }
  
}