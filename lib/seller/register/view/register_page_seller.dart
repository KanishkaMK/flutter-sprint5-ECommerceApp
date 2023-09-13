import 'package:ecommerceapp/seller/login/login_seller.dart';
import 'package:flutter/material.dart';

class RegisterPageSeller extends StatefulWidget {
  const RegisterPageSeller({super.key});

  @override
  State<RegisterPageSeller> createState() => _RegisterPageSellerState();
}

class _RegisterPageSellerState extends State<RegisterPageSeller> {

final TextEditingController _nameController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _nameController,
                validator: (value) {
                  if(value!.isEmpty){
                   return 'Please fill the field';
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  hintText: 'Name'),            
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _placeController,
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Please fill the field';
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  hintText: 'Place'),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _phoneController,
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Please fill the field';
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  hintText: 'Phone'),
              ),SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if(value!.isEmpty){
                    return'Please fill the field';
                  }
                },
               decoration: InputDecoration(
                border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                hintText: 'Email_Id'),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Please fill the field';
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  hintText: 'Password'),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 164, 132, 14)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPageSeller(),));
      
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w300),
                  )),
             
            ],
          ),
        ),
      ),
    );
  }
}