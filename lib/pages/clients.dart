import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lash_map/components/client_item.dart';
import 'package:lash_map/db/models/client_list.dart';
import 'package:lash_map/db/repo/request.dart';
import 'package:lash_map/utils/utils.dart';

import '../utils/app_colors.dart';
import 'add_new_client.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  List<ClientList> usersList = [];
  List<ClientList> usersSearchList = [];

  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
    getUsers();
  }

  searchClient(String query) {
    final suggestion = usersList.where((element) {
      final fullName = element.fullName.toLowerCase();
      final input = query.toLowerCase();

      return fullName.contains(input);
    }).toList();

    final suggestionPhone = usersList.where((element) {
      final phone = element.phone;
      final input = query.toLowerCase();
      return phone.contains(input);
    }).toList();

    setState(() {
      usersSearchList = suggestion;
      usersSearchList.addAll(suggestionPhone);
    });
  }

  getUsers() {
    DioClient().getClients().then((value) {
      setState(() {
        usersList = value;
        usersSearchList = usersList;
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
    print(usersSearchList);
    return Scaffold(
      body: Stack(
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
                            "???????? ????????????????",
                            style: TextStyle(
                                color: AppColors.primary, fontSize: 24),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AddNewClientPage(),
                                ),
                              )
                                  .then((value) {
                                getUsers();
                              });
                            },
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextField(
                              onChanged: searchClient,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                isDense: true,
                                prefixIcon: Icon(Icons.search),
                                prefixIconColor: Color(0xff7c7c7c),
                                hintText: "??????????",
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
                Visibility(
                  visible: usersList.isNotEmpty,
                  replacement: const Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "?? ?????? ?????? ????????????????. ?????????????? ???????????? ??????????, ?????????? ????????????????.",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: AppColors.primary, fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                  child: Expanded(
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
                                    usersSearchList.length,
                                    (index) => GestureDetector(
                                          onTap: () {
                                            openEditClient(context,
                                                    usersSearchList[index].id)
                                                .then((value) {
                                              getUsers();
                                            });
                                          },
                                          child: ClientItem(
                                              clientName: usersSearchList[index]
                                                  .fullName),
                                        ))),
                          ),
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
              child: const Center(
                child: CircularProgressIndicator(),
              ))
        ],
      ),
    );
  }
}
