import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:puzzle/data.dart';
import 'package:share/share.dart';

import 'game.dart';
import 'main.dart';

class win extends StatefulWidget {

  int level;
  bool? is_skip;

  win(this.level,[this.is_skip]);

  @override
  State<win> createState() => _wiState();
}

class _wiState extends State<win> {

    Future<File> getImageFileFromAssets(String path) async {
      final byteData = await rootBundle.load('$path');

      final file = File('${(await getTemporaryDirectory()).path}/$path');
      await file.create(recursive: true);
      await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

      return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Text("${data.le[widget.level-1]} Completed",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.indigo)),
            )),
            Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 45),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("img/trophy.png"))),
                )),
            Expanded(
                flex: 4,
                child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  if(widget.is_skip==true)
                                  {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return game(widget.level);
                                          },
                                        ));
                                  }
                                  else
                                  {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return game();
                                          },
                                        ));
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text("CONTINUE",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 30,
                                      )),
                                  margin: EdgeInsets.all(5),
                                  height: 50,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Colors.black38,
                                        Colors.white,
                                        Colors.black38
                                      ]),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(
                                          color: Colors.grey, width: 2)),
                                ),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return puzzle();
                                    },
                                  ));
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text("MAIN MENU",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                      )),
                                  margin: EdgeInsets.all(5),
                                  height: 50,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Colors.black38,
                                        Colors.white,
                                        Colors.black38
                                      ]),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(
                                          color: Colors.grey, width: 2)),
                                ),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return puzzle();
                                    },
                                  ));
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text("BUY PRO",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                      )),
                                  margin: EdgeInsets.all(5),
                                  height: 50,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Colors.black38,
                                        Colors.white,
                                        Colors.black38
                                      ]),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(
                                          color: Colors.grey, width: 2)),
                                ),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  getImageFileFromAssets("${data.qu[widget.level-1]}").then((value) {
                                    Share.shareFiles(['${value.path}'], text: 'Great picture');
                                  });
                                  setState(() {});
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text("Share",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                      )),
                                  margin: EdgeInsets.all(5),
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Colors.black38,
                                        Colors.white,
                                        Colors.black38
                                      ]),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(
                                          color: Colors.grey, width: 2)),
                                ),
                              ),
                            ]),
                      ]),
                )),
            Expanded(child: Container()),
          ]),
        ),
      ),
    );
  }
}
