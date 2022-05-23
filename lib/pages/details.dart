import 'package:flutter/material.dart';

import '../theme/appcolors.dart';

class Details extends StatelessWidget {
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.white,
      ),
      home: Scaffold(
        backgroundColor: AppColors.white,
        body: Center(
            child: Column(
          children: [
            Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: 400,
                        height: 400,
                        child: Image.asset('assets/images/img_cover_test.png')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Titre du thème",
                    style: TextStyle(
                      fontSize: 40,
                      color: AppColors.darkGrey,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text("Liste des sons : "),
            ),
          ],
        )),
      ),
    );
  }
}
