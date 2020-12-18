import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:reviews/review.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Review',
      home: Scaffold(
        appBar: AppBar(title: Text('Review')),
        body: Container(
          color: Colors.blueGrey[50],
          child: Center(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            child: Column(
              children: <Widget>[
                Text(
                  'Our Reviews',
                  style: TextStyle(
                      fontSize: 40,
                      decoration: TextDecoration.underline,
                      decorationThickness: 2.85,
                      decorationColor: Colors.lightBlue),
                ),
                SizedBox(height: 30),
                Review()
              ],
            ),
          )),
        ),
      ),
    );
  }
}
