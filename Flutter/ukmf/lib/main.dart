import 'package:flutter/material.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome'),
          backgroundColor: Color(0xFFAFCA09),
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
              child: RaisedButton(
                onPressed: () {},
                child: Text('Add'),
                color: Color(0xFFAFCA09),
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[
                  Image.asset('assets/Pizza.jpg'),
                  Text('Pizza')
                ],
              ),
            )
          ],
        ),
        drawer: const Drawer(),
      ),
    );
  }
}
