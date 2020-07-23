import 'package:driver_clone/global/screen_size.dart';
import 'package:driver_clone/models/location_model.dart';
import 'package:driver_clone/models/request_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestCard extends StatelessWidget {
  final Request request;
  RequestCard({this.request});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.account_circle, size: 50),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          request.riderName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          request.riderPhoneNumber,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Divider(
                thickness: 1.5,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.directions),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        request.pickupInfo.formattedAddress,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width(context) * 0.6,
                height: 45,
                child: FlatButton(
                  onPressed: () async {
                    await Provider.of<RequestModel>(context, listen: false)
                        .acceptsTrip(request);
                    Provider.of<LocationModel>(context, listen: false)
                        .setMapMode(MapMode.AcceptedRequest);
                  },
                  child: Text(
                    'ACCEPT RIDE',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Swipe to reject",
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }
}
