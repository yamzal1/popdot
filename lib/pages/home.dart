import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.white,
          title: SizedBox(
            height: 80,
            child: Image.asset('assets/images/logo.png'),
          ),
          toolbarHeight: 80,
        ),
        backgroundColor: AppColors.white,
        body: SizedBox(
          height: double.infinity,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              buildThemeRow('Your themes', ['0.jpg', '1.jpg', '2.jpg', '3.jpg', '4.jpg', '5.jpg']),
              buildThemeRow('Recent', ['6.jpg', '7.jpg', '8.jpg', '9.jpg', '10.jpg', '11.jpg']),
              buildThemeRow('Made for you', ['12.jpg', '13.jpg', '14.jpg', '15.jpg', '16.jpg', '17.jpg']),
            ],
          ),
        ),
      ),
    );
  }

  Column buildThemeRow(title, images) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 32.0, bottom: 16.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 25),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              buildThemeCard('Spain', images[0]),
              buildThemeCard('France', images[1]),
              buildThemeCard('Go to heck purple', images[2]),
              buildThemeCard('Spain', images[3]),
              buildThemeCard('France', images[4]),
              buildThemeCard('Go to heck purple', images[5]),
            ],
          ),
        ),
      ],
    );
  }

  Container buildThemeCard(title, backgroundImage) {
    return Container(
      margin: EdgeInsets.only(left: 8.0),
      width: 150,
      height: 150,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Ink.image(
              image: Image.asset('assets/images/' + backgroundImage).image,
              colorFilter:
                  const ColorFilter.mode(AppColors.darkMole, BlendMode.color),
              fit: BoxFit.cover,
              child: InkWell(
                onTap: () {},
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
