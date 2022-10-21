import 'package:flutter/material.dart';

class ProfileHatLuxury extends StatelessWidget {
  const ProfileHatLuxury({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Stack(
        children: [
          SizedBox(
            height: 90,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 36,
                  margin: const EdgeInsets.only(left: 40, top: 8),
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12)),
                      gradient: LinearGradient(
                        colors: [Color(0xff443C38), Color(0xff221E18)],
                      )),
                  child: const Center(
                    child: Text(
                      "ОЛЬГА МАЛИЕВА",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 48),
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(12)),
                        gradient: RadialGradient(
                          radius: 6,
                          center: Alignment.bottomRight,
                          colors: [
                            Color(0xff21020A),
                            Color(0xffBD4260),
                            Color(0xff21020A),
                            Color(0xffBD4260),
                            Color(0xff21020A),
                            Color(0xffBD4260),
                          ],
                        )),
                    child: const Center(
                      child: Text(
                        "LUXURY",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: ClipPath(
              clipper: CustomClip(),
              child: Container(
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Color(0xff630018)),
                child: Text(
                  "осталось\n365 дней",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 90,
            height: 90,
            child: CircleAvatar(
              backgroundColor: Colors.amber,
            ),
          )
        ],
      ),
    );
  }
}

class CustomClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);

    path.lineTo(size.width, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
