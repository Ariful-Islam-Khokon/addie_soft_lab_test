import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreenInitial extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenInitial> {
  startTime() async {
    var _duration = new Duration(seconds: 5); //replace with 2
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Container(
        //padding: EdgeInsets.all(15.0),
        padding: EdgeInsets.only(top: 25.0, right: 10.0, bottom: 0.0, left: 10.0),
        child: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              SizedBox(
                height: 120,
              ),
/*              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  'assets/images/isurvey_logo.png',
                  height: 100.0,
                  fit: BoxFit.fill,
                ),
              ),*/
              Text(
                'Lab Test',
                style: TextStyle(
                  fontSize: 40,
                  color: Color(0xffb171D43),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Save and load Data using firebase',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Image.asset(
                  'assets/images/adisoftLogo.png',
                  height: 300,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                //child: Text('CTrends Software & Services Ltd.'),
                child: Text('ADDIE Soft Ltd.'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  'House-660 (2th Floor), Road-32, Dhaka 1209',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
