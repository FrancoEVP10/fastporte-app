import 'package:flutter/material.dart';
import 'package:fastporte_app/globals.dart' as globals;
import 'package:google_fonts/google_fonts.dart';

class SelectRoleScreen extends StatelessWidget {
  const SelectRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _BodyScreen(),
          Opacity(
            opacity: 0.5,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: 200,
                color: Color.fromRGBO(26, 204, 141, 1),
              ),
            ),
          ),
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              height: 180,
              color: Color.fromRGBO(26, 204, 141, 1),
            ),
          ),
        ],
      ),
    );
  }
}

class _BodyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(15, 21, 163, 1),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'FastPorte',
              style: GoogleFonts.openSans(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 280,
              child: Text(
                'La plataforma donde podrás encontrar el serivico que necesitas.',
                style: GoogleFonts.openSans(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                elevation: 0,
                color: Color.fromRGBO(26, 204, 141, 1),
                onPressed: () {
                  globals.role = 'cliente';
                  Navigator.pushReplacementNamed(context, 'login');
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 75, vertical: 15),
                    child: Text('SOY CLIENTE',
                        style: TextStyle(color: Colors.white, fontSize: 18)))),
            SizedBox(
              height: 15,
            ),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                elevation: 0,
                color: Color.fromRGBO(26, 204, 141, 1),
                onPressed: () {
                  globals.role = 'transportista';
                  Navigator.pushReplacementNamed(context, 'login');
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    child: Text('SOY TRANSPORTISTA',
                        style: TextStyle(color: Colors.white, fontSize: 18)))),
          ],
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());
    final path = Path();
    path.lineTo(0, size.height);
    final firstStart = Offset(size.width / 5, size.height);
    final firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
    final secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    final secondEnd = Offset(size.width, size.height - 10);
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
