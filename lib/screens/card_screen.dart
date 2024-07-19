import 'package:black_stories/models/collection.dart';
import 'package:black_stories/screens/sides/back_side.dart';
import 'package:black_stories/screens/sides/fore_side.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flip_card/flip_card.dart';

import '../constants/colors.dart';

class CardScreen extends StatefulWidget {
  // const MainMenu({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  void initState() {
    super.initState();
  }

  Collection collection = Get.arguments['collection'];

  _renderBg() {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFF000000)),
    );
  }

  _renderAppBar(context) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: AppBar(
        elevation: 0.0,
        backgroundColor: AppColor.whiteColor,
      ),
    );
  }

  _renderContent(context) {
    return Card(
      elevation: 0.0,
      margin: EdgeInsets.only(left: 32.0, right: 32.0, top: 5.0, bottom: 5.0),
      color: Color(0x00000000),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        side: CardSide.FRONT,
        speed: 1000,
        onFlipDone: (status) {
          print(status);
        },
        // Frond side of Card
        front: Container(
          decoration: cardDecoration,
          child: ForeSide(),
        ),
        // Back side of Card
        back: Container(
          decoration: cardDecoration,
          child: BackSide(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Black Stories ${collection}',
          style: TextStyle(fontFamily: 'Insomnia'),),
        backgroundColor: AppColor.darkBloodColor,
      ),
      body: Stack(

        fit: StackFit.expand,
        children: <Widget>[
          _renderBg(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _renderAppBar(context),
              Expanded(
                flex: 4,
                child: _renderContent(context),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.home)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.restaurant_menu)),
                    Container(width: MediaQuery.of(context).size.width*.20,),
                    IconButton(onPressed: (){}, icon: Icon(Icons.bookmark)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.notifications)),
                  ],
                ),
              ),

            ],


          )
        ],
      ),
    );
  }

  final BoxDecoration cardDecoration = BoxDecoration(
    color: Color(0xFFFFFFFF),
    borderRadius: BorderRadius.all(Radius.circular(16.0)),
    boxShadow: [ BoxShadow(
      color: Colors.grey.withOpacity(0.6),
      spreadRadius: 3,
      blurRadius: 7,
      offset: Offset(7, 7),
    ),],
  );


}