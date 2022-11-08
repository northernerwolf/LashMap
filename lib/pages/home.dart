import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lash_map/components/profile_hat_luxury.dart';
import 'package:lash_map/db/repo/request.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_colors.dart';
import '../utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool isNameEnabled = false;
  bool isPhoneEnabled = false;
  bool isLoaded = true;
  bool isLanguageSelectorVisible = false;

  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  @override
  void dispose() {
    super.dispose();
    _mailController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
  }

  bool validated() {
    if (_phoneController.text.isEmpty) {
      showSnackBar(context, "Пожалуйста, дайте номер телефона!");
      return false;
    } else if (_nameController.text.isEmpty) {
      showSnackBar(context, "Пожалуйста, укажите имя!");
      return false;
    } else if (_phoneController.text.length != 12) {
      showSnackBar(context, "Укажите правильный номер телефона!");
      return false;
    } else {
      return true;
    }
  }

  getUserInfo() {
    DioClient().getUserInfo().then((value) {
      setState(() {
        _mailController.text = value.data["data"]["email"];
        _phoneController.text = "+${value.data["data"]["phone"]}";
        _nameController.text = value.data["data"]["fullName"];

        prefs.then((pref) async {
          await pref.setString("fullName", value.data["data"]["fullName"]);
          await pref.setString("phone", "+${value.data["data"]["phone"]}");
          await pref.setString("email", value.data["data"]["email"]);
        }).catchError((e) {
          print(e);
        });
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    super.initState();
    prefs.then((value) {
      setState(() {
        _mailController.text = value.getString("email") ?? "";
        _phoneController.text = value.getString("phone") ?? "";
        _nameController.text = value.getString("fullName") ?? "";
      });
    }).catchError((e) {
      print(e);
    });

    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Visibility(
          visible: isLoaded,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: [
              const SizedBox(
                height: 48,
              ),
              ProfileHatLuxury(
                name: _nameController.text.toString(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 64),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 34,
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
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: TextField(
                                enabled: isNameEnabled,
                                controller: _nameController,
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  hintText: "ваше имя",
                                  hintStyle: TextStyle(
                                      color: Color(0xff858383),
                                      fontWeight: FontWeight.w400),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16, left: 8),
                            child: GestureDetector(
                                onTap: () {
                                  if (isNameEnabled && validated()) {
                                    updateUserInfo(_nameController.text,
                                        _phoneController.text);
                                  }
                                  setState(() {
                                    isNameEnabled = true;
                                  });
                                },
                                child: isNameEnabled
                                    ? const Icon(CupertinoIcons.check_mark)
                                    : Image.asset("assets/images/pen.png")),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
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
                          enabled: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            isDense: true,
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
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: TextField(
                                enabled: isPhoneEnabled,
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                maxLength: 12,
                                onChanged: (value) {
                                  if (value.isNotEmpty &&
                                      isNumeric(value.characters.first)) {
                                    _phoneController.text =
                                        '+7${_phoneController.text}';
                                    _phoneController.selection =
                                        TextSelection.fromPosition(TextPosition(
                                            offset:
                                                _phoneController.text.length));
                                  }
                                },
                                decoration: const InputDecoration(
                                  isDense: true,
                                  counterText: "",
                                  hintText: "ваша телефон",
                                  hintStyle: TextStyle(
                                      color: Color(0xff858383),
                                      fontWeight: FontWeight.w400),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16, left: 8),
                            child: GestureDetector(
                                onTap: () {
                                  if (isPhoneEnabled && validated()) {
                                    updateUserInfo(_nameController.text,
                                        _phoneController.text);
                                  }
                                  setState(() {
                                    isPhoneEnabled = true;
                                  });
                                },
                                child: isPhoneEnabled
                                    ? const Icon(CupertinoIcons.check_mark)
                                    : Image.asset("assets/images/pen.png")),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 35,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.primary,
                          onPrimary: Colors.black,
                          shadowColor: Colors.grey,
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                        ),
                        onPressed: () {
                          openChangePassword(context);
                        },
                        child: const Text(
                          'ИЗМЕНИТЬ ПАРОЛЬ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 35,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.primary,
                          onPrimary: Colors.black,
                          shadowColor: Colors.grey,
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'ОФОРМИТЬ ПОДПИСКУ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Stack(
                      children: [
                        Visibility(
                            visible: isLanguageSelectorVisible,
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 30, right: 30, top: 35),
                              decoration: const BoxDecoration(
                                  color: Color(0xffEBEBEB),
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(10))),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 10),
                                      child: Row(
                                        children: const [
                                          Text(
                                            "ENGLISH",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          Spacer(),
                                          Icon(
                                            CupertinoIcons.star_fill,
                                            color: Colors.black,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 10),
                                      child: Row(
                                        children: const [
                                          Text(
                                            "РУССКИЙ",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: AppColors.secondary),
                                          ),
                                          Spacer(),
                                          Icon(
                                            CupertinoIcons.star_fill,
                                            color: AppColors.secondary,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                        SizedBox(
                          width: double.infinity,
                          height: 35,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: isLanguageSelectorVisible
                                  ? AppColors.secondary
                                  : AppColors.primary,
                              onPrimary: Colors.black,
                              shadowColor: Colors.grey,
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0)),
                            ),
                            onPressed: () {
                              setState(() {
                                isLanguageSelectorVisible =
                                    !isLanguageSelectorVisible;
                              });
                            },
                            child: const Text(
                              'ЯЗЫК',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 35,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.primary,
                          onPrimary: Colors.black,
                          shadowColor: Colors.grey,
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                        ),
                        onPressed: () {
                          openContactDev(context);
                        },
                        child: const Text(
                          'СВЯЗАТЬСЯ С РАЗРАБОТЧИКОМ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
        Visibility(
            visible: !isLoaded,
            child: const Center(
              child: CircularProgressIndicator(),
            ))
      ],
    );
  }

  void updateUserInfo(String name, String phone) {
    setState(() {
      isLoaded = false;
    });
    DioClient().updateUserInfo(name, phone, "ru").then((value) {
      setState(() {
        isLoaded = true;
        isNameEnabled = false;
        isPhoneEnabled = false;
      });
    }).catchError((e) {
      setState(() {
        isLoaded = true;
      });
      showSnackBar(context, "Не верный формат номера телефона");
      print(e);
    });
  }
}
