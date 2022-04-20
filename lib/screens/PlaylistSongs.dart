import 'package:flutter/material.dart';
import 'package:musico_scratch/custom/ListSongs.dart';
import 'package:musico_scratch/custom/editPlaylist.dart';
import 'package:musico_scratch/custom/songSheet.dart';
import 'package:musico_scratch/database/dbSongs.dart';

class PlaylistSongs extends StatefulWidget {

  List playlists;
  final int index;
  PlaylistSongs({
    Key? key,
    required this.playlists,
    required this.index,
  }) : super(key: key);

  @override
  State<PlaylistSongs> createState() => _PlaylistSongsState();
}

class _PlaylistSongsState extends State<PlaylistSongs> {
  final box = MusicBox.getInstance();

  // final int index;
  // _PlaylistSongsState({required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_rounded),
              color: Colors.white,
            ),
            Text(
              '${widget.playlists[widget.index]}',
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
                        return songSheet(
                          playlistName: widget.playlists[widget.index],
                        );
                      });
                }

                if (value == 1) {
                  showDialog(
                    context: context,
                    builder: (context) => editPlaylist(
                      playlistName: widget.playlists[widget.index],
                    ),
                  );
                  // editPlaylist(
                  //   playlistName: widget.playlists[widget.index],
                  // );
                  setState(() {});
                }

                if (value == 2) {
                  box.delete(widget.playlists[widget.index]);
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



///
// ///
//   List<dbSongs> databaseSongs = [];
//   List<dbSongs> playlistSongs = [];

//   @override
//   void initState() {
//     super.initState();
//     fullSongs();
//   }

//   fullSongs() {
//     databaseSongs = box.get("musics") as List<dbSongs>;
//     playlistSongs = box.get(widget.playlists)!.cast<dbSongs>();
//   }
///