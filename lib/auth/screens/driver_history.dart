import 'package:flutter/material.dart';

enum ButtonType {
  Done,
  Current,
  Waiting,
}

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  ButtonType selectedButton = ButtonType.Done;

  Color _buttonColor1 = Color(0xFF1ACC8D);
  Color _buttonColor2 = Color(0xFFD3D3D3);
  Color _buttonColor3 = Color(0xFFD3D3D3);

  Widget getInfoWidget() {
    switch (selectedButton) {
      case ButtonType.Done:
        return doneInfo();
      case ButtonType.Current:
        return currentInfo();
      case ButtonType.Waiting:
        return waitingInfo();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedButton = ButtonType.Done;
                    _buttonColor1 =
                        Color(0xFF1ACC8D); // Change the button color
                    _buttonColor2 =
                        Color(0xFFD3D3D3); // Change the button color
                    _buttonColor3 = Color(0xFFD3D3D3);
                  });
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: _buttonColor1,
                    foregroundColor: Color.fromRGBO(15, 21, 163, 1)),
                child: Text('Done'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedButton = ButtonType.Current;
                    _buttonColor1 =
                        Color(0xFFD3D3D3); // Change the button color
                    _buttonColor2 =
                        Color(0xFF1ACC8D); // Change the button color
                    _buttonColor3 = Color(0xFFD3D3D3);
                  });
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: _buttonColor2,
                    foregroundColor: Color.fromRGBO(15, 21, 163, 1)),
                child: Text('Current'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedButton = ButtonType.Waiting;
                    _buttonColor1 =
                        Color(0xFFD3D3D3); // Change the button color
                    _buttonColor2 =
                        Color(0xFFD3D3D3); // Change the button color
                    _buttonColor3 =
                        Color(0xFF1ACC8D); // Change the button color
                  });
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: _buttonColor3,
                    foregroundColor: Color.fromRGBO(15, 21, 163, 1)),
                child: Text('Waiting'),
              ),
            ],
          ),
          getInfoWidget(),
        ],
      ),
    );
  }

  Widget doneInfo() {
    return Container(
      child: Text('Done'),
    );
  }

  Widget currentInfo() {
    return Container(
      child: Text('Current'),
    );
  }

  Widget waitingInfo() {
    final List<MyData> apiData = [
      MyData('Item 1 Title', 'Item 1 Description'),
      MyData('Item 2 Title', 'Item 2 Description'),
      MyData('Item 3 Title', 'Item 3 Description'),
      MyData('Item 4 Title', 'Item 4 Description'),
      MyData('Item 5 Title', 'Item 5 Description'),
    ];

    return Expanded(
      child: ListView.builder(
        itemCount: apiData.length,
        itemBuilder: (BuildContext context, int index) {
          final item = apiData[index];
          return Container(
            height: 200,
            margin: EdgeInsets.all(10),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(73, 63, 62, 62),
                          blurRadius: 10,
                          offset: Offset(0, 3))
                    ]),
                padding: EdgeInsets.all(10),
                child: Row(children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 10, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Subject: ${item.title}",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Text(
                          "From: Avenida Larco 601, Lima, Miraflores - 15072",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Text(
                          "To: Ciudad de Caral, Lomas de Lachay",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Text(
                          "Price: S/. 1560",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                print("a");
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: Text(
                                'Decline',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                print("a");
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF1ACC8D),
                              ),
                              child: Text(
                                'Accept',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 110,
                            ),

                            Image.asset(
                              'assets/imgs/user-vector.png',
                              // Provide the path to your image asset
                              fit: BoxFit.cover,
                              width: 45,
                            ),
                          ],
                        )
                      
                      ]
                    )
                  )
                ]
              )
            ),
          );
        },
      ),
    );
  }
}

class MyData {
  final String? title;
  final String description;

  MyData(this.title, this.description);
}
