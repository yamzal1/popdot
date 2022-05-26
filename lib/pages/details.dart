import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../database/hive_tools.dart';
import '../theme/appcolors.dart';
import 'package:popdot/main.dart';

import '../widgets/liste_sons.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

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
            Column(
              children: [
                const SizedBox(height: 24),
                Expanded(
                  child: ValueListenableBuilder<Box<Sound>>(
                    // valueListenable: Sound.getS().listenable(),
                    valueListenable: Hive.box<Sound>('SoundBox').listenable(),
                    builder: (context, sons, _) {


                      final transactions = sons.values.toList().cast<Sound>();

                      return listeSons(transactions);
                    },
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
