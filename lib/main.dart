import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:async';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  String title = "Title";
  String helper = "helper";
  String userdata = "userdata";
String token = "";
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
gettoken() async{
    
      await _firebaseMessaging.getToken().then((_token){
    setState(() {
      //token = _token;
    token= _token.toString();
    });
  });
    
    
    
     print("-----> $token");
    //return useremail.toString();
    
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettoken();
    _firebaseMessaging.configure(
      onMessage: (message) async{
        setState(() {
          title = message["notification"]["title"];
          helper = message["notification"]["body"];
           userdata = message["data"]["key1"];
          print(helper.toString());
        });

      },
      onResume: (message) async{
        setState(() {
          title = message["notification"]["title"];
          helper = message["notification"]["body"];
          userdata = message["data"]["key1"];
        });

      },

    );

   
  }



  void _incrementCounter() {
    setState(() {
      
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
         
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('$helper'),
            Text(
              '$title',
              style: Theme.of(context).textTheme.display1,
            ),
            Text(
              '$userdata',
              style: Theme.of(context).textTheme.display1,
            ),
            Text(
              '$token',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
