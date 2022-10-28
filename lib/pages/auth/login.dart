import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lash_map/db/repo/request.dart';
import 'package:lash_map/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool newPasswordSent = false;
  bool isPasswordVisible = true;

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
      backgroundColor: const Color(0xffF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 106.0,
              ),
              const Text(
                'ВХОД',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 30.0,
                ),
              ),
              const SizedBox(
                height: 102,
              ),
              Container(
                width: double.infinity,
                height: 35,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffBBBBBB),
                      offset: Offset(5, 5), //(x,y)
                      blurRadius: 12.0,
                    ),
                  ],
                  color: const Color(0xffDddbda),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _mailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "ваша почта",
                      hintStyle: TextStyle(
                          color: Color(0xff858383),
                          fontWeight: FontWeight.w400),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 35,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffBBBBBB),
                      offset: Offset(5, 5),
                      blurRadius: 12.0,
                    ),
                  ],
                  color: const Color(0xffDddbda),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _passwordController,
                          obscureText: isPasswordVisible,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: "ваш пароль",
                            isDense: true,
                            hintStyle: TextStyle(
                                color: Color(0xff858383),
                                fontWeight: FontWeight.w400),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            child: isPasswordVisible
                                ? const Icon(
                                    CupertinoIcons.eye_slash_fill,
                                    color: AppColors.primary,
                                    size: 20,
                                  )
                                : const Icon(
                                    CupertinoIcons.eye_fill,
                                    color: AppColors.primary,
                                    size: 20,
                                  )),
                      )
                    ],
                  ),
                ),
              ),
              if (newPasswordSent)
                const SizedBox(
                  height: 15,
                ),
              if (newPasswordSent)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 64),
                  child: Container(
                    height: 28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: RadialGradient(radius: 2.3, colors: [
                        const Color(0xff1B307C),
                        const Color(0xff1B3BB4).withOpacity(0.42)
                      ]),
                    ),
                    child: const Center(
                      child: Text(
                        "новый пароль отправлен вам на почту",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
                ),
              if (newPasswordSent)
                const SizedBox(
                  height: 8,
                ),
              if (!newPasswordSent)
                const SizedBox(
                  height: 52,
                ),
              GestureDetector(
                onTap: () {
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
                  if (_mailController.text.isNotEmpty) {
                    DioClient()
                        .sendNewPassword(_mailController.text)
                        .then((value) {
                      setState(() {
                        Navigator.pop(context);
                        newPasswordSent = true;
                      });
                    }).catchError((e) {
                      print(e);
                      setState(() {
                        newPasswordSent = false;

                        Navigator.pop(context);
                        showSnackBar(context,
                            "Проверьте подключение и повторите попытку! $e");

                        print(e);
                      });
                    });
                  }
                },
                child: const Text(
                  'забыли пароль',
                  style: TextStyle(
                    color: AppColors.darkBlue,
                    fontSize: 14.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 27,
              ),
              SizedBox(
                width: double.infinity,
                height: 35,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.secondary,
                    onPrimary: Colors.black,
                    shadowColor: Colors.grey,
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13)),
                  ),
                  onPressed: () {
                    if (validated()) {
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
                              Navigator.pop(context);
                              openHome(context);
                            });
                          },
                        );
                      }).catchError((e) {
                        setState(() {
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
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
