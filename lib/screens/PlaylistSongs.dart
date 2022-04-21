import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:musico_scratch/custom/songSheet.dart';
import 'package:musico_scratch/database/dbSongs.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../custom/editPlaylist.dart';
import '../screens/ScreenSongHome.dart';

// showModalBottomSheet(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(21)),
//                       backgroundColor: Color.fromARGB(255, 48, 48, 48),
//                       context: context,
//                       builder: (context) {
//                         return ListView.builder(
//                           itemCount: databaseSongs.length,
//                           itemBuilder: (context, index1) {
//                             return

//                           },
//                         );
//                       });

// final box = MusicBox.getInstance();
List<dbSongs> SongsList = []; //get from the database
List<dbSongs> playlistSongs = [];

ValueNotifier<List<dbSongs>> playli = ValueNotifier(playlistSongs);

class PlaylistSongs extends StatefulWidget {
  List? playlists;
  final String? playListName;
  final int? songIndex;
  PlaylistSongs({
    Key? key,
    this.playlists,
    this.playListName,
    this.songIndex,
  }) : super(key: key);

  @override
  State<PlaylistSongs> createState() => _PlaylistSongsState();
}

class _PlaylistSongsState extends State<PlaylistSongs> {
  // late String _now;
  // late Timer _everySecond;
  final box = MusicBox.getInstance();
  final box1 = MusicBox1.getInstance();

  @override
  void initState() {
    super.initState();
    // _now = DateTime.now().hour.toString();
    // _everySecond = Timer.periodic(Duration(hours: 1), (Timer t) {
    //   setState(() {
    //     _now = DateTime.now().hour.toString();
    //   });
    // });
    fullSongs();
  }

  fullSongs() {
    SongsList = box.get("musics") as List<dbSongs>;
    playlistSongs = box1.get(widget.playListName)!.cast<dbSongs>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back_rounded),
                  color: Colors.white,
                ),
                Text(
                  // '${widget.playlists[widget.index]}',
                  "${widget.playListName}",

                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 0,
                      child: Text(
                        'Add songs',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      value: 1,
                      child: Text(
                        'Rename',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 0) {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(21)),
                          backgroundColor: Color.fromARGB(255, 48, 48, 48),
                          context: context,
                          builder: (context) {
                            return BottomSheetWidget(
                              playListName: widget.playListName,
                            );
                          });
                    }

                    if (value == 1) {
                      showDialog(
                        context: context,
                        builder: (context) => editPlaylist(
                          playlistName: widget.playListName.toString(),
                        ),
                      );

                      // editPlaylist(
                      //   playlistName: widget.playlists[widget.index],
                      // );
                      setState(() {});
                    }

                    if (value == 2) {
                      box.delete(widget.playListName);
                      setState(() {
                        widget.playlists = box.keys.toList();
                        Navigator.pop(context);
                      });
                    }
                  },
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            //body

            // Text(playlistSongs[3].title.toString())
            Expanded(
                child: ListView.builder(
                    itemCount: playlistSongs.length,
                    itemBuilder: (context, index) => ListTile(
                          title: Text(playlistSongs[index].title.toString()),
                        )))
          ],
        ),
      ),
    );
  }

  void showBottomsheetPlaylist(context) {
    showBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (contex) {
          return Container(
            height: 40,
            color: Colors.white,
          );
        });
  }
}
