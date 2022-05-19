import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musico_scratch/database/dbSongs.dart';
import 'package:musico_scratch/new%202/NowPlaying.dart';
import 'package:musico_scratch/openAssetAudio/play_song.dart';
import 'package:musico_scratch/presentation/songs/songs.dart';
import 'package:on_audio_query/on_audio_query.dart';


class listFavouriteSongs extends StatefulWidget {
  const listFavouriteSongs({Key? key}) : super(key: key);

  @override
  State<listFavouriteSongs> createState() => _listFavouriteSongsState();
}

class _listFavouriteSongsState extends State<listFavouriteSongs> {
  final box = MusicBox.getInstance();
  @override
  @override
  Widget build(BuildContext context) {
    likedSongs =  box.get("favourites");

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Favourites',
        ),
        elevation: 0.0,
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: Expanded(
          child: ValueListenableBuilder(
              valueListenable: box.listenable(keys: ['favourites']),
              builder: (context, value, child) {
                for (var element in likedSongs!) {
                  favouriteSongsAudio.add(Audio.file(
                    element.uri.toString(),
                    metas: Metas(
                      title: element.title,
                      artist: element.artist,
                      id: element.id.toString(),
                    ),
                  ));
                }

                return box.get("favourites")!.isNotEmpty
                    ? ListView.builder(
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              OpenPlayer(
                                      fullSongs: favouriteSongsAudio,
                                      index: index)
                                  .openAssetPlayer(
                                      index: index, songs: favouriteSongsAudio);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => NowPlaying(
                                        
                                        songList: favouriteSongsAudio,
                                        songId:
                                            likedSongs![index].id.toString(),
                                      )),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: Container(
                                height: 43,
                                width: 43,
                                child: QueryArtworkWidget(
                                  artworkBorder:
                                      BorderRadius.all(Radius.circular(7)),
                                  artworkFit: BoxFit.fill,
                                  nullArtworkWidget: Container(
                                      child: Image.asset(
                                    'assets/images/7461e3b8cc4ec795203213c851932faa.jpg',
                                    color: Colors.white30,
                                  )),
                                  id: int.parse(
                                      likedSongs![index].id.toString()),
                                  type: ArtworkType.AUDIO,
                                ),
                              ),
                              title: SizedBox(
                                width: 200,
                                // height: 40,
                                child: Text(
                                  likedSongs![index].title.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              subtitle: Text(
                                likedSongs![index].title.toString(),
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
                                      likedSongs!.removeAt(index);
                                      box.put('favourites', likedSongs!);
                                    });
                                  }
                                },
                              ),
                              // trailing:  getfavouriteSongs
                              //                 .where((element) =>
                              //                     element.id.toString() == allSongs[index].id.toString())
                              //                 .isEmpty
                              //             ? IconButton(
                              //                 onPressed: () async {
                              //                   playlistSongs.add(SongsList[index]);
                              //                   await box.put(widget.playListName, playlistSongs);

                              //                   setState(() {});
                              //                 },
                              //                 icon: const Icon(Icons.add))
                              //             : IconButton(
                              //                 onPressed: () async {
                              //                   playlistSongs.removeWhere((elemet) =>
                              //                       elemet.id.toString() == SongsList[index].id.toString());

                              //                   await box.put(widget.playListName, playlistSongs);
                              //                   setState(() {});
                              //                 },
                              //                 icon: const Icon(Icons.check_box),
                              //               ),,
                              // Text(
                              //   'getfavouriteSongs[index].title.toString()${index + 1}',
                              //   style: TextStyle(color: Colors.white),
                              // ),
                            ),
                          );
                        },
                        itemCount: likedSongs!.length,
                      )
                    : Container(
                        height: height,
                        width: width,
                        child: Center(
                          child: Text(
                            'No songs',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
              }),
        ),
      ),
    ));
  }
}


//  child: ValueListenableBuilder(
//         valueListenable: box.listenable(),
//         builder: (context, boxes, _) {
//           return
//            ListView.builder(
    
//             physics: NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               return
//               GestureDetector(
    
//                   // onTap: () => Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(
//                   //     builder: ((context) => PlaylistSongs(  Name: playlists[index], playlists:playlists)),
//                   //   ),
//                   // ),
    
//                   child: getfavouriteSongs.isNotEmpty
//                       ? listofPlaylists(
//                           title: 'aaaaaaaaa',
//                           trailingWidget: PopupMenuButton(
//                             itemBuilder: (context) => [
//                               PopupMenuItem(
//                                 value: 1,
//                                 child: Text(
//                                   'Rename',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ),
//                               PopupMenuItem(
//                                 value: 2,
//                                 child: Text(
//                                   'Delete',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                             onSelected: (value) {
//                               if (value == 1) {}
    
//                               if (value == 2) {}
//                             },
//                             icon: Icon(
//                               Icons.more_vert,
//                               color: Colors.white,
//                             ),
//                           ),
//                         )
//                       : Container());
//             },
//           );
//         },
//       ),