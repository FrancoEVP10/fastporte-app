import 'package:fastporte_app/contracts/services/contract_service.dart';
import 'package:flutter/material.dart';

enum ButtonType {
  done,
  current,
  waiting,
}

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  ButtonType selectedButton = ButtonType.done;

  Color _buttonColor1 = Color(0xFF1ACC8D);
  Color _buttonColor2 = Color(0xFFD3D3D3);
  Color _buttonColor3 = Color(0xFFD3D3D3);

  Widget getInfoWidget(data) {
    data ??= [];
    switch (selectedButton) {
      case ButtonType.done:
        return doneInfo(data);
      case ButtonType.current:
        return currentInfo(data);
      case ButtonType.waiting:
        return waitingInfo(data);
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final contractsService = ContractService();
    final contractsFuture = contractsService.getContracts();

    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedButton = ButtonType.done;
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
                    selectedButton = ButtonType.current;
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
                    selectedButton = ButtonType.waiting;
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
          FutureBuilder(
              future: contractsFuture,
              builder: (context, AsyncSnapshot<List>? snapshot) {
                return getInfoWidget(snapshot?.data);
              })
        ],
      ),
    );
  }

  Widget waitingInfo(data) {
    final List<dynamic> apiData = data;

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
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(73, 63, 62, 62),
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.fromLTRB(20, 20, 20, 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Subject: ${item['subject']}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    //margin: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1.0,
                    ),
                  ),
                  Text(
                    "From: ${item['from']}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 11),
                  Text(
                    "To: ${item['to']}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 11),
                  Text(
                    "Price: S/.${item['amount']}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                      SizedBox(width: 10),
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
                      SizedBox(width: 125),
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(item['client']['photo']),
                        backgroundColor: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget doneInfo(data) {
    final List<dynamic> apiData = data;
    //print(data);
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
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(73, 63, 62, 62),
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.fromLTRB(20, 20, 20, 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Subject: ${item['subject']}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    //margin: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1.0,
                    ),
                  ),
                  Text(
                    "From: ${item['from']}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Time: ${item['timeDeparture']} - ${item['timeArrival']}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "To: ${item['to']}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Price: S/.${item['amount']}",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500, // Add this line
                        ),
                      ),
                      SizedBox(width: 195),
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(item['client']['photo']),
                        backgroundColor: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget currentInfo(data) {
    final List<dynamic> apiData = data;

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
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(73, 63, 62, 62),
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.fromLTRB(20, 20, 20, 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Subject: ${item["subject"]}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    //margin: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1.0,
                    ),
                  ),
                  Text(
                    "From: ${item['from']}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Time Start: ${item['timeDeparture']}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "To: ${item['to']}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Price: S/.${item['amount']}",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500, // Add this line
                        ),
                      ),
                      SizedBox(width: 195),
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(item['client']['photo']),
                        backgroundColor: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
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
