import 'package:ecommerceapp/seller/add_product_page/repo/add_product_repo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productCodeController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _productStockController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<XFile> imageList = [];

  Future<dynamic> getImage() async {
    final imagePicker = ImagePicker();
    imageList = await imagePicker.pickMultiImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: Text(
          'Add Product here...',
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
                controller: _productNameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please fill the field';
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Product Name'),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _productCodeController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please fill the field';
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Product Code'),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _productPriceController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please fill the field';
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Product Price'),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _productDescriptionController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please fill the field';
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Product Description'),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _productStockController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please fill the field';
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Product Stock'),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(24.0),
              //   child: Image.asset(
              //     'assets/images/teddy-bear.png',
              //     height: 100,
              //     width: 100,
              //   ),
              // ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    getImage();
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/teddy-bear.png',
                        height: 30,
                        width: 30,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'UPLOAD YOUR PRODUCT IMAGE HERE',
                        style: TextStyle(
                            color: Color.fromARGB(255, 167, 126, 4),
                            fontSize: 16),
                      ),
                    ],
                  ),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                ),
              ),

              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 235, 208, 128)),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await AddProductRepo().addProduct(
                          _productNameController.text,
                          _productCodeController.text,
                          _productPriceController.text,
                          _productDescriptionController.text,
                          _productStockController.text,
                          imageList,
                          context);

                      _productNameController.clear();
                      _productCodeController.clear();
                      _productPriceController.clear();
                      _productDescriptionController.clear();
                      _productStockController.clear();
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Product added')));
                          Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'ADD PRODUCT',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
