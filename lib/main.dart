import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  List _data = await getJson();
  for (int i = 0; i < _data.length; i++) {
    print('${_data[0]['title']}');
  }

  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.orangeAccent,
          title: new Text('Json Parser'),
          centerTitle: true,
        ),
        body: new Center(
          child: new ListView.builder(
              itemCount: _data.length,
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (BuildContext context, int position) {
                if (position.isOdd)
                  return new Divider(
                    color: Colors.grey,
                  );
                final index = position ~/ 2;
                return new ListTile(
                  title: new Text(
                    "${_data[index]['title']}",
                    style: new TextStyle(fontSize: 14.9),
                  ),
                  subtitle: new Text('${_data[index]['body']}',
                    style: new TextStyle(fontSize: 13.4,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic),),
                  leading: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: new Text(
                      '${_data[index]['title'][0].toString().toUpperCase() }',
                      style: new TextStyle(fontSize: 19.4, color: Colors.white),
                    ),
                  ),
                  onTap: () =>
                      _showOnTapMessage(context, "${_data[index]['title']}"),
                );
              }),
        )),
  ));
}

void _showOnTapMessage(BuildContext context, String message) {
  var alert = new AlertDialog(
    title: new Text('App'),
    content: new Text(message),
    actions: <Widget>[new FlatButton(onPressed: () {
      Navigator.pop(context);
    }, child: new Text('OK'))
    ],
  );
  showDialog(context: context, child: alert);
}

Future<List> getJson() async {
  String apiUrl = 'https://jsonplaceholder.typicode.com/posts';
  http.Response response = await http.get(apiUrl);
  return jsonDecode(response.body);
}
