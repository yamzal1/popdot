import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../database/hive_tools.dart';
import '../theme/appcolors.dart';
import 'package:popdot/main.dart';

Widget listeSons(List<Sound> sons) {
  if (sons.isEmpty) {
    return const Center(
      child: Text(
        'Pas d\'offre pour l\'instant',
        style: TextStyle(fontSize: 24),
      ),
    );
  } else {
    return Column(
      children: [
        const SizedBox(height: 24),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: sons.length,
            itemBuilder: (BuildContext context, int index) {
               final transaction = sons[index];

                return buildSon(context, transaction);
              },

          ),
        ),
      ],
    );
  }
}



 //new widget

Widget buildSon(BuildContext context, Sound son,) {
  final name = son.name;
  final icon = son.icon;

  return Card(
    color: Colors.white,
    child: ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      title: Text(
        name,
        maxLines: 2,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),

      trailing: Text(icon),
      children: [
       //TODO buildButtons(context, job), (boutons suppression/modif)
      ],
    ),
  );
}
