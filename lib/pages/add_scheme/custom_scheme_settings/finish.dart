import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/custom_lash_provider.dart';
import '../../../utils/app_colors.dart';

class FinishingCustomScheme extends StatelessWidget {
  const FinishingCustomScheme({super.key});

  @override
  Widget build(BuildContext context) {
    final addZonesProvider = Provider.of<CustomLashProvider>(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: const Color(0xffE9E9EA)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ОБЪЕМ - ${addZonesProvider.volumeValue}"),
                const SizedBox(
                  height: 6,
                ),
                RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                      text: "ИЗГИБ - ", style: TextStyle(color: Colors.black)),
                  for (var element in addZonesProvider.customBendValues)
                    if (element != null)
                      TextSpan(
                          text: "$element, ",
                          style: const TextStyle(color: Colors.black))
                ])),
                const SizedBox(
                  height: 6,
                ),
                Text("ТОЛЩИНА - ${addZonesProvider.thicknessValue}mm"),
                const SizedBox(
                  height: 6,
                ),
                RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                      text: "ДЛИНА - ", style: TextStyle(color: Colors.black)),
                  for (var element in addZonesProvider.customLengthValues)
                    if (element != null)
                      TextSpan(
                          text: "$element-",
                          style: const TextStyle(color: Colors.black)),
                  const TextSpan(
                      text: "mm", style: TextStyle(color: Colors.black)),
                ])),
                const SizedBox(
                  height: 6,
                ),
                Text(
                    "ЦВЕТ - ${addZonesProvider.isBlack ? "ЧЕРНЫЙ" : "КОРИЧНЕВЫЕ"}"),
                const SizedBox(
                  height: 6,
                ),
                RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                      text: "ЛУЧИКИ - ", style: TextStyle(color: Colors.black)),
                  TextSpan(
                      text: "${addZonesProvider.rayBendValue}, ",
                      style: const TextStyle(color: Colors.black)),
                  TextSpan(
                      text: "${addZonesProvider.rayThickness.toString()}, ",
                      style: const TextStyle(color: Colors.black)),
                  TextSpan(
                      text: "+${addZonesProvider.rayLength.toString()} ",
                      style: const TextStyle(color: Colors.black)),
                  const TextSpan(
                      text: "mm (к длине)",
                      style: TextStyle(color: Colors.black)),
                ])),
                const SizedBox(
                  height: 6,
                ),
                Text(addZonesProvider.commentController.text.isEmpty
                    ? "* Мокрый эффект"
                    : addZonesProvider.commentController.text),
              ],
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          TextField(
            keyboardType: TextInputType.multiline,
            minLines: 4,
            maxLines: 10,
            onChanged: (value) {
              addZonesProvider.onCommentChange();
            },
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
            controller: addZonesProvider.commentController,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffEDEDED),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(13)),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              hintText: "Мокрый эффект",
              hintStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          const SizedBox(
            height: 21,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 31,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: AppColors.primary,
                    ),
                    child: const Center(
                      child: FittedBox(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "СОХРАНИТЬ В БАЗУ",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 21,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 31,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: AppColors.primary,
                    ),
                    child: const Center(
                      child: FittedBox(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "СОХРАНИТЬ В ГАЛЕРЕЮ",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 21,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 31,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: AppColors.primary,
                    ),
                    child: const Center(
                      child: FittedBox(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "РЕДАКТИРОВАТЬ СХЕМУ",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 21,
                ),
              ],
            ),
          ),

          //
        ],
      ),
    );
  }
}
