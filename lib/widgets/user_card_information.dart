import 'package:fastporte_app/comments/screens/driver_info.dart';
import 'package:fastporte_app/vehicle/model/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UserCardInformation extends StatelessWidget {
  final Vehicle vehicle;
  const UserCardInformation({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DriverInfoScreen(driver: vehicle.driver)));
          },
          child: SizedBox(
            width: 360,
            height: 110,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (vehicle.driver.photo == '')
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/imgs/user-vector.png',
                        height: 80,
                      ),
                    ),
                  ),
                if (vehicle.driver.photo != '')
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(vehicle.driver.photo),
                      backgroundColor: Colors.grey,
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20, right: 16, top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "${vehicle.driver.name} ${vehicle.driver.lastname}",
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        vehicle.brand,
                        style: TextStyle(fontSize: 14),
                      ),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
