import 'package:flutter/material.dart';

class CradWidget extends StatelessWidget {
   CradWidget({Key? key}):super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     

      body: Center(
        child: Container(
          height: 200,
          width: 200,
          child: Card(
            margin: EdgeInsets.all(16.0),
            elevation: 4.0,
        
            child: Column(
              children: [
               
               
                 Text('PRODUCT DETAILS',
                 style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
               
              ],
            ),
          ),
        ),
      ),


    );
  }
}