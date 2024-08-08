// import 'package:geolocator/geolocator.dart';
// class Location
// {
//   Location({required this.latitude,required this.longitude});
//  late double latitude;
//   late double longitude;
//   Future<void> getcurrentLocation() async {
//     try
//      {
//      await Geolocator.requestPermission();
//      await Geolocator.checkPermission();
//     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
//     latitude=position.latitude;
//     longitude=position.longitude;}
//         catch(exc){
//       print(exc);
//         }
//   }
//
// }