import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';


class LocationScreen extends StatefulWidget {
  LocationScreen( { this.locationWeather});
  late final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late WeatherModel weatherModel=WeatherModel();
  late WeatherModel weather=WeatherModel();
late String weatherIcon;
 late String weathermessage;
late String city;
late int temperature;
  @override
  void initState() {
        super.initState();
        updateUI(widget.locationWeather);
  }
  void updateUI(dynamic weatherData)
  {
 setState(() {
   var condition = weatherData['weather'][0]['id'];
   weatherIcon = weatherModel.getWeatherIcon(condition);
   temperature = weatherData['main']['temp'].toInt();
   weathermessage = weatherModel.getMessage(temperature);
   city = weatherData['name'];
 });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weathe=await widget.locationWeather;
                      updateUI(weathe);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                    var typedname= await  Navigator.push(context, MaterialPageRoute(builder: (context)=>CityScreen()));

                    if(typedname!= null)
                     {
                       var weatherData= widget.locationWeather(typedname);
                       updateUI(weatherData);
                     }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weathermessage in $city',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
