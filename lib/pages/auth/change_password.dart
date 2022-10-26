import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lash_map/db/repo/request.dart';
import 'package:lash_map/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/utils.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _passwordRepeatController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool newPasswordSent = false;
  bool isLoading = false;
  var textFieldIcon, repeatTextFieldIcon;

  @override
  void dispose() {
    super.dispose();
    _passwordRepeatController.dispose();
    _passwordController.dispose();
  }

  bool validated() {
    if (_passwordController.text.isEmpty) {
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
                'ИЗМЕНИТЬ ПАРОЛЬ',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 24.0,
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              const Text(
                'придумайте пароль',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 27,
              ),
              Container(
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
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    onChanged: (value) {
                      if (_passwordRepeatController.text != value) {
                        setState(() {
                          repeatTextFieldIcon = const Icon(
                              CupertinoIcons.xmark_circle_fill,
                              size: 16,
                              color: Color(0xffd25857));
                        });
                      } else {
                        setState(() {
                          repeatTextFieldIcon = const Icon(
                              CupertinoIcons.check_mark,
                              size: 16,
                              color: Color(0xff007AFF));
                        });
                      }

                      if (value.length < 5) {
                        setState(() {
                          textFieldIcon = const Icon(
                              CupertinoIcons.xmark_circle_fill,
                              size: 16,
                              color: Color(0xffd25857));
                        });
                      } else {
                        setState(() {
                          textFieldIcon = const Icon(CupertinoIcons.check_mark,
                              size: 16, color: Color(0xff007AFF));
                        });
                      }
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "введите пароль",
                      suffix: textFieldIcon,
                      hintStyle: const TextStyle(
                          color: Color(0xff858383),
                          fontWeight: FontWeight.w400),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              Container(
                height: 35,
                decoration: BoxDecoration(
                  color: const Color(0xffDddbda),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffBBBBBB),
                      offset: Offset(5, 5), //(x,y)
                      blurRadius: 12.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _passwordRepeatController,
                    obscureText: true,
                    onChanged: (value) {
                      if (value != _passwordController.text) {
                        setState(() {
                          repeatTextFieldIcon = const Icon(
                              CupertinoIcons.xmark_circle_fill,
                              size: 16,
                              color: Color(0xffd25857));
                        });
                      } else {
                        setState(() {
                          repeatTextFieldIcon = const Icon(
                              CupertinoIcons.check_mark,
                              size: 16,
                              color: Color(0xff007AFF));
                        });
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "подтвердите пароль",
                      border: InputBorder.none,
                      isDense: true,
                      suffix: repeatTextFieldIcon,
                      hintStyle: const TextStyle(
                          color: Color(0xff858383),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 28,
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
                          .updatePassword(_passwordController.text.toString())
                          .then((value) async {
                        setState(() {
                          isLoading = false;
                          Navigator.pop(context);
                        });
                        showSnackBar(context, "Пароль успешно изменен!");
                      }).catchError((e) {
                        setState(() {
                          isLoading = false;
                          Navigator.pop(context);
                          showSnackBar(context,
                              "Произошла ошибка, исправьте ошибки и повторите попытку!");
                        });
                        print(e);
                      });
                    }
                  },
                  child: const Text(
                    'СОХРАНИТЬ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
