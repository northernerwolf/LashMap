import 'package:flutter/material.dart';
import 'package:lash_map/components/app_bar.dart';
import 'package:lash_map/db/repo/request.dart';
import 'package:lash_map/utils/app_colors.dart';
import 'package:lash_map/utils/utils.dart';

class ContactWithDevPage extends StatefulWidget {
  const ContactWithDevPage({super.key});

  @override
  State<ContactWithDevPage> createState() => _ContactWithDevPageState();
}

class _ContactWithDevPageState extends State<ContactWithDevPage> {
  final TextEditingController paymentProblemController =
      TextEditingController();
  final TextEditingController technicalProblemController =
      TextEditingController();
  final TextEditingController suggestionController = TextEditingController();
  final TextEditingController partnershipController = TextEditingController();
  final TextEditingController othersController = TextEditingController();

  bool isPaymentProblemExpanded = false;
  bool isTechnicalProblemExpanded = false;
  bool isSuggestionExpanded = false;
  bool isPartnershipExpanded = false;
  bool isOthersExpanded = false;

  @override
  void dispose() {
    super.dispose();
    paymentProblemController.dispose();
    technicalProblemController.dispose();
    suggestionController.dispose();
    partnershipController.dispose();
    othersController.dispose();
  }

  sendFeedback(TextEditingController controller, int id) {
    if (controller.text.isNotEmpty) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const SizedBox.expand(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      );
      DioClient().sendFeedback(id, controller.text).then((value) {
        Navigator.pop(context);
        showSnackBar(context,
            "We will contact with you soon! Thank you for your feedback!");
        controller.text = "";
      }).catchError((e) {
        showSnackBar(context, "Check internet connection!");
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(""),
        body: Column(children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 100, right: 26),
                margin: EdgeInsets.only(left: 26, right: 26),
                color: Color(0xff3C735F),
                child: Text(
                  "СПАСИБО ЗА ОБРАЩЕНИЕ!\nМЫ СКОРО СВЯЖЕМСЯ С ВАМИ.\nОТВЕТ ПРИДЕТ НА УКАЗАННЫЙ ВАМИ EMAIL",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Container(
                decoration:
                    BoxDecoration(color: const Color(0xfffafafa), boxShadow: [
                  BoxShadow(
                      offset: const Offset(1, 1),
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.25))
                ]),
                padding: const EdgeInsets.only(top: 20, bottom: 12),
                child: const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "СВЯЗАТЬСЯ\nС РАЗРАБОТЧИКОМ",
                    style: TextStyle(fontSize: 24, color: AppColors.primary),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Stack(
                      children: [
                        Visibility(
                          visible: isPaymentProblemExpanded,
                          child: Container(
                              margin: const EdgeInsets.only(
                                  top: 35, left: 40, right: 40),
                              height: 228,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(13)),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(4, 4),
                                        blurRadius: 16,
                                        color: Colors.black.withOpacity(0.25))
                                  ],
                                  color: const Color(0xffe9e9e9)),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: TextField(
                                    controller: paymentProblemController,
                                    minLines: 20,
                                    maxLines: 20,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(8)),
                                    keyboardType: TextInputType.multiline,
                                  )),
                                  GestureDetector(
                                    onTap: () {
                                      sendFeedback(paymentProblemController, 1);
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.vertical(
                                            bottom: Radius.circular(13)),
                                        color: Color(0xff708DFF),
                                      ),
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      child: const Center(
                                        child: Text("ОТПРАВИТЬ",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 35,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: isPaymentProblemExpanded
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
                                isPaymentProblemExpanded =
                                    !isPaymentProblemExpanded;
                              });
                            },
                            child: const Text(
                              'ПРОБЛЕМА С ОПЛАТОЙ',
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
                      height: 18,
                    ),
                    Stack(
                      children: [
                        Visibility(
                          visible: isTechnicalProblemExpanded,
                          child: Container(
                              margin: const EdgeInsets.only(
                                  top: 35, left: 40, right: 40),
                              height: 228,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(13)),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(4, 4),
                                        blurRadius: 16,
                                        color: Colors.black.withOpacity(0.25))
                                  ],
                                  color: const Color(0xffe9e9e9)),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: TextField(
                                    controller: technicalProblemController,
                                    minLines: 20,
                                    maxLines: 20,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(8)),
                                    keyboardType: TextInputType.multiline,
                                  )),
                                  GestureDetector(
                                    onTap: () {
                                      sendFeedback(
                                          technicalProblemController, 2);
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.vertical(
                                            bottom: Radius.circular(13)),
                                        color: Color(0xff708DFF),
                                      ),
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      child: const Center(
                                        child: Text("ОТПРАВИТЬ",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 35,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: isTechnicalProblemExpanded
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
                                isTechnicalProblemExpanded =
                                    !isTechnicalProblemExpanded;
                              });
                            },
                            child: const Text(
                              'ТЕХНИЧЕСКАЯ ПРОБЛЕМА',
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
                      height: 18,
                    ),
                    Stack(
                      children: [
                        Visibility(
                          visible: isSuggestionExpanded,
                          child: Container(
                              margin: const EdgeInsets.only(
                                  top: 35, left: 40, right: 40),
                              height: 228,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(13)),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(4, 4),
                                        blurRadius: 16,
                                        color: Colors.black.withOpacity(0.25))
                                  ],
                                  color: const Color(0xffe9e9e9)),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: TextField(
                                    controller: suggestionController,
                                    minLines: 20,
                                    maxLines: 20,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(8)),
                                    keyboardType: TextInputType.multiline,
                                  )),
                                  GestureDetector(
                                    onTap: () {
                                      sendFeedback(suggestionController, 3);
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.vertical(
                                            bottom: Radius.circular(13)),
                                        color: Color(0xff708DFF),
                                      ),
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      child: const Center(
                                        child: Text("ОТПРАВИТЬ",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 35,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: isSuggestionExpanded
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
                                isSuggestionExpanded = !isSuggestionExpanded;
                              });
                            },
                            child: const FittedBox(
                              child: Text(
                                'ПРЕДЛОЖЕНИЕ ПО УЛУЧШЕНИЮ СЕРВИСА',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Stack(
                      children: [
                        Visibility(
                          visible: isPartnershipExpanded,
                          child: Container(
                              margin: const EdgeInsets.only(
                                  top: 35, left: 40, right: 40),
                              height: 228,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(13)),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(4, 4),
                                        blurRadius: 16,
                                        color: Colors.black.withOpacity(0.25))
                                  ],
                                  color: const Color(0xffe9e9e9)),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: TextField(
                                    controller: partnershipController,
                                    minLines: 20,
                                    maxLines: 20,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(8)),
                                    keyboardType: TextInputType.multiline,
                                  )),
                                  GestureDetector(
                                    onTap: () {
                                      sendFeedback(partnershipController, 4);
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.vertical(
                                            bottom: Radius.circular(13)),
                                        color: Color(0xff708DFF),
                                      ),
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      child: const Center(
                                        child: Text("ОТПРАВИТЬ",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 35,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: isPartnershipExpanded
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
                                isPartnershipExpanded = !isPartnershipExpanded;
                              });
                            },
                            child: const Text(
                              'ПАРТНЕРСТВО',
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
                      height: 18,
                    ),
                    Stack(
                      children: [
                        Visibility(
                          visible: isOthersExpanded,
                          child: Container(
                              margin: const EdgeInsets.only(
                                  top: 35, left: 40, right: 40),
                              height: 228,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(13)),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(4, 4),
                                        blurRadius: 16,
                                        color: Colors.black.withOpacity(0.25))
                                  ],
                                  color: const Color(0xffe9e9e9)),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: TextField(
                                    controller: othersController,
                                    minLines: 20,
                                    maxLines: 20,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(8)),
                                    keyboardType: TextInputType.multiline,
                                  )),
                                  GestureDetector(
                                    onTap: () {
                                      sendFeedback(othersController, 5);
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.vertical(
                                            bottom: Radius.circular(13)),
                                        color: Color(0xff708DFF),
                                      ),
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      child: const Center(
                                        child: Text("ОТПРАВИТЬ",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 35,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: isOthersExpanded
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
                                isOthersExpanded = !isOthersExpanded;
                              });
                            },
                            child: const Text(
                              'ДРУГОЕ',
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
                      height: 18,
                    ),
                  ],
                ),
              ),
            ),
          )
        ]));
  }
}
