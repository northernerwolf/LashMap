import 'package:flutter/material.dart';

import '../components/app_bar.dart';
import '../db/repo/request.dart';
import '../utils/app_colors.dart';
import '../utils/utils.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  bool isProcedureVisible = false;

  bool validated() {
    if (_nameController.text.isEmpty) {
      showSnackBar(context, "Пожалуйста, укажите имя!");
      return false;
    } else if (_phoneController.text.isEmpty) {
      showSnackBar(context, "Пожалуйста, введите номер телефона!");
      return false;
    } else if (_phoneController.text.length != 12) {
      showSnackBar(context, "Укажите правильный номер телефона!");
      return false;
    } else {
      return true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar("НОВАЯ ЗАПИСЬ"),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 42,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 6),
                        blurRadius: 8,
                        spreadRadius: -5,
                        color: Colors.black.withOpacity(0.5))
                  ]),
                  child: TextField(
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                    ),
                    controller: _nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffEDEDED),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(13)),
                      constraints:
                          const BoxConstraints(minHeight: 42, maxHeight: 42),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 40),
                      suffixIcon: const Icon(Icons.person_add),
                      suffixIconColor: const Color(0xff8e8e8e),
                      hintText: "имя",
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 42,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 6),
                        blurRadius: 8,
                        spreadRadius: -5,
                        color: Colors.black.withOpacity(0.5))
                  ]),
                  child: TextField(
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty &&
                          isNumeric(value.characters.first)) {
                        _phoneController.text = '+7${_phoneController.text}';
                        _phoneController.selection = TextSelection.fromPosition(
                            TextPosition(offset: _phoneController.text.length));
                      }
                    },
                    maxLength: 12,
                    keyboardType: TextInputType.phone,
                    controller: _phoneController,
                    decoration: InputDecoration(
                      counterText: "",
                      filled: true,
                      fillColor: const Color(0xffEDEDED),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(13)),
                      constraints:
                          const BoxConstraints(minHeight: 42, maxHeight: 42),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 40),
                      suffixIcon: const Icon(Icons.phone),
                      suffixIconColor: const Color(0xff8e8e8e),
                      hintText: "телефон",
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                Stack(
                  children: [
                    Visibility(
                      visible: isProcedureVisible,
                      child: Container(
                        margin:
                            const EdgeInsets.only(top: 35, left: 50, right: 50),
                        decoration: BoxDecoration(
                            color: const Color(0xffEBEBEB),
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(4, 4),
                                  blurRadius: 16,
                                  color: Colors.black.withOpacity(0.25))
                            ],
                            borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(10))),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              child: Row(
                                children: const [
                                  Text("классический объем"),
                                  Spacer(),
                                  Text("(2часа)"),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              child: Row(
                                children: const [
                                  Text("классический объем"),
                                  Spacer(),
                                  Text("(2часа)"),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              child: Row(
                                children: const [
                                  Text("классический объем"),
                                  Spacer(),
                                  Text("(2часа)"),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              child: Row(
                                children: const [
                                  Text("классический объем"),
                                  Spacer(),
                                  Text("(2часа)"),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 35,
                      margin: const EdgeInsets.symmetric(horizontal: 28),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: isProcedureVisible
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
                            isProcedureVisible = !isProcedureVisible;
                          });
                        },
                        child: const Text(
                          'ПРОЦЕДУРА',
                          textAlign: TextAlign.center,
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
                  height: 17,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffEBEBEB),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(4, 4),
                          blurRadius: 16,
                          color: Colors.black.withOpacity(0.25))
                    ],
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Row(
                          children: [
                            Text(
                              "начало",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                            const Spacer(),
                            Container(
                              margin: const EdgeInsets.only(right: 12),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: const Color(0xffd9d9d9)),
                              child: const Text(
                                "вт, 7 января",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: const Color(0xffd9d9d9)),
                              child: const Text(
                                "15:00",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 0,
                        thickness: 1,
                        color: Color(0xffbebebe),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Row(
                          children: [
                            Text(
                              "конец",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                            const Spacer(),
                            Container(
                              margin: const EdgeInsets.only(right: 12),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: const Color(0xffd9d9d9)),
                              child: const Text(
                                "вт, 7 января",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: const Color(0xffd9d9d9)),
                              child: const Text(
                                "15:00",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 6),
                        blurRadius: 8,
                        spreadRadius: -5,
                        color: Colors.black.withOpacity(0.5))
                  ]),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    minLines: 4,
                    maxLines: 10,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                    ),
                    controller: _commentController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffEDEDED),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(13)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                      hintText: "комментарий",
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 27),
                  child: SizedBox(
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
                              .addNewClient(
                                  _nameController.text,
                                  _phoneController.text,
                                  _commentController.text)
                              .then((value) async {
                            Navigator.pop(context);
                            Navigator.pop(context);

                            showSnackBar(
                                context, "Новый клиент успешно добавлен!");
                            setState(() {
                              _commentController.text = "";
                              _nameController.text = "";

                              _phoneController.text = "";
                            });
                          }).catchError((e) {
                            Navigator.pop(context);

                            showSnackBar(
                                context, "Не верный формат номера телефона");
                            print(e);
                          });
                        }
                      },
                      child: const Text(
                        'СОХРАНИТЬ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
