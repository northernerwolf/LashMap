import 'package:flutter/material.dart';
import 'package:lash_map/components/profile_hat_luxury.dart';

import '../utils/app_colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _mailController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(children: [
        SizedBox(
          height: 48,
        ),
        ProfileHatLuxury(),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    enabled: false,
                    controller: _nameController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      isDense: true,
                      suffixIcon: Image.asset("assets/images/pen.png"),
                      hintText: "ваша имя",
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    enabled: false,
                    controller: _mailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      isDense: true,
                      suffixIcon: Image.asset("assets/images/pen.png"),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    enabled: false,
                    controller: _mailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      isDense: true,
                      suffixIcon: Image.asset("assets/images/pen.png"),
                      hintText: "+7 777 777 77 77",
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
                    'ЯЗЫК',
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
    );
  }
}
