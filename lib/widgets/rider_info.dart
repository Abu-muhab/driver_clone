import 'package:driver_clone/global/screen_size.dart';
import 'package:driver_clone/models/trip_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class RiderInfo extends StatefulWidget {
  final Trip trip;
  RiderInfo({this.trip, Key key}) : super(key: key);
  @override
  State createState() => RiderInfoState();
}

class RiderInfoState extends State<RiderInfo> {
  Trip trip;
  bool showOverviewLoadingIndicator = true;

  @override
  void initState() {
    trip = widget.trip;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context),
      color: Colors.white,
      child: Container(
        width: width(context),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: width(context),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.transparent,
                            child: Image.asset(
                              'images/cars.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'UberX  ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Icon(
                                      Icons.person,
                                      size: 14,
                                    ),
                                    Text(
                                      '4',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                                Text(
                                  '6:09pm drop-off',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      'NGN 850.00',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
            showOverviewLoadingIndicator
                ? LinearProgressIndicator()
                : Divider(),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  shape: CircleBorder(side: BorderSide(color: Colors.black)),
                  child: Icon(Icons.phone_in_talk),
                  onPressed: () {
                    var url = "tel:${trip.riderPhone}";
                    launch(url);
                  },
                ),
                SizedBox(
                  width: width(context) * 0.7,
                  height: 50,
                  child: TextField(
                    readOnly: true,
                    onTap: () {
                      Navigator.of(context).pushNamed("chat_screen");
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0)),
                        hintText: "Send Pickup message"),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
