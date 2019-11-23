import 'dart:convert';

import 'package:build_chicago_project/leaveSumCakeForTheRestOfUs.dart';
import 'package:build_chicago_project/task.dart';
import 'package:flutter/material.dart';

import 'don\'t_touch/database_helper.dart';
import 'don\'t_touch/listBlock.dart';
import 'pusher_service.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Demo';
    return MaterialApp(
      title: title,
      home: Home(),
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
  var dbHelper = DatabaseHelper.instance;

  void navigation() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => LeaveSumCakeForTheRestOfUs()));
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
    return Scaffold(
      body: Center(
        child: ListView(children: [
          Text("Tasks", style: TextStyle(fontWeight: FontWeight.bold),),
          Column(
            children: <Widget>[
              // FlatButton(
              //   onPressed: (){
              //     pusherService
              //   },

              // ),
              StreamBuilder(
                stream: pusherService.eventStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  Map taskMap = jsonDecode(snapshot.data);
                  Task t = Task.fromJson(taskMap);
                  print(t);

                  addTask(t);

                  return Container(
                    child: FutureBuilder<List>(
                      future: getLists(tasks),
                      builder: (context, snapshot) {
                      
                      if (snapshot.hasData){
                        print("okay");
                        return Column(children: snapshot.data);
                      }
                      else {
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
      ),
    );
  }
}
