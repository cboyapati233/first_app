import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';


void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App>{

  String _locationMessage = "";
  String _address="";
  String _place="";
  String _date;
  var date=new DateTime.now();

  void _currentLocation() async {
    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    print(date);

    
    List<Placemark> newplacemark = await Geolocator().placemarkFromCoordinates(position.latitude,position.longitude);
    Placemark placename=newplacemark[0];
    String place =placename.name; 
    print(place);
    setState(() {
      _address="${position.latitude},${position.longitude},${"    Time:"},$date";
      _place="$place";
      _locationMessage="${position.latitude},${position.longitude}";
      _date="$date";
    });

    
    final directory = await getApplicationDocumentsDirectory();
    final text = _address;
    final date1=_date;
    await new File('${directory.path}/location_file.txt').writeAsString(text);
    //await new File('${directory.path}/location_file.txt').writeAsString(date1);
    print('saved');
    
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var materialApp = MaterialApp(
          title: 'Flutter Demo',
          home:Scaffold(
            appBar: AppBar(
              title: Text("Location"),
            ),
            body: Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(_address),
                  
                                     
                  FlatButton(
                    onPressed: (){
                      _currentLocation();
                    },
                    color: Colors.indigo,
                    child: Text("Location"),
                    ),
                     
                ],
                
             )
            )
          )
          
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
           // primarySwatch: Colors.blue,
            // This makes the visual density adapt to the platform that you run
            // the app on. For desktop platforms, the controls will be smaller and
            // closer together (more dense) than on mobile platforms.
           // visualDensity: VisualDensity.adaptivePlatformDensity,
          );
         // home: MyHomePage(title: 'Flutter Demo Home Page'),
        
        return materialApp;
  }
}

