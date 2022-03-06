import 'dart:io';

import 'package:feeling/models/utilisateurs.dart';
import 'package:flutter/material.dart';

class RippleAnimation extends StatefulWidget {
  const RippleAnimation({ Key? key }) : super(key: key);

  @override
  _RippleAnimationState createState() => _RippleAnimationState();
}

class _RippleAnimationState extends State<RippleAnimation> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  List<Utilisateurs> currentUser = [];
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {

    if(currentUser.isNotEmpty){
      return AnimatedBuilder(
        animation: CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              // _buildContainer(100 * _controller.value),
              _buildContainer(300 * _controller.value),
              _buildContainer(500 * _controller.value),
              _buildContainer(700 * _controller.value),
              Align(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width*0.5,
                  child: CircleAvatar(
                   backgroundImage: FileImage(File(currentUser[0].photo[0])),
                   radius: 100,                   
                 )
                 
                )
              ),
            ],
          );
        },
      );
    }else{
      return AnimatedBuilder(
        animation: CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _buildContainer(100 * _controller.value),
              _buildContainer(300 * _controller.value),
              _buildContainer(500 * _controller.value),
              _buildContainer(700 * _controller.value),
              const Align(
                child: CircleAvatar(
                 backgroundImage: AssetImage('images/logo.png'),
                 maxRadius: 100,
                )
              ),
            ],
          );
        },
      );
    }

  }

  Widget _buildContainer(double radius) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).primaryColor.withOpacity(1 - _controller.value),
      ),
    );
  }

  void getCurrentUser() async {
    await Utilisateurs.getCurrentUser().then((value){
      
      setState(() {
        currentUser.add(value);
      });

    });
  }

}


