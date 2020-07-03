import 'dart:async';
import 'dart:convert' show jsonDecode;

import 'package:App/models/global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => new _InfoPageState();
}

//http://27a48a2a7272.ngrok.io/registration/3
class _InfoPageState extends State<InfoPage> {
  Future<Registration> _getRegistrations() async {
    var data = await http.get("https://7150c8ede0d2.ngrok.io/registration/4");

    var jsonData = jsonDecode(data.body);
    Registration registration = Registration.fromJson(jsonData);
    return registration;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
          child: FutureBuilder(
        future: _getRegistrations(),
        builder: (BuildContext context, AsyncSnapshot<Registration> snapshot) {
          if (snapshot.data == null) {
            return Container(child: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return Text('error');
          } else {
            /*return Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Text(snapshot.data.address,
                  style: TextStyle(color: Colors.black, fontSize: 30.0)),
            );*/
            /*return ListTile(
              contentPadding: const EdgeInsets.only(top: 200),
              title: Text('Owner'),
              subtitle: Text(snapshot.data.),
            );*/
            return Container(
              color: darkGreyColor,
              padding: const EdgeInsets.only(top: 200.0),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 15, left: 15, right: 15),
                    padding: EdgeInsets.all(10),
                    //height: 1000,
                    decoration: BoxDecoration(
                        color: Colors.blue[200],
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 10.0,
                          )
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ListTile(
                          title: Text("Owner"),
                          subtitle:
                              Text(snapshot.data.owner, style: darkTodoTitle),
                        ),
                        ListTile(
                          title: Text("Plate Number"),
                          subtitle: Text(snapshot.data.plate_num,
                              style: darkTodoTitle),
                        ),
                        ListTile(
                          title: Text("Driver License Number"),
                          subtitle: Text(snapshot.data.dl_number,
                              style: darkTodoTitle),
                        ),
                        ListTile(
                          title: Text("Vehicle Class"),
                          subtitle: Text(snapshot.data.vehicle_class,
                              style: darkTodoTitle),
                        ),
                        ListTile(
                          title: Text("Model"),
                          subtitle: Text(snapshot.data.maker_model,
                              style: darkTodoTitle),
                        ),
                        ListTile(
                          title: Text("Address"),
                          subtitle:
                              Text(snapshot.data.address, style: darkTodoTitle),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      )),
    );
  }
}

class Registration {
  String address;
  int age;
  // ignore: non_constant_identifier_names
  String dl_number;
  int id;
  // ignore: non_constant_identifier_names
  String maker_model;
  String owner;
  // ignore: non_constant_identifier_names
  String plate_num;
  // ignore: non_constant_identifier_names
  String vehicle_class;

  /*Registration(this.id, this.plate_num, this.owner, this.maker_model,
      this.vehicle_class, this.age, this.dl_number, this.address);*/

  Registration.fromJson(Map map) {
    this.address = map['address'];
    this.age = map['age'];
    this.dl_number = map['dl_number'];
    this.id = map['id'];
    this.maker_model = map['maker_model'];
    this.owner = map['owner'];
    this.plate_num = map['plate_num'];
    this.vehicle_class = map['vehicle_class'];
  }
}
