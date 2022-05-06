import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future getData() async {
    var url = Uri.parse("http://10.0.2.2:5000/api");
    final response = await http.get(url);
    return jsonDecode(response.body) as Map;
  }

  int predictedDataLenght = 0;
  dynamic Data;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Prediction"),
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.all(15),
          width: double.infinity,
          height: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text(
              "Predicted Data",
              textAlign: TextAlign.center,
            ),
            if (predictedDataLenght != 0)
              Flexible(
                child: ListView.builder(
                    itemCount: predictedDataLenght,
                    itemBuilder: (ctx, index) {
                      return Container(
                        width: 100,
                        height: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Date",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            SizedBox(height: 5),
                            Text("2022-04-${28 + index}"),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Open",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text((Data["Query"][index][0]).toString()),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Hight",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text((Data["Query"][index][1]).toString()),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Low",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text((Data["Query"][index][2]).toString()),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Close",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text((Data["Query"][index][3]).toString()),
                            Divider(
                              height: 15,
                              color: Colors.black,
                            )
                          ],
                        ),
                      );
                    }),
              ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () async {
                Data = await getData();
                print(Data["Query"][1]);
                setState(() {
                  predictedDataLenght = Data["Query"].length;
                });
                print(predictedDataLenght);
              },
              child: Text("Predict"),
            )
          ]),
        ),
      ),
    );
  }
}
