import 'package:flutter/material.dart';
import 'package:popdot/theme/app_colors.dart';

class NoSound extends StatefulWidget {
  const NoSound({Key? key}) : super(key: key);

  @override
  _NoSoundState createState() => _NoSoundState();
}

class _NoSoundState extends State<NoSound> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      reverseDuration: const Duration(seconds: 3),
      vsync: this,
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            _controller.reverse();
          } else if (status == AnimationStatus.dismissed) {
            _controller.forward();
          }
        },
      );
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      //backgroundColor: Theme.of(context).primaryColor,
      backgroundColor: AppColors.darkGrey,
      body: Stack(
        children: [
          Positioned(
            bottom: _height / 8,
            //Position y du faisceau (Plus grande valeur = plus bas)
            right: _height / -1.55,
            //Position x du faisceau (plus basse valeur = plus a droite)
            child: AnimatedBuilder(
              animation: _controller,
              child: Image.asset(
                'images/light.png',
                width: _height * 1.5,
                height: _height * 1.1, //Hauteur du faisceau
              ),
              builder: (BuildContext context, _widget) {
                return Transform.rotate(
                  angle: -_controller.value,
                  alignment: Alignment.bottomCenter,
                  child: _widget,
                );
              },
            ),
          ),
          Positioned(
            bottom: _height / 120,
            right: _height / 80,
            child: Image.asset(
              'images/illustration.png',
              // 'images/lamp.png',
              width: _height / 8, //Taille du bonhomme
            ),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: _height / 50,
                ),
                Text(
                  'Oups',
                  style: TextStyle(
                    fontSize: _height / 15,
                    fontWeight: FontWeight.bold,
                    // color: Theme.of(context).primaryColor,
                    color: AppColors.darkGrey,
                  ),
                ),
                Text(
                  'Ce thème \nest vide !',
                  style: TextStyle(
                    fontSize: _height / 28,
                    fontWeight: FontWeight.bold,
                    // color: Theme.of(context).primaryColor,
                    color: AppColors.darkGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
