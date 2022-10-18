import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(
              height: 40.0,
            ),
            const Text(
              'ВХОД',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 26.0,
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.only(left: 25, right: 20),
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "ваш пароль",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.only(left: 25, right: 20),
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: const TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "ваш телефон",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'забыли пароль',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15.0,
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orangeAccent,
                onPrimary: Colors.black,
                shadowColor: Colors.grey,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0)),
                minimumSize: const Size(400, 50), //////// HERE
              ),
              onPressed: () {
                // Respond to button press
              },
              child: const Text(
                'ВОЙТИ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ]),
        )),
      ),
    );
  }
}
