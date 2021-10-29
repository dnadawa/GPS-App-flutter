import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(
      MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.purpleAccent,


          ),
          home: Homepage()


      )
  );
}


class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  Position position;
  StreamSubscription<Position> positionStream;
  String lat,long = '';





  getLocation () async {
    var geolocator = Geolocator();
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 1);

    positionStream = geolocator.getPositionStream(locationOptions).listen(
            (Position position) {
          // print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
          if(position != null){
            setState(() {
              lat = position.latitude.toStringAsFixed(2);
              long = position.longitude.toStringAsFixed(2);
            });
          }
          else{
            setState(() {
              lat = 'Unknown';
              long = 'Unknown';
            });
          }
        });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lat='0.00';
    long='0.00';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () { /* Write listener code here */ },
          child: Icon(
            Icons.,  // add custom icons also
          ),
        ),
        title: Text('GPS App'),
        centerTitle: true,

      ),

      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0,30,0,60),
                child: SizedBox(
                    width: 300,
                    child: Image.asset('assets/home.png')
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Latitude",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(lat,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Longtitude",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(long,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: getLocation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 50),
                    child: Text('Start Tracking', style: TextStyle(color: Colors.white,fontSize: 18)),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
                  ),
                ),
              )
            ],
          ),
        ),
      ),


    );
  }
}
