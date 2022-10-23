import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lash_map/db/repo/request.dart';
import 'package:lash_map/utils/app_colors.dart';
import 'package:lash_map/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  var textFieldIcon, repeatTextFieldIcon;

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
        backgroundColor: const Color(0xffF9F9F9),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 106.0,
                    ),
                    const Text(
                      'РЕГИСТРАЦИЯ',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 100.0,
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
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _emailController,
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
                          controller: _phoneController,
                          onChanged: (value) {
                            if (value.isNotEmpty &&
                                isNumeric(value.characters.first)) {
                              _phoneController.text =
                                  '+7${_phoneController.text}';
                              _phoneController.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset: _phoneController.text.length));
                            }
                          },
                          keyboardType: TextInputType.phone,
                          maxLength: 12,
                          decoration: const InputDecoration(
                            hintText: "ваш телефон",
                            counterText: "",
                            hintStyle: TextStyle(
                                color: Color(0xff858383),
                                fontWeight: FontWeight.w400),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 52,
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
                            if (value.length < 5) {
                              setState(() {
                                textFieldIcon = const Icon(
                                    CupertinoIcons.xmark_circle_fill,
                                    size: 16,
                                    color: Color(0xffd25857));
                              });
                            } else {
                              setState(() {
                                textFieldIcon = const Icon(
                                    CupertinoIcons.check_mark,
                                    size: 16,
                                    color: Color(0xff007AFF));
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
                                .createUser(
                                    _emailController.text.toString(),
                                    _phoneController.text.toString(),
                                    _passwordController.text.toString())
                                .then((value) async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs
                                  .setString(
                                      'token', value.data["data"]["token"])
                                  .then(
                                    (value) => setState(() {
                                      isLoading = false;
                                      Navigator.pop(context);
                                      openHome(context);
                                    }),
                                  );
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
      ),
    );
  }
}
