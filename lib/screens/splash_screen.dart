import 'package:black_stories/routes/app_routes.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  //Your animation controller
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    //Implement animation here
    _animation = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, AppRoute.COLLECTION);
      },
      child: Container(
        color: Colors.amber,
        child: Center(
            child: Hero(
              tag: "heroLogo",
              //FadeTransition makes your image Fade
              child: FadeTransition(
                //Use your animation here
                opacity: _animation,
                child: CircleAvatar(
                  //Here you load you image
                  backgroundImage: AssetImage("assets/icons/splash.png"),
                  radius: MediaQuery.of(context).size.width * 0.25,
                ),
              ),
            )
        ),
      ),
    );
  }
}