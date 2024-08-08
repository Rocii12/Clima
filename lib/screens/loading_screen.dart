import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'location_screen.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const appkey = 'b36ef8e0109c1d4a65b06674240a2645';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double latitude;
  late double longitude;
  @override
  void initState() {
    super.initState();
    getLocation();
  }
 Future<dynamic> getcityweather(String cityname) async
 {
   var url='https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=$appkey&units=metric';
  Networkhelper networkhelper=await Networkhelper(url);
  var weatherData=networkhelper.getData();
  return weatherData;
 }

  void getLocation() async {
    await Geolocator.requestPermission();
    await Geolocator.checkPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    latitude = position.latitude;
    longitude = position.longitude;
    Networkhelper networkhelper = Networkhelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$appkey&units=metric');
    var weatherData = await networkhelper.getData();

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LocationScreen(locationWeather: weatherData,)));
  }
  // void getData() async{
  //   http.Response response=await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$appkey'));
  //   print(response.body);
  //   if(response.statusCode==200)
  //     {
  //       String data=response.body;
  //       int condition=jsonDecode(data)['weather'][0]['id'];
  //       print(condition);
  //       double temperature=jsonDecode(data)['main']['temp'];
  //       print(temperature);
  //       String city=jsonDecode(data)['name'];
  //       print(city);
  //     }
  //   else
  //     {
  //       print(response.statusCode);
  //     }
  // }

  // void getPermission() async{
  //   LocationPermission permission = await Geolocator.requestPermission();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
