import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musico_scratch/presentation/playlists/widgets/TrailingButtonBottomSheet.dart';
import 'package:musico_scratch/database/dbSongs.dart';
import 'package:musico_scratch/presentation/playlists/widgets/playlistNowPlaying.dart';
import 'package:musico_scratch/main_page/widgets/play_song.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../songs/songs.dart';
import 'editPlaylist.dart';

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
List<Audio> playPlaylist = [];

ValueNotifier<List<dbSongs>> playli = ValueNotifier(playlistSongs);

class PlaylistSongs extends StatefulWidget {
  List? playlists;
  final String? Name;
  final int? songIndex;
  PlaylistSongs({
    Key? key,
    this.playlists,
    this.Name,
    this.songIndex,
  }) : super(key: key);

  @override
  State<PlaylistSongs> createState() => _PlaylistSongsState();
}

class _PlaylistSongsState extends State<PlaylistSongs> {
  // late String _now;
  // late Timer _everySecond;
  final box = MusicBox.getInstance();
  // final box1 = MusicBox1.getInstance();

  @override
  void initState() {
    super.initState();

    fullSongs();
  }

  fullSongs() {
    SongsList = box.get("musics") as List<dbSongs>;
    playlistSongs = box.get(widget.Name)!.cast<dbSongs>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (BuildContext context, dynamic value, Widget? child) {
            return Column(
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
                      "${widget.Name}",

                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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
                                return ListView.builder(
                                  itemBuilder: (context, index) => ListTile(
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: ((context) {
                                      //       return NowPlaying2(index: index, allSongs: databaseAudioList);
                                      //     }),
                                      //   ),
                                      // );
                                      // openPlayer(audios, index);
                                    },

                                    leading: Container(
                                      // decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),color: Colors.white30,),
                                      height: 43,
                                      width: 43,

                                      // color: Colors.grey,
                                      child: QueryArtworkWidget(
                                        artworkBorder: BorderRadius.all(
                                            Radius.circular(7)),
                                        // artworkClipBehavior: Clip.antiAliasWithSaveLayer,
                                        artworkFit: BoxFit.fill,
                                        nullArtworkWidget: Container(
                                            child: Image.asset(
                                          'assets/images/7461e3b8cc4ec795203213c851932faa.jpg',
                                          color: Colors.white30,
                                        )),
                                        id: int.parse(
                                            allSongs[index].id.toString()),
                                        type: ArtworkType.AUDIO,
                                      ),
                                    ),

                                    title: SizedBox(
                                      width: 200,
                                      // height: 40,
                                      child: Text(
                                        recievedDatabaseSongs[index]
                                            .title
                                            .toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ), // check display name also
                                    subtitle: Text(
                                      "${recievedDatabaseSongs[index].artist}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    trailing: playlistSongs
                                            .where((element) =>
                                                element.id.toString() ==
                                                SongsList[index].id.toString())
                                            .isEmpty
                                        ? IconButton(
                                            onPressed: () async {
                                              playlistSongs
                                                  .add(SongsList[index]);
                                              await box.put(
                                                  widget.Name, playlistSongs);

                                              setState(() {});
                                            },
                                            icon: const Icon(Icons.add))
                                        : IconButton(
                                            onPressed: () async {
                                              playlistSongs.removeWhere(
                                                  (elemet) =>
                                                      elemet.id.toString() ==
                                                      SongsList[index]
                                                          .id
                                                          .toString());

                                              await box.put(
                                                  widget.Name, playlistSongs);
                                              setState(() {
                                                rebuild = true;
                                              });
                                            },
                                            icon: const Icon(Icons.check_box),
                                          ),

                                  ),
                                  itemCount: recievedDatabaseSongs.length,
                                );
                              });
                        }

                        if (value == 1) {
                          showDialog(
                            context: context,
                            builder: (context) => editPlaylist(
                              playlistName: widget.Name.toString(),
                            ),
                          );

                          // editPlaylist(
                          //   Name: widget.playlists[widget.index],
                          // );
                          setState(() {});
                        }

                        if (value == 2) {
                          box.delete(widget.Name);
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
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      for (var element in playlistSongs) {
                        playPlaylist.add(
                          Audio.file(
                            element.uri!,
                            metas: Metas(
                              title: element.title,
                              id: element.id.toString(),
                              artist: element.artist,
                            ),
                          ),
                        );
                      }
                      OpenPlayer(fullSongs: playPlaylist, index: index)
                          .openAssetPlayer(index: index, songs: playPlaylist);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => playlistNowPlaying(
                                index: index, allSongs: playPlaylist)),
                      );
                      // Navigator.push(context, MaterialPageRoute(builder: (context){return playlistNowPlaying(index: index, allSongs: playPlaylist)}
                    },

                    // onTap: () {
                    // // var playlistSongs = box.get(widget.Name)!;
                    //  for (var element in playlistSongs) {
                    //               playPlaylist.add(
                    //                 Audio.file(
                    //                   element.uri!,
                    //                   metas: Metas(
                    //                     title: element.title,
                    //                     id: element.id.toString(),
                    //                     artist: element.artist,
                    //                   ),
                    //                 ),
                    //               );

                    // //   Navigator.push(
                    // //     context,
                    // //     MaterialPageRoute(
                    // //       builder: ((context) {
                    // //         return playlistNowPlaying(index: index, allSongs:playPlaylist )

                    // //   // openPlayer(audios, index);
                    // // },
                    // Navigator.push(context, MaterialPageRoute(builder: (context){return playlistNowPlaying(index: index, allSongs: playPlaylist);}
                    // )

                    //  }

                    leading: Container(
                      // decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),color: Colors.white30,),
                      height: 43,
                      // width: 43,

                      // color: Colors.grey,
                      child: QueryArtworkWidget(
                        artworkBorder: BorderRadius.all(Radius.circular(7)),
                        // artworkClipBehavior: Clip.antiAliasWithSaveLayer,
                        artworkFit: BoxFit.fill,
                        nullArtworkWidget: Container(
                            child: Image.asset(
                          'assets/images/7461e3b8cc4ec795203213c851932faa.jpg',
                          color: Colors.white30,
                        )),
                        id: int.parse(playlistSongs[index].id.toString()),
                        type: ArtworkType.AUDIO,
                      ),
                    ),

                    title: SizedBox(
                      width: 200,
                      // height: 40,
                      child: Text(
                        playlistSongs[index].title.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ), // check display name also
                    subtitle: Text(
                      "${playlistSongs[index].artist.toString()}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    trailing: PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert_outlined,
                        color: Colors.white,
                      ),
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem(
                          value: "1",
                          child: Text(
                            "Remove song",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                      onSelected: (value) {
                        if (value == "1") {
                          setState(() {
                            playlistSongs.removeAt(index);
                            box.put(widget.Name, playlistSongs);
                          });
                        }
                      },
                    ),

                    // MusicListMenu(
                    //   songId: databaseAudioList[index].metas.id.toString(),
                    // ),

                    //  MusicListMenu(
                    //               songId: widget.fullSongs[index].metas.id.toString(),
                    //             ),

                    // IconButton(
                    // onPressed: (){
                    //   return bottomSheethomePage(context,index);
                    // },
                    // icon: Icon(Icons.more_horiz_rounded),
                    // color: Colors.white,
                    // ),
                  ),
                  itemCount: playlistSongs.length,

                  // itemCount: recievedDatabaseSongs.length,

                  // child: ListView.builder(
                  //   itemCount: playlistSongs.length,
                  //   itemBuilder: (context, index) => ListTile(
                  //     title: Text(
                  //       playlistSongs[index].title.toString(),
                  //     ),
                  //   ),
                  // ),
                ))
              ],
            );
          },
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
