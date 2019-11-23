import 'package:build_chicago_project/main.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LeaveSumCakeForTheRestOfUs extends StatefulWidget {
@override
  _LeaveSumCakeForTheRestOfUsState createState() =>_LeaveSumCakeForTheRestOfUsState();
}
class _LeaveSumCakeForTheRestOfUsState extends State<LeaveSumCakeForTheRestOfUs>
{
 Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(41.8781, -87.6298);

  final Set<Marker> _markers = {};
 
void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    
  }


  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Builder(
          builder: (context) => Scaffold(
                appBar: AppBar(
                  title: Text('Details'),
                  backgroundColor: Colors.blue,
                ),
                body: Stack(children: <Widget>[
                  GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _center,
                        zoom: 11.0,
                      ),
                      ),
                  
                ]),
              ),
        ),
        );
  }
}