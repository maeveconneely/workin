import 'package:flutter/material.dart';

import '../goHere.dart';
import '../task.dart';
import 'fitnessAppTheme.dart';

class listBlock extends StatelessWidget {
  dynamic name;
  dynamic finalDestination;
  dynamic groceryStore;
  dynamic groceries;
  Function pressed;

  listBlock(this.name, this.finalDestination, this.groceryStore, this.groceries,
      this.pressed);

  @override
  Widget build(BuildContext context) {
    print(groceries);
    // String str = "";
    // for(int i = 0; i < groceries.length; i++) {
    //   str += groceries[i] + ", ";
    // }

    return InkWell(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
        child: Container(
          decoration: BoxDecoration(
            color: FintnessAppTheme.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topRight: Radius.circular(68.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: FintnessAppTheme.grey.withOpacity(0.2),
                  offset: Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Row(
                  children: <Widget>[],
                ),
              ),
              Text(
                "Name: " + name,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                    fontFamily: 'Lobster',),
              ),
              Text("Final Destination: " + finalDestination,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 17.0,
                      
                      color: Colors.blue,
                      fontFamily: 'Lobster')),
              Text("Grocery Store: " + groceryStore,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                      fontFamily: 'Lobster')),
              Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 8, bottom: 8),
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: FintnessAppTheme.background,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                ),
              ),
              Text(
                groceries,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Lobster'),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 8, bottom: 16),
                child: Row(
                  children: <Widget>[],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Task mainTask = Task(name, finalDestination, groceryStore, groceries);
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => GoHere(mainTask)));
      },
    );
  }
}
