import 'package:flutter/material.dart';
import 'package:fastporte_app/contracts/services/contract_service.dart';
// import 'dart:html' as html;

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;
  List<String> tabs = ['Waiting', 'Done', 'Current'];
  final RestorableInt tabIndex = RestorableInt(0);
  final contractsService = ContractService();
  late Future<List<dynamic>> contractsFuture =
      contractsService.getPendingContracts();

  @override
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    _tabController.addListener(() {
      // When the tab controller's value is updated, make sure to update the
      // tab index value, which is state restorable.
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
    contractsFuture = contractsService.getPendingContracts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  Widget getTabContent(int index, data) {
    switch (index) {
      case 0:
        return waitingInfo(data);
      case 1:
        return doneInfo(data);
      case 2:
        return currentInfo(data);
      default:
        return Container();
    }
  }

  Future<List<dynamic>> getUpdatedContracts(int index) {
    switch (index) {
      case 0:
        return contractsService.getOfferContracts();
      case 1:
        return contractsService.getHistoryContracts();
      case 2:
        return contractsService.getPendingContracts();
      default:
        return contractsService.getPendingContracts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: TabBar(
          indicatorColor: Color.fromRGBO(26, 204, 141, 1),
          controller: _tabController,
          isScrollable: false,
          tabs: [
            for (final tab in tabs) Tab(text: tab),
          ],
          onTap: (index) async {
            setState(() {
              contractsFuture = getUpdatedContracts(index);
            });
          },
        ),
      ),
      body: FutureBuilder(
        future: contractsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('No existen contratos disponibles'));
          } else {
            return TabBarView(
              controller: _tabController,
              children: [
                for (final tab in tabs)
                  getTabContent(tabs.indexOf(tab), snapshot.data),
              ],
            );
          }
        },
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
            height: 220,
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
                  Divider(
                    color: Colors.grey,
                    thickness: 1.0,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              contractsService.declineOfferDriver(item['id']);
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
                              contractsService.acceptOfferDriver(item['id']);
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
                        ],
                      ),
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
            height: 220,
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
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
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
                  Divider(
                    color: Colors.grey,
                    thickness: 1.0,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Price: S/.${item['amount']}",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     // _launchURL();
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     primary: Colors.blue,
                      //   ),
                      //   child: Text(
                      //     'Export',
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      // ),
                      // CircleAvatar(
                      //   radius: 20,
                      //   backgroundImage: NetworkImage(item['client']['photo']),
                      //   backgroundColor: Colors.grey,
                      // ),
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
            height: 220,
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
                  Divider(
                    color: Colors.grey,
                    thickness: 1.0,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Price: S/.${item['amount']}",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500, // Add this line
                        ),
                      ),
                      SizedBox(width: 140),
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

  // _launchURL() async {
  //   html.window.open("https://firebasestorage.googleapis.com/v0/b/gener8-c323f.appspot.com/o/string.pdf?alt=media", "pdf");
  // }
}
