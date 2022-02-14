import 'package:feeling/models/utilisateurs.dart';
import 'package:feeling/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../localization/language_constants.dart';

class LocationScreen extends StatefulWidget {
  
  final Utilisateurs utilisateurs;
  const LocationScreen(this.utilisateurs, {Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  
  @override
  Widget build(BuildContext context) {

    var size  = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey, width: 1, style: BorderStyle.solid),
                    ),
                    child: Padding(
                     padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      child: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor, size: MediaQuery.of(context).size.width*0.06),
                    ),
                  ),
                ),
              SizedBox(height: size.height*0.03),
              Center(
                child: CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.location_on, size: size.width*0.15, color: Colors.white),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
              
              SizedBox(height: size.height*0.07),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(getTranslated(context,'activer_position'), style: TextStyle(fontSize: size.width*0.09, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                ),
              ),
              SizedBox(height: size.height*0.01),
              Text(getTranslated(context,'activer_position_description'), style: TextStyle(fontSize:  size.width*0.06,), textAlign: TextAlign.center),
              SizedBox(height: size.height*0.06),
              InkWell(
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).primaryColor ,
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () {  
                          localisation();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(getTranslated(context,'btn_autoriser'),
                            style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width*0.05, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> localisation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    widget.utilisateurs.position = await location.getLocation();
    Navigator.pushNamed(context, aproposRoute, arguments: widget.utilisateurs); 
    
  }

}

