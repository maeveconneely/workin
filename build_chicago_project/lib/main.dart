import 'dart:convert';

import 'package:build_chicago_project/leaveSumCakeForTheRestOfUs.dart';
import 'package:build_chicago_project/task.dart';
import 'package:flutter/material.dart';

import 'don\'t_touch/database_helper.dart';
import 'don\'t_touch/listBlock.dart';
import 'goHere.dart';
import 'pusher_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Demo';
    return MaterialApp(
      title: title,
      home: Scaffold(
      body: Stack(children: [
        Positioned.fill(
                  child: Container(
            child: CustomPaint(
              painter: CurvePainter(),
              
            ),
          ),
        ),
        Positioned(child: Home()),
      ]),
    ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final String CHANNEL = "my-channel";
  final String EVENT = "my-event";
  List tasks = [];
  Task mainTask;
  var dbHelper = DatabaseHelper.instance;

  void navigation() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => GoHere(mainTask)));
  }

  Future<List> getAllRecords() async {
    var db = await dbHelper.queryAllRows();

    return db.toList();
  }

  Future<List> getLists(List strings) async {
    List allRows = await getAllRecords();
    // print(allRows.length);
    // print(allRows);
    strings = List<Task>();
    allRows.forEach((row) {
      print(row);
      strings.add(Task.fromJson(row));
    });

    print(strings);

    List<Widget> list = new List<Widget>();
    for (var i = 0; i < strings.length; i++) {
      print(strings[i].name);

      list.add(listBlock(strings[i].name, strings[i].finalDestination,
          strings[i].groceryStore, strings[i].groceries, navigation));
    }

    print(list);
    return list;
  }

  void addTask(Task t) async {
    await dbHelper.insertScore(t).then((value) {}).catchError((onError) {
      dbHelper.updateScore(t);
    });
    tasks.add(t);
  }

  PusherService pusherService = PusherService();
  @override
  void initState() {
    pusherService = PusherService();
    pusherService.firePusher(CHANNEL, EVENT);

    super.initState();
  }

  @override
  void dispose() {
    pusherService.unbindEvent(CHANNEL);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Tasks",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
              textScaleFactor: 5,
            ),
          ),
          Column(
            children: <Widget>[
              StreamBuilder(
                stream: pusherService.eventStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  Map taskMap = jsonDecode(snapshot.data);
                  Task t = Task.fromJson(taskMap);
                  mainTask = t;
                  print(t);

                  addTask(t);

                  return Container(
                    child: FutureBuilder<List>(
                      future: getLists(tasks),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print("okay");
                          return Column(children: snapshot.data);
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ]),
      );
    
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.lightBlue[800];
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height * 0.25);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height * 0.25);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
