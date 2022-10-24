import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lash_map/components/client_item.dart';
import 'package:lash_map/db/models/client_list.dart';
import 'package:lash_map/db/repo/request.dart';
import 'package:lash_map/utils/utils.dart';

import '../utils/app_colors.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  List<ClientList> usersList = [];
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
    getUsers();
  }

  getUsers() {
    DioClient().getClients().then((value) {
      setState(() {
        usersList = value;
        isLoaded = true;
      });
    }).catchError((e) {
      print(e);
      setState(() {
        isLoaded = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Visibility(
          visible: isLoaded,
          child: Column(
            children: [
              Container(
                decoration:
                    BoxDecoration(color: const Color(0xfff9f9f9), boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.25))
                ]),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 46,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "БАЗА КЛИЕНТОВ",
                          style:
                              TextStyle(color: AppColors.primary, fontSize: 24),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        GestureDetector(
                          onTap: () => openAddNewClient(context),
                          child: const Icon(
                            CupertinoIcons.add_circled_solid,
                            size: 29,
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 43,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 10, left: 10, bottom: 10),
                      child: Container(
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xfff1f1f1),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              isDense: true,
                              prefixIcon: Icon(Icons.search),
                              prefixIconColor: Color(0xff7c7c7c),
                              hintText: "поиск",
                              hintStyle: TextStyle(
                                  color: Color(0xff7c7c7c),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Theme(
                  data: Theme.of(context).copyWith(
                      scrollbarTheme: ScrollbarThemeData(
                          trackColor: MaterialStateProperty.all(
                              const Color(0xffd9d9d9)),
                          trackBorderColor: MaterialStateProperty.all(
                              const Color(0xffd9d9d9)),
                          thumbColor: MaterialStateProperty.all(
                              const Color(0xffBA7C1F)))),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Scrollbar(
                      trackVisibility: true,
                      radius: const Radius.circular(24),
                      thickness: 8,
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                            children: List.generate(
                                usersList.length,
                                (index) => ClientItem(
                                    clientName: usersList[index].fullName))),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Visibility(
            visible: !isLoaded,
            child: Center(
              child: CircularProgressIndicator(),
            ))
      ],
    );
  }
}
