import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  TextEditingController country=TextEditingController();
  TextEditingController state=TextEditingController();
  TextEditingController city=TextEditingController();

  List<String> list = ["kdkdk","ffff","ffjjffj","kdkdk","ffff","ffjjffj","kdkdk","ffff","ffjjffj"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country->State->City'),
      ),
      body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Wrap(
            direction: Axis.horizontal,
            children: [
              for (var items in list)
                  Text("$items ", style: TextStyle(fontSize: 50),)
            ],
          )
      ),
    );
  }
}