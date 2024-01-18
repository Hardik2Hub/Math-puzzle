import 'package:flutter/material.dart';
import 'package:puzzle/data.dart';
import 'package:puzzle/main.dart';

import 'game.dart';

class level extends StatefulWidget {
  List l;
  int cur_level;


  level(this.l,this.cur_level);

  @override
  State<level> createState() => _levelState();
}

class _levelState extends State<level> {

  int le = 0;
  @override
  void initState() {
    super.initState();

    le = puzzle.prefs!.getInt('con') ?? 0;


    setState(() {});
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
                      fit: BoxFit.fill,
                      image: AssetImage("img/background.jpg"))),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    child: Text("Select Puzzle",
                        style: TextStyle(fontSize: 35, color: Colors.indigo)),
                  ),
                  Expanded(
                      child: GridView.builder(
                    itemCount: data.ans.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (le+1>index) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return game(index);
                              },
                            ));
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: (index < widget.cur_level+1)
                              ? Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                      fontFamily: "one", fontSize: 40),
                                )
                              : null,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            image: (index < widget.cur_level+1)
                                ? (widget.l[index] == "yes")
                                    ? DecorationImage(
                                        image: AssetImage("img/tick.png"))
                                    : null
                                : DecorationImage(
                                    image: AssetImage("img/lock.png")),
                            border: Border.all(width: 3),
                          ),
                        ),
                      );
                    },
                  ))
                ],
              ))),
    );
  }
}
