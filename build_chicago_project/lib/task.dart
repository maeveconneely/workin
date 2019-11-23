import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';

class Task {
  final String name;
  final String finalDestination;
  final String groceryStore;
  final String groceries;
  //final String[] latlong;
  Task(this.name, this.finalDestination, this.groceryStore,
  this.groceries);

  Task.fromJson(Map<String, dynamic> json)
  : name = json["name"],
  finalDestination = json["finalDestination"],
  groceryStore = json["groceryStore"],
  groceries = json["groceries"];

  String groceriesString() {
    String str = "";
    for (int i = 0; i < groceries.length; i++) {
      str += groceries[i] + ", ";
    }
    return str;
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'finalDestination': finalDestination,
    'groceryStore': groceryStore,
    'groceries': groceries
  };

  factory Task.fromMap(Map<String, dynamic> parsedJson) {
    return Task(
      parsedJson['name'],
      parsedJson['finalDestination'],
      parsedJson['groceryStore'],
      parsedJson['groceries']
    );
  }
  
  /*getUserLocation() async {//call this async method from whereever you need

      LocationData myLocation;
      String error;
      Location location = new Location();
      try {
        myLocation = await location.getLocation();
      } on PlatformException catch (e) {
        if (e.code == 'PERMISSION_DENIED') {
          error = 'please grant permission';
          print(error);
        }
        if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
          error = 'permission denied- please enable it from app settings';
          print(error);
        }
        myLocation = null;
      }
      //currentLocation = myLocation;
      final coordinates = new Coordinates(
          myLocation.latitude, myLocation.longitude);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(
          coordinates);
      var first = addresses.first;
      //print(' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
      return first;
    }
  getLatLong() async {
    LocationData myLocation;
    myLocation = await location.getLocation();
    //currentLocation = myLocation;
    final coordinates = new LatLng(
        myLocation.latitude, myLocation.longitude);
    return coordinates;
  }
*/
}