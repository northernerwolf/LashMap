import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lash_map/db/repo/request.dart';
import 'package:lash_map/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _mailController.dispose();
    _passwordController.dispose();
  }

  bool validated() {
    if (_mailController.text.isEmpty) {
      showSnackBar(context, "Пожалуйста, укажите электронную почту!");
      return false;
    } else if (_passwordController.text.isEmpty) {
      showSnackBar(context, "Пожалуйста, введите пароль!");
      return false;
    } else if (_passwordController.text.length < 5) {
      showSnackBar(context, "Длина пароля должна быть не менее 5 символов!");
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 80.0,
              ),
              const Text(
                'ВХОД',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 30.0,
                ),
              ),
              const SizedBox(
                height: 60.0,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _mailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "ваша почта",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: "ваш пароль",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'забыли пароль',
                style: TextStyle(
                  color: AppColors.darkBlue,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.secondary,
                  onPrimary: Colors.black,
                  shadowColor: Colors.grey,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                  minimumSize: const Size(400, 50), //////// HERE
                ),
                onPressed: () {
                  if (validated()) {
                    setState(() {
                      isLoading = true;
                    });
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return WillPopScope(
                          onWillPop: () async => false,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    );
                    DioClient()
                        .loginUser(
                            _mailController.text, _passwordController.text)
                        .then((value) async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs
                          .setString('token', value.data["data"]["token"])
                          .then(
                        (value) {
                          setState(() {
                            isLoading = false;
                            Navigator.pop(context);
                            openHome(context);
                          });
                        },
                      );
                    }).catchError((e) {
                      setState(() {
                        isLoading = false;
                        Navigator.pop(context);
                        showSnackBar(context, "Неверный пароль или почта!");

                        print(e);
                      });
                    });
                  }
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
      ),
    );
  }
}
