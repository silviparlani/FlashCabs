import 'package:flashcabs/page_two.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'icons.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({Key? key}) : super(key: key);

  @override
  State<CurrentLocationScreen> createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {

  late GoogleMapController googleMapController;
  static const CameraPosition initialCameraPosition = CameraPosition(target: LatLng(18.4861, 73.8162), zoom: 14.0);
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Current Location"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            markers: markers,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller){
              googleMapController=controller;
            },
          ),
          Column(
            children: <Widget>[

              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Pickup Location',
                    filled: true,
                    fillColor: Colors.white
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Dropoff Location',
                  filled: true,
                  fillColor: Colors.white
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  onPressed: ()async{
                    Position position= await _determinePosition();
                    googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 15)));

                    markers.clear();
                    markers.add(Marker(markerId: const MarkerId('currentLocation'), position: LatLng(position.latitude, position.longitude)));
                    setState(() {});
                  },
                  child: Text('Use Current Location As Source'),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      elevation: 10
                  ),
                ),
              ),
              Spacer(),
              SizedBox(height: 10,),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PageTwo()));
                  },
                  child: Text('Check Fares'),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      elevation: 10
                  ),
                ),
              ),
              SizedBox(height: 10,),
            ],
          )

        ],
        ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(label: 'OLA', icon: Icon(MyFlutterApp.ola_icon),),
          BottomNavigationBarItem(icon: Icon(MyFlutterApp.uber), label:'UBER'),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label:'RAPIDO'),
        ],
      ),

    );
  }

  Future<Position> _determinePosition() async {

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled=await Geolocator.isLocationServiceEnabled();

    if(!serviceEnabled){
      return Future.error('Location Services are Disabled');
    }

    permission= await Geolocator.checkPermission();

    if(permission== LocationPermission.denied){
      permission= await Geolocator.requestPermission();

      if(permission== LocationPermission.denied){
        return Future.error('Location Permission Denied');
      }
    }

    if(permission== LocationPermission.deniedForever){
      return Future.error('Location Permission Permanently Denied. Go to settings and allow.');
    }

    Position position= await Geolocator.getCurrentPosition();
    return position;

  }

}

