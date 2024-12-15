import 'package:flutter/material.dart';

class BusPage extends StatefulWidget {
  const BusPage({Key? key}) : super(key: key);  

  @override 
  State<BusPage> createState() => BusState();
}
class BusState extends State< BusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Bus Screen'),
      ),
    );
  }
}