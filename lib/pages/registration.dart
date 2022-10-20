import 'package:flutter/material.dart';
import 'package:lash_map/db/repo/request.dart';
import 'package:lash_map/utils/app_colors.dart';
import 'package:lash_map/utils/utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordRepeatController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _passwordRepeatController.dispose();
  }

  bool validated() {
    if (_emailController.text.isEmpty) {
      showSnackBar(context, "Пожалуйста, укажите электронную почту!");
      return false;
    } else if (_phoneController.text.isEmpty) {
      showSnackBar(context, "Пожалуйста, дайте номер телефона!");
      return false;
    } else if (_passwordController.text != _passwordRepeatController.text) {
      showSnackBar(context, "Пароль не равен!");
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
    return AbsorbPointer(
      absorbing: isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 40.0,
                    ),
                    const Text(
                      'РЕГИСТРАЦИЯ',
                      style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 30,
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 60.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: "ваша почта",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            hintText: "ваш телефон",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      'придумайте пароль',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 16,
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
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: "введите пароль",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _passwordRepeatController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: "подтвердите пароль",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.secondary,
                          onPrimary: Colors.black,
                          shadowColor: Colors.grey,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
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
                                .createUser(
                                    _emailController.text.toString(),
                                    _phoneController.text.toString(),
                                    _passwordController.text.toString())
                                .then((value) {
                              setState(() {
                                isLoading = false;
                                Navigator.pop(context);
                                openHome(context);
                              });
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
                          'ЗАРЕГЕСТРИРОВАТЬСЯ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
