import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musico_scratch/custom/createPlaylistDialogue.dart';
import 'package:musico_scratch/custom/editPlaylist.dart';
import 'package:musico_scratch/custom/listFavouriteSongs.dart';
import 'package:musico_scratch/custom/listOfPlaylist.dart';
import 'package:musico_scratch/database/dbSongs.dart';
import 'package:musico_scratch/screens/PlaylistSongs.dart';
import 'package:musico_scratch/screens/ScreenFolders.dart';
import 'package:musico_scratch/Home/HomeSongs.dart';

class ScreenPlaylists extends StatefulWidget {
  ScreenPlaylists({Key? key}) : super(key: key);

  @override
  State<ScreenPlaylists> createState() => _ScreenPlaylistsState();
}

class _ScreenPlaylistsState extends State<ScreenPlaylists> {
  // final box = MusicBox.getInstance();
  // final box1 = MusicBox1.getInstance();
  final box = MusicBox.getInstance();

  List playlists = [];
  String? playlistName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height:   MediaQuery.of(context).size.height * 1,
        child: Stack(
          children: [
            Positioned(
          bottom: 90,
          right: 20,
          child: Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
                color: Colors.grey[700]),
            child: IconButton(
              icon: Icon(Icons.add),
              color: Colors.white,
              onPressed: () => showDialog(
                context: context,
                builder: (context) => createPlaylistDialogue(),
              ),
            ),
          ),
        ),
            SingleChildScrollView(
              child: Wrap(
                children: [
                  Container(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => listFavouriteSongs()),
                            ),
                          ),
                          child: listofPlaylists(
                            leadingIcon: Icon(
                              Icons.favorite,
                              color: Colors.white,
                            ),
                            leadingColor: Color(0xffdb5960),
                            title: 'Favourites',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // print(
                            //     '=====================${box.get('favourites')}======================');
                          },
                          child: listofPlaylists(
                            leadingIcon: Icon(Icons.watch_later),
                            leadingColor: Color(0xffba9e84),
                            title: 'Recently Played',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: box.listenable(),
                      // valueListenable: box1.listenable(),

                      builder: (context, boxes, _) {
                        playlists = box.keys.toList();
                        // playlists = box1.keys.toList();

                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: playlists.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) => PlaylistSongs(
                                            Name: playlists[index],
                                            playlists: playlists)),
                                      ),
                                    ),
                                child: playlists[index] != "musics" &&
                                        playlists[index] != "favourites"
                                    // &&playlists[index] != "artists"

                                    ? listofPlaylists(
                                        title: playlists[index].toString(),
                                        trailingWidget: PopupMenuButton(
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                              value: 1,
                                              child: Text(
                                                'Rename',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            PopupMenuItem(
                                              value: 2,
                                              child: Text(
                                                'Delete',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                          onSelected: (value) {
                                            if (value == 1) {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    editPlaylist(
                                                  playlistName: playlists[index],
                                                ),
                                              );
                                              editPlaylist(
                                                playlistName: playlists[index],
                                              );
                                            }

                                            if (value == 2) {
                                              box.delete(playlists[index]);
                                              // box1.delete(playlists[index]);

                                              setState(() {
                                                // playlists = box1.keys.toList();
                                                playlists = box.keys.toList();
                                              });
                                            }
                                          },
                                          icon: Icon(
                                            Icons.more_vert,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : Container());
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            // Positioned(
            //   right: 10,
            //   bottom: 60,
            //   child: FloatingActionButton(
            //     // show dialogue box

            //     onPressed: () => showDialog(
            //       context: context,
            //       builder: (context) => createPlaylistDialogue(),
            //     ),
            //     child: Icon(Icons.add),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}