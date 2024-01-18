import 'package:flutter/material.dart';
import 'package:puzzle/data.dart';
import 'package:puzzle/main.dart';
import 'package:puzzle/win.dart';

class game extends StatefulWidget {
  int? ind;

  game([this.ind]);

  @override
  State<game> createState() => _gameState();
}

class _gameState extends State<game> {
  String str = "";
  int level = 0;

  @override
  void initState() {
    super.initState();

    if (widget.ind != null) {
      level = widget.ind!;
    } else {
      level = puzzle.prefs!.getInt('con') ?? 0;
    }
    print("lvl no $level");
    setState(() {});
  }

  get(String a) {
    if (a == "*") {
      str = str.substring(0, str.length - 1);
    } else {
      str = str + "$a";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:WillPopScope( onWillPop: () async{
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text("Exit agin"),
            actions: [
              TextButton(onPressed: () {
                Navigator.pop(context);
              }, child: Text("cancel")),
              TextButton(onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) {
                  return puzzle();
                },));
              }, child: Text("ok")),
            ],
          );
        },);
            return true;
          },
        child: SafeArea(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("img/gameplaybackground.jpg"))),
              child: Column(children: [
                Expanded(
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                              child: InkWell(
                                onTap: () {
                                  String str = puzzle.prefs!.getString('skip') ?? "";
                                  if (str == "") {
                                    DateTime dt = DateTime.now();
                                    puzzle.prefs!.setString('skip', dt.toString());
                                    puzzle.prefs!.setString('le_st${level}', 'no');
                                    level++;
                                    puzzle.prefs!.setInt('con', level);
                                  }
                                  else {
                                    DateTime cur_time = DateTime.now();
                                    DateTime skip = DateTime.parse(str);
                                    Duration dur = cur_time.difference(skip);
                                    int sec = dur.inSeconds;
                                    if (sec >= 10) {
                                      puzzle.prefs!.setString('skip', cur_time.toString());
                                      puzzle.prefs!.setString('le_st${level}','no');
                                      level++;
                                      puzzle.prefs!.setInt('con', level);
                                    }
                                    else {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("You Can Skip After 10 Second"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Ok"))
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage("img/skip.png")))),
                              )),
                          Expanded(
                              flex: 3,
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Text("${data.le[level]}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  margin: EdgeInsets.all(10),
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage("img/level_board.png"))))),
                          Expanded(
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        actions: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                      margin: EdgeInsets.all(5),
                                                      child: Text("OK"))),
                                            ],
                                          )
                                        ],
                                        content: Text("Sum"),
                                        title: Text("Hint"),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage("img/hint.png")))),
                              )),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 5,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("${data.qu[level]}"))),
                    )),
                Expanded(flex: 2, child: Container()),
                Expanded(
                    child: Container(
                        color: Colors.black,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("$str",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20)),
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                                )),
                            Expanded(
                                child: InkWell(
                                  onTap: () => get("*"),
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 5, top: 5),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage("img/delete.png"))),
                                  ),
                                )),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  if (str == "${data.ans[level]}") {
                                    if(widget.ind==null)
                                    {
                                      puzzle.prefs!.setString("le_st${level}","yes");
                                      level++;

                                      puzzle.prefs!.setInt('con', level);
                                      print(level);
                                      str="";
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return win(level);
                                            },
                                          ));
                                    }
                                    else
                                    {
                                        puzzle.prefs!.setString("le_st${level}","yes");
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return win(level+1,true);
                                              },
                                            ));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("Wrong"),
                                      behavior: SnackBarBehavior.floating,
                                      width: 100,
                                      duration: Duration(seconds: 3),
                                    ));
                                    str = "";
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  alignment: Alignment.center,
                                  child: Text("Submit",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white)),
                                ),
                              ),
                            )
                          ],
                        ))),
                Expanded(
                    child: Container(
                      color: Colors.black,
                      child: Row(children: [
                        Expanded(
                            child: InkWell(
                                onTap: () => get("1"),
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(2),
                                      ),
                                      border: Border.all(color: Colors.white)),
                                  child: Text("1",
                                      style:
                                      TextStyle(color: Colors.white, fontSize: 20)),
                                ))),
                        Expanded(
                            child: InkWell(
                                onTap: () => get("2"),
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(2),
                                      ),
                                      border: Border.all(color: Colors.white)),
                                  child: Text("2",
                                      style:
                                      TextStyle(color: Colors.white, fontSize: 20)),
                                ))),
                        Expanded(
                            child: InkWell(
                                onTap: () => get("3"),
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(2),
                                      ),
                                      border: Border.all(color: Colors.white)),
                                  child: Text("3",
                                      style:
                                      TextStyle(color: Colors.white, fontSize: 20)),
                                ))),
                        Expanded(
                            child: InkWell(
                                onTap: () => get("4"),
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(2),
                                      ),
                                      border: Border.all(color: Colors.white)),
                                  child: Text("4",
                                      style:
                                      TextStyle(color: Colors.white, fontSize: 20)),
                                ))),
                        Expanded(
                            child: InkWell(
                                onTap: () => get("5"),
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(2),
                                      ),
                                      border: Border.all(color: Colors.white)),
                                  child: Text("5",
                                      style:
                                      TextStyle(color: Colors.white, fontSize: 20)),
                                ))),
                        Expanded(
                            child: InkWell(
                                onTap: () => get("6"),
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(2),
                                      ),
                                      border: Border.all(color: Colors.white)),
                                  child: Text("6",
                                      style:
                                      TextStyle(color: Colors.white, fontSize: 20)),
                                ))),
                        Expanded(
                            child: InkWell(
                                onTap: () => get("7"),
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(2),
                                      ),
                                      border: Border.all(color: Colors.white)),
                                  child: Text("7",
                                      style:
                                      TextStyle(color: Colors.white, fontSize: 20)),
                                ))),
                        Expanded(
                            child: InkWell(
                                onTap: () => get("8"),
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(2),
                                      ),
                                      border: Border.all(color: Colors.white)),
                                  child: Text("8",
                                      style:
                                      TextStyle(color: Colors.white, fontSize: 20)),
                                ))),
                        Expanded(
                            child: InkWell(
                                onTap: () => get("9"),
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(2),
                                      ),
                                      border: Border.all(color: Colors.white)),
                                  child: Text("9",
                                      style:
                                      TextStyle(color: Colors.white, fontSize: 20)),
                                ))),
                        Expanded(
                            child: InkWell(
                                onTap: () => get("0"),
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(2),
                                      ),
                                      border: Border.all(color: Colors.white)),
                                  child: Text("0",
                                      style:
                                      TextStyle(color: Colors.white, fontSize: 20)),
                                ))),
                      ]),
                    )),
                Expanded(child: Container()),
              ]),
            )),
      ),
    );
  }
}
