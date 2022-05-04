// ignore_for_file: must_be_immutable

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:musico_scratch/database/dbSongs.dart';
import 'package:musico_scratch/moved/addToPlaylist.dart';

class MusicListMenu extends StatefulWidget {
  final String songId;
  final int index;
  MusicListMenu({Key? key, required this.songId, required this.index})
      : super(key: key);

  @override
  State<MusicListMenu> createState() => _MusicListMenuState();
}

class _MusicListMenuState extends State<MusicListMenu> {
  final box = MusicBox.getInstance();

  final box1 = MusicBox1.getInstance();

  List<dbSongs> databaseSongs = [];

  List<Audio> fullSongs = [];

  @override
  Widget build(BuildContext context) {
    databaseSongs = box.get("musics") as List<dbSongs>;
    final temp = databaseSongsFunction(databaseSongs,
        widget.songId); //returs the database song that mathces the songid
    List? favourites = box.get("favourites");

    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert_rounded,
        color: Colors.white,
      ),
      itemBuilder: (BuildContext bc) => [
        favourites!
                .where((element) => element.id.toString() == temp.id.toString())
                .isEmpty
            ? PopupMenuItem(
                onTap: () async {
                  favourites.add(temp);
                  await box.put("favourites", favourites);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        temp.title! + " Added to Favourites",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    
                  );setState(() {
                  });
                },
                child: const Text(
                  "Add to Favourite",
                  style: TextStyle(color: Colors.black),
                ),
              )
            : PopupMenuItem(
                onTap: () async {
                  favourites.removeWhere(
                      (element) => element.id.toString() == temp.id.toString());
                  await box.put("favourites", favourites);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        temp.title! + " Removed from Favourites",
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Remove From Favourite",
                  style: TextStyle(color: Colors.black),
                ),
              ),

       
        const PopupMenuItem(
          child: Text(
            "Add to Playlist",
            style: TextStyle(color: Colors.black),
          ),
          value: "1",
        ),
      ],
      onSelected: (value) async {
        if (value == "1") {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddtoPlayList(song: temp),
          );
        }
      },
    );
  }

  dbSongs databaseSongsFunction(List<dbSongs> songs, String id) {
    return songs.firstWhere(
      (element) => element.id.toString().contains(id),
    );
  }
}
