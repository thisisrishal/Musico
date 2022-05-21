// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:musico_scratch/presentation/playlists/widgets/createPlaylist.dart';
import 'package:musico_scratch/database/dbSongs.dart';

class AddtoPlayList extends StatelessWidget {
  dbSongs song;
  List playlists = [];
  List<dynamic>? playlistSongs = [];

  AddtoPlayList({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = MusicBox.getInstance();
    // final box1 = MusicBox1.getInstance();

    // final box1 = MusicBox1.getInstance();
    playlists = box.keys.toList();
    // print('-------------------${song.artist}----------------------');
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
            child: ListTile(
              onTap: () => showDialog(
                context: context,
                builder: (context) => CreatePlaylist(),
              ),
              leading: const Icon(
                FontAwesomeIcons.plus,
                color: Colors.white,
              ),
              title: const Text(
                "Add a New Playlist",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          //?list playlists

          ...playlists // playlists = box.keys.toList();
              .map(
                (per_playlistName) => per_playlistName != "musics" &&
                        per_playlistName != 'favourites'
                    ? ListTile(
                        onTap: () async {
                          playlistSongs = box.get(
                              per_playlistName); // playlistsongs =  per_playlistName values(ie: all song of the playlist)

                          List existingSongs = [];

                          existingSongs =
                              playlistSongs! // existingSongs = got all the audio from  'playlistSong' it is the same id as the 'song' we passed to this page
                                  .where((element) =>
                                      element.id.toString() ==
                                      song.id.toString())
                                  .toList();

                          if (existingSongs.isEmpty) {
                            
                            final songs = box.get("musics")
                                as List<dbSongs>; // got all song in database

                            final temp = songs.firstWhere(
                                (element) => //got the id of database song id that same as passed song
                                    element.id.toString() ==
                                    song.id.toString());
                            playlistSongs?.add(
                                temp); // add the passed song into the playlist

                            await box.put(per_playlistName,
                                playlistSongs!); // upadted the box

                            Navigator.of(context).pop();

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                song.title! + ' Added to Playlist',
                                style: const TextStyle(),
                              ),
                            ));
                          } else {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  song.title! + ' is already in Playlist.',
                                ),
                              ),
                            );
                          }
                        },
                        leading: const Icon(
                          Icons.queue_music,
                          color: Colors.white,
                        ),
                        title: Text(
                          per_playlistName.toString(),
                          style: const TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      )
                    : Container(),
              )
              .toList()
        ],
      ),
    );
  }
}
