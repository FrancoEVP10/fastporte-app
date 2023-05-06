import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 42,
                bottom: 30,
                right: 42,
                top: 28,
              ),
              child: Text(
                '¿Necesitas Ayuda?',
                style: TextStyle(fontSize: 24),
              ),
            ),
            _SupportCard(),
          ],
        ),
      ),
    );
  }
}

class _SupportCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(12),
        )),
        child: SizedBox(
          width: 360,
          height: 500,
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Icon(
                    Icons.contact_support_outlined,
                    size: 140,
                  ),
                ),
                SizedBox(height: 35),
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    enabled: false,
                    decoration: _InputDecorations.supportInputDecoration(
                      labelText: 'fastporte_support@gmail.com',
                      prefixIcon: Icons.mail_outline,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    enabled: false,
                    decoration: _InputDecorations.supportInputDecoration(
                      labelText: '+51 987654321',
                      prefixIcon: Icons.person_outlined,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('assets/imgs/whatsapp-logo.png'),
                    Image.asset('assets/imgs/facebook-logo.png'),
                    Image.asset('assets/imgs/instagram-logo.png'),
                  ],
                ),
                SizedBox(height: 20),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Color.fromRGBO(15, 21, 163, 1),
                  onPressed: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    child: Text(
                      'Enviar Mensaje',
                      style: TextStyle(color: Colors.white, fontSize: 14),
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

class _InputDecorations {
  static InputDecoration supportInputDecoration({
    required String labelText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
        border: InputBorder.none,
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        prefixIcon:
            prefixIcon != null ? Icon(prefixIcon, color: Colors.grey) : null);
  }
}
