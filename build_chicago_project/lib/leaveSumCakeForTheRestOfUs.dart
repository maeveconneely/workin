import 'package:build_chicago_project/main.dart';
import 'package:build_chicago_project/task.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LeaveSumCakeForTheRestOfUs extends StatefulWidget {

  final Task t;

  const LeaveSumCakeForTheRestOfUs(this.t);

  @override
  _LeaveSumCakeForTheRestOfUsState createState() =>
      _LeaveSumCakeForTheRestOfUsState();
}

class _LeaveSumCakeForTheRestOfUsState
    extends State<LeaveSumCakeForTheRestOfUs> {
  Completer<GoogleMapController> _controller = Completer();
  //location = 
  static const LatLng _center = const LatLng(41.8781, -87.6298);

  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    for (int i = 0; i < locations.length; i++)
    {
      _addMarker(locations[i], context, _controller);
    }
  }

  void _addMarker(location,context,controller){
    LatLng pos = LatLng(location.lat,location.long)
    setState(()
    _markers.add(Marker(
      markerId: MarkerId(location.name)
      position: pos,
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(
        title: location.name
        snippet: location.time,
      ),
      onTap: (){
        _selectedLocation = location;
      }
    )
    ))
  }
  @override
  Widget build(BuildContext context) {
    String name = "";
    String finalDestination = "";
    String groceryStore = "";
    return Stack(
          children: [
            Container(
              padding: EdgeInsets.all(30),
              child: Text(
              "Location",
              style: TextStyle(fontWeight: FontWeight.bold),
             textAlign: TextAlign.left,
             textScaleFactor: 4,
            ),
          ),
      Column(children: <Widget>[
        Padding(child:
        Center(
          child: Container(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
            margin: const EdgeInsets.all(10.0),
            color: Colors.amber[600],
            width: 390,
            height: 450,
          ),
        ),
        padding: EdgeInsets.only(top: 100),
        ),
        Text(
          "Name: " + widget.t.name,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.w900,
            color: Colors.black,
            fontFamily: 'Lobster',
          ),
        ),
        Text("Final Destination: " + widget.t.finalDestination,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 17.0, color: Colors.blue, fontFamily: 'Lobster')),
        Text("Grocery Store: " + widget.t.groceryStore,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
                fontFamily: 'Lobster')),
        Text("Groceries: " + widget.t.groceries,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 17.0, color: Colors.blue, fontFamily: 'Lobster')),
      ]),]
    );
  }
}








