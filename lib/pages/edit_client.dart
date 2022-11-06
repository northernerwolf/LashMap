import 'package:flutter/material.dart';

import '../components/app_bar.dart';
import '../db/repo/request.dart';
import '../utils/app_colors.dart';
import '../utils/utils.dart';

class EditClientPage extends StatefulWidget {
  final int id;

  const EditClientPage({super.key, required this.id});

  @override
  State<EditClientPage> createState() => _EditClientPageState();
}

class _EditClientPageState extends State<EditClientPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  bool isLoaded = false;
  String title = "";
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

  void deleteOperation(int id) {
    AlertDialog alert = AlertDialog(
      title: const Text(
        "Внимание!",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: const Text("Вы уверены, что хотите удалить клиента?"),
      actions: [
        TextButton(
          child: const Text(
            "Отмена",
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text("Удалить"),
          onPressed: () {
            setState(() {
              isLoaded = false;
            });
            Navigator.pop(context);

            DioClient().deleteClient(id).then((value) {
              setState(() {
                isLoaded = true;
              });
              Navigator.pop(context);
            }).catchError((e) {
              setState(() {
                isLoaded = true;
              });
              showSnackBar(context,
                  "Проверьте подключение к Интернету и повторите попытку!");
            });
          },
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (context) {
        return alert;
      },
    );
  }

  getClientInfo() {
    DioClient().getClientInfo(widget.id).then((value) {
      setState(() {
        isLoaded = true;
      });
      print(value.data["data"]);
      _commentController.text = value.data["data"]["comment"];
      _nameController.text = value.data["data"]["fullName"];
      title = value.data["data"]["fullName"];
      _phoneController.text = value.data["data"]["phone"];
    }).catchError((e) {
      setState(() {
        isLoaded = true;
      });
      showSnackBar(
          context, "Проверьте подключение к Интернету и повторите попытку!");
    });
  }

  @override
  void initState() {
    getClientInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title.toUpperCase()),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Stack(
            children: [
              Visibility(
                visible: isLoaded,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 45,
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
                            constraints: const BoxConstraints(
                                minHeight: 42, maxHeight: 42),
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
                              _phoneController.text =
                                  '+7${_phoneController.text}';
                              _phoneController.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset: _phoneController.text.length));
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
                            constraints: const BoxConstraints(
                                minHeight: 42, maxHeight: 42),
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
                        height: 10,
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
                                    .updateClientInfo(
                                        widget.id,
                                        _nameController.text,
                                        _phoneController.text,
                                        _commentController.text)
                                    .then((value) async {
                                  Navigator.pop(context);
                                  Navigator.pop(context);

                                  showSnackBar(context,
                                      "Информация о клиенте успешно обновлена!");

                                  setState(() {
                                    _commentController.text = "";
                                    _nameController.text = "";

                                    _phoneController.text = "";
                                  });
                                }).catchError((e) {
                                  Navigator.pop(context);

                                  showSnackBar(context,
                                      "Не верный формат номера телефона");
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
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 27),
                        child: SizedBox(
                          width: double.infinity,
                          height: 35,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xffA82424),
                              onPrimary: Colors.black,
                              shadowColor: Colors.grey,
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13)),
                            ),
                            onPressed: () {
                              deleteOperation(widget.id);
                            },
                            child: const Text(
                              'УДАЛИТЬ КЛИЕНТА',
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
              Visibility(
                  visible: !isLoaded,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
  }
}
