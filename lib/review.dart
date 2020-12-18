import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:reviews/model/person.dart';
import 'dart:convert';
import 'dart:math';

final indexProvider = StateNotifierProvider((_) => Index());

class Index extends StateNotifier<int> {
  Index() : super(0);

  int checkIndex(int maxNum, int number) {
    if (number >= maxNum) return 0;
    if (number < 0) return maxNum - 1;
    return number;
  }

  void decrement(int maxNum) => {state = (checkIndex(maxNum, state - 1))};

  void increment(int maxNum) => {state = (checkIndex(maxNum, state + 1))};

  void random(int maxNum) {
    final int randomNumber = (new Random().nextInt(maxNum)).floor();
    if (randomNumber == state) {
      state = checkIndex(maxNum, state + 1);
    }
    state = checkIndex(maxNum, randomNumber);
  }
}

class Review extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final state = useProvider(indexProvider.state);
    final index = useProvider(indexProvider);

    return FutureBuilder(
        future:
            DefaultAssetBundle.of(context).loadString('assets/data/data.json'),
        builder: (context, snapshot) {
          final persedJson = json.decode(snapshot.data);
          final List<Person> people = persedJson
              .map((json) => Person.fromJson(json))
              .toList()
              .cast<Person>();
          final person = people[state];
          final maxNum = people.length;
          return Card(
              color: Colors.white,
              child: Center(
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Positioned(
                              bottom: 30,
                              left: 5,
                              child: CircleAvatar(
                                backgroundColor: Colors.lightBlue,
                                radius: 60,
                              ),
                            ),
                            CircleAvatar(
                              backgroundImage: NetworkImage(person.image),
                              radius: 60,
                            ),
                            Align(
                              widthFactor: 5,
                              heightFactor: 5,
                              alignment: Alignment.topLeft,
                              child: CircleAvatar(
                                child: Icon(
                                  Icons.format_quote_sharp,
                                  color: Colors.white,
                                ),
                                backgroundColor: Colors.lightBlue,
                                radius: 15,
                              ),
                            )
                          ],
                        ),
                        Text(person.name,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        Text(person.job,
                            style: TextStyle(
                                fontSize: 24, color: Colors.lightBlue[200])),
                        Text(person.text,
                            style: TextStyle(color: Colors.blueGrey)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.keyboard_arrow_left),
                              onPressed: () => index.decrement(maxNum),
                              color: Colors.lightBlue,
                            ),
                            IconButton(
                              icon: Icon(Icons.keyboard_arrow_right),
                              onPressed: () => index.increment(maxNum),
                              color: Colors.lightBlue,
                            ),
                          ],
                        ),
                        FlatButton(
                          child: Text('Suprise Me',
                              style: TextStyle(color: Colors.lightBlue)),
                          color: Colors.lightBlue[100],
                          onPressed: () => index.random(maxNum),
                        ),
                      ],
                    )),
              ));
        });
  }
}
