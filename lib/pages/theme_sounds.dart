import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:popdot/database/firebase_tools.dart';
import 'package:popdot/pages/sound_form.dart';

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
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                scrollDirection: Axis.vertical,
                itemCount: (!snapshot.hasData) ? 1 : snapshot.data!.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
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
                            Positioned.fill(
                              child: Material(
                                child: InkWell(
                                  onTap: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (BuildContext cxt) {
                                        return AlertDialog(
                                          content: SoundForm(
                                            themeName: widget.title,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  10, 0, 10, 0),
                                          backgroundColor: AppColors.white,
                                        );
                                      },
                                    );
                                    setState(() {

                                    });
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
                    );
                  } else {
                    Sound sound = (snapshot.data?[index - 1] as Sound);

                    return buildThemeCard(sound.name, sound.image);
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  SizedBox buildThemeCard(title, backgroundImage) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    titleController.text = title;

    var newImage = backgroundImage;
    var currentTitle = title;
    var newTitle = title;

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
            FutureBuilder<String>(
              future: getImageURL(backgroundImage),
              builder: (context, snapshot) {
                Widget child;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  child = const CircularProgressIndicator(
                    key: ValueKey(0),
                  );
                } else {
                  child = Ink.image(
                    key: const ValueKey(1),
                    // image: Image.asset('assets/images/' + backgroundImage).image,
                    image: NetworkImage(snapshot.data as String),
                    colorFilter: const ColorFilter.mode(
                        AppColors.darkMole, BlendMode.color),
                    fit: BoxFit.cover,
                    child: InkWell(
                      onLongPress: () {
                        showBottomSheet(
                          context: context,
                          builder: (context) {
                            return Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 32.0, bottom: 32.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          height: 200,
                                          child: Card(
                                            clipBehavior: Clip.antiAlias,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                            ),
                                            child: Stack(
                                              children: [
                                                Ink.image(
                                                  image: NetworkImage(
                                                      snapshot.data as String),
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                          AppColors.darkMole,
                                                          BlendMode.color),
                                                  fit: BoxFit.cover,
                                                  child: InkWell(
                                                    onTap: () async {
                                                      var picked =
                                                          await ImagePicker()
                                                              .pickImage(
                                                                  source:
                                                                      ImageSource
                                                                          .camera);

                                                      uploadFile(
                                                          'upload_test.jpg',
                                                          'images',
                                                          await picked
                                                              ?.readAsBytes());
                                                    },
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.all(16.0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: Icon(
                                                      Icons.edit_outlined,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 64.0,
                                              right: 64.0,
                                              top: 16.0),
                                          child: TextField(
                                            onChanged: (value) {
                                              newTitle = value;
                                            },
                                            controller: titleController,
                                            decoration: const InputDecoration(
                                              labelText: 'Title',
                                              suffixIcon:
                                                  Icon(Icons.edit_outlined),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Card(
                                                elevation: 2,
                                                clipBehavior: Clip.antiAlias,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(90),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Positioned.fill(
                                                      child: Material(
                                                        color: Colors.red,
                                                        child: InkWell(
                                                          onTap: () {
                                                            updateTheme(
                                                                title,
                                                                titleController
                                                                    .text,
                                                                descriptionController
                                                                    .text,
                                                                newImage,
                                                                []);
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Icon(
                                                        Icons.delete_outlined,
                                                        color: Colors.white,
                                                        size: 25.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Card(
                                                elevation: 2,
                                                clipBehavior: Clip.antiAlias,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(90),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Positioned.fill(
                                                      child: Material(
                                                        color: Colors.blue,
                                                        child: InkWell(
                                                          onTap: () => {
                                                            updateTheme(
                                                                title,
                                                                titleController
                                                                    .text,
                                                                descriptionController
                                                                    .text,
                                                                newImage,
                                                                [])
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Icon(
                                                        Icons.done,
                                                        color: Colors.white,
                                                        size: 25.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      onTap: () {
                        _playAudio(title);
                      },
                    ),
                  );
                }

                return AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  child: child,
                );
              },
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
