import 'package:flutter/material.dart';

class InternetNotAvailable extends StatelessWidget {
  const InternetNotAvailable({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        color: Colors.red,
        child: const Center(
          child: Text(
            'No Internet Connection!!!',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
