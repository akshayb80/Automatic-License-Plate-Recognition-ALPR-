import 'dart:io';

import 'package:App/UI/Intray/info_page.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'models/global.dart';
import 'UI/Intray/intray_page.dart';
import 'package:image_picker/image_picker.dart';

import 'models/global.dart';
import 'models/global.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  void manualenter() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SearchBar(
              searchBarStyle: SearchBarStyle(
                backgroundColor: Colors.blue[200],
                padding: EdgeInsets.all(10),
                borderRadius: BorderRadius.circular(50),
              ),
              hintText: "Enter Plate Number",
            ),
          ),
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.yellow,
      home: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: new Scaffold(
            body: Stack(children: <Widget>[
              TabBarView(
                children: [
                  IntrayPage(),
                  InfoPage(),
                  new Container(
                    color: darkGreyColor,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 50),
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Auto Info", style: intrayTitleStyle),
                    Container()
                  ],
                ),
              ),
              Container(
                height: 70,
                width: 70,
                margin: EdgeInsets.only(
                    top: 120,
                    left: MediaQuery.of(context).size.width * 0.3333 - 69),
                child: FloatingActionButton(
                  heroTag: "btn1",
                  child: Icon(Icons.camera_alt, size: 40),
                  backgroundColor: Colors.blue[800],
                  onPressed: getImage,
                  tooltip: 'Pick Image',
                ),
              ),
              Container(
                  height: 70,
                  width: 70,
                  margin: EdgeInsets.only(
                      top: 120,
                      left: MediaQuery.of(context).size.width * 0.5 - 39),
                  child: FloatingActionButton(
                    heroTag: "btn2",
                    child: Icon(Icons.add_a_photo, size: 40),
                    backgroundColor: Colors.blue[800],
                    onPressed: pickImage,
                  )),
              Container(
                  height: 70,
                  width: 70,
                  margin: EdgeInsets.only(
                      top: 120,
                      left: MediaQuery.of(context).size.width * 0.648),
                  child: FloatingActionButton(
                    heroTag: "btn3",
                    child: Icon(Icons.add, size: 40),
                    backgroundColor: Colors.blue[800],
                    onPressed: manualenter,
                  )),
            ]),
            appBar: AppBar(
              elevation: 0,
              title: new TabBar(
                tabs: [
                  Tab(
                    icon: new Icon(Icons.home),
                  ),
                  Tab(
                    icon: new Icon(Icons.info),
                  ),
                  Tab(
                    icon: new Icon(Icons.perm_identity),
                  ),
                ],
                labelColor: darkGreyColor,
                unselectedLabelColor: Colors.blue,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.all(5.0),
                indicatorColor: Colors.transparent,
              ),
              backgroundColor: Colors.white,
            ),
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
