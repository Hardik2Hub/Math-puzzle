import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:puzzle/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'game.dart';
import 'level.dart';

void main() {
  runApp(MaterialApp(
    home: puzzle(),
    debugShowCheckedModeBanner: false,
  ));
}

class puzzle extends StatefulWidget {

  static SharedPreferences? prefs;


  @override
  State<puzzle> createState() => _puzzleState();
}

class _puzzleState extends State<puzzle> {

  int cur_level = 0;

  List l = [];

  @override
  void initState() {
    super.initState();
    get_permission();
    getper();
  }

  getper() async {
    puzzle.prefs = await SharedPreferences.getInstance();

    cur_level = puzzle.prefs!.getInt('con') ?? 0;

    l = List.filled(data.ans.length, "no");
    for (int i = 0; i < cur_level; i++) {
      l[i] = puzzle.prefs!.getString("le_st$i");
    }
    print("${cur_level}");
    print(l);
    setState(() {});
  }

  get_permission() async {
    bool permissionStatus;
    final deviceInfo = await DeviceInfoPlugin().androidInfo;

    if (deviceInfo.version.sdkInt > 32) {
      permissionStatus = await Permission.photos.request().isGranted;
    } else {
      permissionStatus = await Permission.storage.request().isGranted;
    }
  }


  bool b = false;
  bool c = false;
  bool d = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage("img/background.jpg"))),
            child: Column(children: [
              Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text("Math Puzzles",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold)),
                  )),
              Expanded(
                  flex: 4,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("img/blackboard_main_menu.png"))),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTapUp: (details) {
                                    b = false;
                                    setState(() {});
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return game();
                                      },
                                    ));
                                  },
                                  onTapCancel: () {
                                    b = false;
                                    setState(() {});
                                  },
                                  onTapDown: (details) {
                                    b = true;
                                    setState(() {});
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text("CONTINUE",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontFamily: 'one')),
                                    margin: EdgeInsets.all(5),
                                    height: 50,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        border: (b == true)
                                            ? Border.all(color: Colors.white)
                                            : null,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        )),
                                  ),
                                ),
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTapUp: (details) {
                                    c = false;
                                    setState(() {});
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return level(l,cur_level);
                                      },
                                    ));
                                  },
                                  onTapCancel: () {
                                    c = false;
                                    setState(() {});
                                  },
                                  onTapDown: (details) {
                                    c = true;
                                    setState(() {});
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text("PUZZLES",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontFamily: 'one')),
                                    margin: EdgeInsets.all(5),
                                    height: 50,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        border: (c == true)
                                            ? Border.all(color: Colors.white)
                                            : null,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        )),
                                  ),
                                ),
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTapUp: (details) {
                                    d = false;
                                    setState(() {});
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return puzzle();
                                      },
                                    ));
                                  },
                                  onTapCancel: () {
                                    d = false;
                                    setState(() {});
                                  },
                                  onTapDown: (details) {
                                    d = true;
                                    setState(() {});
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text("BUY PRO",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontFamily: 'one')),
                                    margin: EdgeInsets.all(5),
                                    height: 50,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        border: (d == true)
                                            ? Border.all(color: Colors.white)
                                            : null,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        )),
                                  ),
                                ),
                              ]),
                        ]),
                  )),
              Expanded(child: Container()),
            ]),
          )),
    ), onWillPop: () async{
      exit(0);
      return true;
    },);
  }
}
