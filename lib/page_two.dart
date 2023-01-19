import 'package:flashcabs/icons.dart';
import 'package:flutter/material.dart';

void main()
{
  runApp(MaterialApp(home: PageTwo()));
}

class PageTwo extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FlashCabs'),),
      body: Container(
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Destination',
                prefixIcon: Icon( Icons.pin_drop, ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () {  },
                  icon: Icon(MyFlutterApp.motorcycle),
                  label: Text(''),
                ),
                ElevatedButton.icon(
                  onPressed: () {  },
                  icon: Icon(MyFlutterApp.rikshaw),
                  label: Text(''),
                ),
                ElevatedButton.icon(
                  onPressed: () {  },
                  icon: Icon(MyFlutterApp.sedan),
                  label: Text(''),
                ),
                ElevatedButton.icon(
                  onPressed: () {  },
                  icon: Icon(MyFlutterApp.suv),
                  label: Text(''),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(label: 'OLA', icon: Icon(MyFlutterApp.ola_icon),),
          BottomNavigationBarItem(icon: Icon(MyFlutterApp.uber), label:'UBER'),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label:'RAPIDO'),
        ],
      ),
    );
  }
}