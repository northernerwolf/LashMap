import 'package:flutter/cupertino.dart';

class ClientItem extends StatelessWidget {
  final String clientName;
  const ClientItem({super.key, required this.clientName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 9, right: 28),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: const Color(0xffededed),
        ),
        height: 42,
        width: double.infinity,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            clientName,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
