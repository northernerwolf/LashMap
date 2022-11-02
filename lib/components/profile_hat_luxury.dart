import 'package:flutter/material.dart';
import 'package:lash_map/utils/app_colors.dart';

class ProfileHatLuxury extends StatelessWidget {
  final String name;
  const ProfileHatLuxury({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 42.0),
      child: Stack(
        children: [
          Container(
            height: 78,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    offset: const Offset(4, 4),
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.3))
              ],
            ),
            margin: const EdgeInsets.only(left: 40, top: 8),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 35,
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12)),
                      gradient: LinearGradient(
                        colors: [Color(0xff443C38), Color(0xff221E18)],
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        name.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(12)),
                        gradient: LinearGradient(
                          begin: Alignment(-1.0, -4.0),
                          end: Alignment(1.0, 4.0),
                          colors: [
                            Color(0xff21020A),
                            Color(0xffBD4260),
                            Color(0xff21020A),
                            Color(0xffBD4260),
                            Color(0xff21020A),
                          ],
                        )),
                    child: Center(
                      child: Text(
                        "LUXURY",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          shadows: <Shadow>[
                            Shadow(
                                offset: const Offset(1, 1),
                                blurRadius: 1.0,
                                color: Colors.black.withOpacity(0.45)),
                          ],
                        ),
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
                height: 43,
                width: 98,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                    ),
                    color: Color(0xff630018)),
                child: const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "осталось\n365 дней",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 78,
                height: 78,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 4),
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.3))
                    ],
                    gradient: const LinearGradient(colors: [
                      Color(0xffC6008E),
                      Color(0xff4D0113),
                    ])),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                ),
              ),
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Colors.white),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                ),
              ),
              const SizedBox(
                width: 66,
                height: 66,
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/photo.png"),
                ),
              ),
            ],
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
    path.lineTo(size.width / 3, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
