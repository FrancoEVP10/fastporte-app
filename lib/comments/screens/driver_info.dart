import 'package:fastporte_app/auth/model/user.dart';
import 'package:fastporte_app/auth/services/user_service.dart';
import 'package:fastporte_app/comments/model/comment.dart';
import 'package:fastporte_app/comments/services/comments_service.dart';
import 'package:fastporte_app/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class DriverInfoScreen extends StatefulWidget {
  final User driver;
  const DriverInfoScreen({super.key, required this.driver});

  @override
  State<DriverInfoScreen> createState() => _DriverInfoScreenState();
}

class _DriverInfoScreenState extends State<DriverInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final commentsService = Provider.of<CommentsService>(context);
    final commentFuture =
        commentsService.getCommentsByDriverId(widget.driver.id);
    return FutureBuilder(
        future: commentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final comments = snapshot.data;
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
                  'Perfil del Transportista',
                  style: GoogleFonts.openSans(),
                ),
              ),
              body: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _DriverProfile(driver: widget.driver),
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
                    if (snapshot.hasData)
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: comments?.length,
                        itemBuilder: (context, index) {
                          return _CommentItem(client: comments![index]);
                        },
                      ),
                    if (comments!.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Column(
                          children: const <Widget>[
                            Text('No hay comentarios para este usuario,',
                                style: TextStyle(fontSize: 20)),
                            Text('Sé el primero en comentar.',
                                style: TextStyle(fontSize: 20))
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showDialog(context: context, builder: (context){
                    return _DialogForm(driver1: widget.driver);
                  });
                },
                child: Icon(Icons.add),
              ),
            );
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: Center(
                child: CircularProgressIndicator(backgroundColor: Colors.grey),
              ),
            );
          }
        });
  }

  Future openDialog(BuildContext context) async {
    late User client;
    final driver = widget.driver;
    late int id;
    late String star;
    late String comment;
    final commentsService =
        Provider.of<CommentsService>(context, listen: false);
    final userService = Provider.of<UserService>(context, listen: false);
    userService.getUserById(globals.localId).then((User result) {
      setState(() {
        client = result;
      });
    });
    commentsService.getSize().then((int result) {
      id = result;
    });
    return showDialog(
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
          onChanged: (value) => comment = value,
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
              Text(
                'Califica al transportista',
                textAlign: TextAlign.center,
              ),
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
                onRatingUpdate: (rating) {
                  star = rating.toString();
                },
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Color.fromRGBO(15, 21, 163, 1)),
                    ),
                    onPressed: commentsService.isSaving ? null : () async {
                      Navigator.of(context).pop();
                      await commentsService.createComment(Comment(client: client, comment: comment, driver: driver, id: id, star: star));
                    },
                    child: Text(
                      'Enviar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 10),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Color.fromRGBO(15, 21, 163, 1)),
                    ),
                    onPressed: () {
                      buttonAction();
                    },
                    child: Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void buttonAction() {
    Navigator.of(context).pop();
  }
}

class _CommentItem extends StatelessWidget {
  final Comment client;

  const _CommentItem({required this.client});

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
          title: Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${client.client.name} ${client.client.lastname}',
                  style: GoogleFonts.openSans(),
                ),
                Row(
                  children: [
                    RatingBarIndicator(
                      rating: double.parse(client.star),
                      itemSize: 20.0,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(client.star),
                  ],
                ),
              ],
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              client.comment,
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
  final User driver;

  const _DriverProfile({required this.driver});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (driver.photo == '')
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
          if (driver.photo != '')
            SizedBox(
              height: 120,
              width: 120,
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(driver.photo),
                backgroundColor: Colors.grey,
              ),
            ),
          Column(
            children: [
              Text(
                '${driver.name} ${driver.lastname}',
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                driver.email,
                style: GoogleFonts.openSans(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5.0),
              //TODO añadir un getRatingByDriverId
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
      ),
    );
  }
}


class _DialogForm extends StatefulWidget {
  final User driver1;
  const _DialogForm({required this.driver1});

  @override
  State<_DialogForm> createState() => _DialogFormState();
}

class _DialogFormState extends State<_DialogForm> {
  @override
  Widget build(BuildContext context) {
    late User client;
    final driver = widget.driver1;
    late int id;
    late String star;
    late String comment;
    final commentsService =
        Provider.of<CommentsService>(context, listen: false);
    final userService = Provider.of<UserService>(context, listen: false);
    userService.getUserById(globals.localId).then((User result) {
      client = result;
    });
    commentsService.getSize().then((int result) {
      id = result;
    });
    return AlertDialog(
        title: Text('Añadir comentario', textAlign: TextAlign.center),
        content: TextFormField(
          inputFormatters: [LengthLimitingTextInputFormatter(255)],
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(),
            labelText: 'Comentario',
          ),
          onChanged: (value) => comment = value,
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
              Text(
                'Califica al transportista',
                textAlign: TextAlign.center,
              ),
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
                onRatingUpdate: (rating) {
                  star = rating.toString();
                },
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Color.fromRGBO(15, 21, 163, 1)),
                    ),
                    onPressed: commentsService.isSaving ? null : () async {
                      await commentsService.createComment(Comment(client: client, comment: comment, driver: driver, id: id, star: star));
                      buttonAction();
                    },
                    child: Text(
                      'Enviar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 10),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Color.fromRGBO(15, 21, 163, 1)),
                    ),
                    onPressed: () {
                      buttonAction();
                    },
                    child: Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      );
  }

    void buttonAction() {
    Navigator.of(context).pop();
  }
}