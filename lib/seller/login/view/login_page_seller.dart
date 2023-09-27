import 'package:ecommerceapp/seller/home_seller/home_seller.dart';
import 'package:ecommerceapp/seller/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPageSeller extends StatefulWidget {
  const LoginPageSeller({super.key});
  @override
  State<LoginPageSeller> createState() => _LoginPageSellerState();
}

class _LoginPageSellerState extends State<LoginPageSeller> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final LoginBloc _loginBloc = LoginBloc();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => _loginBloc,
      child: Scaffold(
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
          child: BlocProvider(
            create: (context) => _loginBloc,
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                // TODO: implement listener

                if (state is NavigateToHomeScreen) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePageSeller(),
                      ));
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Successfully logged in.....')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'Login Failed... Please check your credentials and try again')));
                }
              },
              builder: (context, state) {
                return Column(
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
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => HomePageSeller(),
                          //     ));

                          if (_formKey.currentState!.validate() == false) {
                            print('login test');
                          } else {
                            _loginBloc.add(
                              LoginWithEmailAndPassword(
                                email: _usernameController.text,
                                password: _passwordController.text,
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w300),
                        )),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
