import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DriverInfoScreen extends StatefulWidget {
  const DriverInfoScreen({super.key});

  @override
  State<DriverInfoScreen> createState() => _DriverInfoScreenState();
}

class _DriverInfoScreenState extends State<DriverInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Información de Transportista',
          style: GoogleFonts.openSans(),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DriverProfile(),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 10.0),
              child: Text(
                'Comentarios',
                style: GoogleFonts.openSans(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return _CommentItem();
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Añadir comentario', textAlign: TextAlign.center),
          content: TextFormField(
            inputFormatters: [LengthLimitingTextInputFormatter(255)],
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
              labelText: 'Comentario',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es obligatorio';
              }
              return null;
            },
            maxLines: 7,
            minLines: 1,
          ),
          actions: [
            Column(
              children: [
                Text('Califica al transportista', textAlign: TextAlign.center,),
                SizedBox(height: 15),
                RatingBar.builder(
                  itemSize: 35,
                  initialRating: 1,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith((states) => Color.fromRGBO(15, 21, 163, 1)),
                      ),
                      onPressed: () {
                        buttonAction();
                      },
                      child: Text('Enviar', style: TextStyle(color: Colors.white),),
                    ),
                    SizedBox(width: 10),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith((states) => Color.fromRGBO(15, 21, 163, 1)),
                      ),
                      onPressed: () {
                        buttonAction();
                      },
                      child: Text('Cancelar', style: TextStyle(color: Colors.white),),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      );

  void buttonAction() {
    Navigator.of(context).pop();
  }
}

class _CommentItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5.0,
        right: 5.0,
        bottom: 10.0,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 28,
            backgroundImage: AssetImage('assets/imgs/user-vector.png'),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nombre Apellido',
                  style: GoogleFonts.openSans(),
                ),
                Row(
                  children: [
                    RatingBarIndicator(
                      rating: 3.0,
                      itemSize: 20.0,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text('3.0'),
                  ],
                ),
              ],
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris consectetur ex id pellentesque sagittis. Etiam a vehicula neque, non viverra nisl. Etiam a tellus quis urna lacinia interdum.',
              style: GoogleFonts.openSans(),
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ),
    );
  }
}

class _DriverProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 15.0,
            bottom: 5.0,
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/imgs/user-vector.png',
              height: 120,
            ),
          ),
        ),
        Column(
          children: [
            Text(
              'Nombre Apellido',
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'correo@gmail.com',
              style: GoogleFonts.openSans(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5.0),
            RatingBarIndicator(
              rating: 3.0,
              itemSize: 25.0,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
