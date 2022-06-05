import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:popdot/database/firebase_tools.dart';

import '../database/hive_tools.dart';
import '../theme/app_colors.dart';

class Details extends StatefulWidget {
  const Details({Key? key, required this.title, required this.isBaseTheme})
      : super(key: key);

  final String title;
  final bool isBaseTheme;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late Box<JukeboxTheme> themeBox;

  @override
  void initState() {
    super.initState();

    if (widget.isBaseTheme) {
      themeBox = Hive.box<JukeboxTheme>('base_themes');
    } else {
      themeBox = Hive.box<JukeboxTheme>('themes');
    }
  }

  _playAudio(soundName) async {
    AudioPlayer player;

    listFiles(themeBox.values
            .toList()
            .where((element) => element.title == widget.title)
            .first
            .sounds
            .toList()
            .where((element) => element.name == soundName)
            .first
            .fullpath)
        .then((filePath) {
      getDownloadURL(filePath).then((downloadURL) async {
        player = AudioPlayer();
        await player.setUrl(downloadURL);
        player.play();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        title: Center(
          child: SizedBox(
            height: 80,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
        ),
        toolbarHeight: 80,
      ),
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: FutureBuilder<List>(
            future: getSounds(widget.title, widget.isBaseTheme),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    Sound sound = (snapshot.data?[index] as Sound);

                    return buildThemeCard(sound.name, sound.icon);
                  },
                );
              } else {
                return ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 8.0),
                      width: 150,
                      height: 150,
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Material(
                                child: InkWell(
                                  onTap: () {
                                    print('');
                                  },
                                ),
                              ),
                            ),
                            const Align(
                              child: Icon(
                                Icons.add,
                                size: 50.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  SizedBox buildThemeCard(title, backgroundImage) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            // Ink.image(
            //   image: Image.asset('assets/images/' + backgroundImage).image,
            //   colorFilter:
            //       const ColorFilter.mode(AppColors.darkMole, BlendMode.color),
            //   fit: BoxFit.cover,
            // ),
            Positioned.fill(
              child: Material(
                child: InkWell(
                  onTap: () {
                    _playAudio(title);
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Icon(
                IconData(int.parse(backgroundImage),
                    fontFamily: 'MaterialIcons'),
                size: 40.0,
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
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
