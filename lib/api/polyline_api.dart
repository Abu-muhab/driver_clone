import 'package:driver_clone/api/location_math_api.dart';
import 'package:polyline/polyline.dart' as poly;
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:driver_clone/global/api_key.dart';
import 'dart:convert';

String timeOfArrival = "";

class PolylineApi {
  static Future<Map<String, dynamic>> getPolyLines(
      LatLng pickUp, LatLng dropOff) async {
    Map<String, dynamic> result = new Map();
    try {
      poly.Polyline polyline;
      var response;
      try {
        response = await http.get(
            'https://maps.googleapis.com/maps/api/directions/json?origin=${pickUp.latitude},${pickUp.longitude}'
            '&destination=${dropOff.latitude},${dropOff.longitude}&key=$api_key');
      } catch (err) {
        print("first block");
        return null;
      }
      if (response.statusCode == 200) {
        print(response.body);
        print(json.decode(response.body));
        if (json.decode(response.body)['status'] == "ZERO_RESULTS") {
          result.putIfAbsent("polyline", () => <LatLng>[]);
          result.putIfAbsent("steps", () => <Step>[]);
          return result;
        }
        polyline = poly.Polyline.Decode(
            precision: 5,
            encodedString: json.decode(response.body)['routes'][0]
                ['overview_polyline']['points']);
        timeOfArrival = json.decode(response.body)['routes'][0]['legs'][0]
            ['duration']['text'];
        result.putIfAbsent("polyline", () => coordinatesConverter(polyline));
        List<Step> steps = new List();
        var stepsTemp =
            json.decode(response.body)['routes'][0]['legs'][0]['steps'];
        for (int x = 0; x < stepsTemp.length; x++) {
          steps.add(Step.fromJson(stepsTemp[x]));
        }
        result.putIfAbsent("steps", () => steps);
        return result;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

  static List<LatLng> coordinatesConverter(poly.Polyline polyline) {
    var points = polyline.decodedCoords;
    List<LatLng> coordinates = new List();
    points.forEach((element) {
      coordinates.add(LatLng(element[0], element[1]));
    });
    return coordinates;
  }
}

class Step {
  String distance;
  String duration;
  LatLng startLocation;
  LatLng endLocation;
  String maneuver;
  Polyline polyLine;
  List<LatLng> coords;
  double distanceKm;

  Step(
      {this.distance,
      this.coords,
      this.duration,
      this.endLocation,
      this.distanceKm,
      this.maneuver,
      this.polyLine,
      this.startLocation});

  factory Step.fromJson(Map<String, dynamic> json) {
    List<LatLng> coordinates = PolylineApi.coordinatesConverter(
        poly.Polyline.Decode(
            precision: 5, encodedString: json['polyline']['points']));
    Polyline line = Polyline(
        polylineId: PolylineId("trip_overview"), points: coordinates, width: 3);
    return Step(
        distance: json['distance']['text'],
        coords: coordinates,
        duration: json['duration']['text'],
        startLocation: LatLng(
            json['start_location']['lat'], json['start_location']['lng']),
        endLocation:
            LatLng(json['end_location']['lat'], json['end_location']['lng']),
        polyLine: line,
        distanceKm: LocationMathApi.getDistanceFromLatLonInKm(
            json['start_location']['lat'],
            json['start_location']['lng'],
            json['end_location']['lat'],
            json['end_location']['lng']),
        maneuver: json['maneuver']);
  }
}
