// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/material.dart';
// import 'package:musico_scratch/database/dbSongs.dart';
// import 'package:musico_scratch/openAssetAudio/openAssetAudio.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class bottomQdr extends StatefulWidget {
//   final String songId;

//   int index;
//   List<Audio> allSongs;
//   // List<dbSongs> databaseSongs = [];

//   bottomQdr(
//       {Key? key,
//       required this.index,
//       required this.allSongs,
//       required this.songId})
//       : super(key: key);

//   @override
//   State<bottomQdr> createState() => _NowPlayingState();
// }

// class _NowPlayingState extends State<bottomQdr> {
//   final box = MusicBox.getInstance();

//   List<dynamic>? favSongs = [];

//   List<dbSongs> databaseSongs = [];

//   // final assetsAudioPlayer = assetsAudioPlayer.withId("0");
//   @override
//   void initState() {
//     super.initState();

//     openPlayer();
//   }

//   void openPlayer() async {
//     await assetsAudioPlayer.open(
//         Playlist(audios: widget.allSongs, startIndex: widget.index),
//         showNotification: true,
//         autoStart: true,
//         loopMode: LoopMode.playlist,
//         playInBackground: PlayInBackground.enabled,
//         notificationSettings: NotificationSettings(stopEnabled: false));
//   }

//   Audio find(List<Audio> source, String fromPath) {
//     return source.firstWhere((element) {
//       return element.path == fromPath;
//     });
//     //assertion
//   }

//   bool isplaying = false;
//   bool isLooping = false;

//   IconData playbtn = Icons.pause_circle_outline_rounded;

//   @override
//   Widget build(BuildContext context) {
//     final databaseSongs = box.get("musics") as List<dbSongs>;
//     final temp = databaseSongsFunction(databaseSongs, widget.songId);
//     favSongs = box.get("favourites");
//     double myHeight = MediaQuery.of(context).size.height;
//     return Column(
//       children: [
//         StreamBuilder<Playing?>(
//           stream: assetsAudioPlayer.current,
//           builder: (context, playing) {
//             if (playing.data != null) {
//               final myaudio =
//                   find(widget.allSongs, playing.data!.audio.assetAudioPath);
//               // print('----ddddddd----${myaudio.metas.extra}-----dddddddd--');
//               final currentSong = databaseSongs.firstWhere((element) =>
//                   element.id.toString() == myaudio.metas.id.toString());

//               return Container(
//                 color: Colors.black,

//                 child: Row(children: [
//                    ListTile(

//                     //  tileColor: Colors.black,
//                      leading: Container(
//                     // height: MediaQuery.of(context).size.height * 0.35,
//                     // width: MediaQuery.of(context).size.height * 0.35,
//                     height: 30,
//                     width: 30,
//                     child:

                        
//                          Container(
//                           height: 250,
//                           width: 250,
//                           decoration: BoxDecoration(
//                               //color: Color.fromARGB(96, 0, 0, 0),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(0))),
//                           child: QueryArtworkWidget(
//                             // artworkClipBehavior: Clip.antiAliasWithSaveLayer,
//                             artworkFit: BoxFit.fill,
//                             nullArtworkWidget:
//                                 Image.asset('assets/images/muzify.png'),
//                             id: int.parse(myaudio.metas.id!),
//                             type: ArtworkType.AUDIO,
//                           ),
//                          ),
                      
//                   ),
//                   title:  Text(
//                       myaudio.metas.title.toString(),
//                       style: const TextStyle(
//                           color: Colors.black,
//                           fontSize: 8.0,
//                           fontWeight: FontWeight.bold),
//                       maxLines: 1,
//                     ),
//                     subtitle: Text(
//                       myaudio.metas.artist.toString(),
//                       style: const TextStyle(
//                         color: Colors.black,
//                         fontSize: 8.0,
//                       ),
//                     ),
//                     trailing: PlayerBuilder.isPlaying(
//                                   player: assetsAudioPlayer,
//                                   builder: (context, isplaying) {
//                                     return IconButton(
//                                       iconSize: 70,
//                                       onPressed: () async {
//                                         await assetsAudioPlayer.playOrPause();
//                                       },
//                                       icon: Icon(
//                                         isplaying
//                                             ? playbtn = Icons
//                                                 .pause_circle_outline_rounded
//                                             : playbtn = Icons
//                                                 .play_circle_filled_rounded,
//                                         color: Colors.black,
//                                       ),
//                                     );
//                                   },
//                                 ),
//                    ),


//                   // Column(children: [
//                   //   ListTile(
//                   //     title: Text(
//                   //       myaudio.metas.title.toString(),
//                   //       style: const TextStyle(
//                   //           color: Colors.white,
//                   //           fontSize: 18.0,
//                   //           fontWeight: FontWeight.bold),
//                   //       maxLines: 1,
//                   //     ),
//                   //     subtitle: Text(
//                   //       myaudio.metas.artist.toString(),
//                   //       style: const TextStyle(
//                   //         color: Colors.grey,
//                   //         fontSize: 14.0,
//                   //       ),
//                   //     ),
//                   //   ),
//                   //   SizedBox(
//                   //     height: MediaQuery.of(context).size.height * 0.01,
//                   //   ),
//                   //   Column(
//                   //     children: [
                       
//                   //       SizedBox(
//                   //         height: MediaQuery.of(context).size.height * 0.04,
//                   //       ),
//                   //       seekBarWidget(context),
//                   //       Padding(
//                   //           padding: const EdgeInsets.only(right: 0),
//                   //           child: Row(
//                   //             mainAxisAlignment: MainAxisAlignment.center,
//                   //             crossAxisAlignment: CrossAxisAlignment.center,
//                   //             children: [
//                   //               GestureDetector(
//                   //                 onTap: () {
//                   //                   assetsAudioPlayer.previous();
//                   //                   setState(() {});
//                   //                 },
//                   //                 child: const Icon(
//                   //                   Icons.skip_previous_rounded,
//                   //                   size: 50,
//                   //                   color: Colors.white,
//                   //                 ),
//                   //               ),
//                   //               SizedBox(
//                   //                 width:
//                   //                     MediaQuery.of(context).size.width * 0.08,
//                   //               ),
//                   //               PlayerBuilder.isPlaying(
//                   //                 player: assetsAudioPlayer,
//                   //                 builder: (context, isplaying) {
//                   //                   return IconButton(
//                   //                     iconSize: 70,
//                   //                     onPressed: () async {
//                   //                       await assetsAudioPlayer.playOrPause();
//                   //                     },
//                   //                     icon: Icon(
//                   //                       isplaying
//                   //                           ? playbtn = Icons
//                   //                               .pause_circle_outline_rounded
//                   //                           : playbtn = Icons
//                   //                               .play_circle_filled_rounded,
//                   //                       color: Colors.white,
//                   //                     ),
//                   //                   );
//                   //                 },
//                   //               ),
//                   //               SizedBox(
//                   //                 width:
//                   //                     MediaQuery.of(context).size.width * 0.09,
//                   //               ),
//                   //               GestureDetector(
//                   //                 onTap: () {
//                   //                   assetsAudioPlayer.next();
//                   //                   setState(() {
//                   //                     playbtn = Icons.pause_circle_outlined;
//                   //                     isplaying = false;
//                   //                   });
//                   //                   setState(() {});
//                   //                 },
//                   //                 child: const Icon(
//                   //                   Icons.skip_next_rounded,
//                   //                   size: 50,
//                   //                   color: Colors.white,
//                   //                 ),
//                   //               ),
//                   //             ],
//                   //           ))
//                   //     ],
//                   //   ),
//                   // ]),
//                 ]),
//               );
//             }
//             return const SizedBox();
//           },
//         ),
//       ],
//     );
//   }

//   // Widget seekBarWidget(BuildContext ctx) {
//   //   return assetsAudioPlayer.builderRealtimePlayingInfos(builder: (ctx, infos) {
//   //     Duration currentPosition = infos.currentPosition;
//   //     Duration total = infos.duration;
//   //     return Padding(
//   //       padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//   //       child: ProgressBar(
//   //         barHeight: 3,
//   //         progress: currentPosition,
//   //         total: total,
//   //         onSeek: (to) {
//   //           assetsAudioPlayer.seek(to);
//   //         },
//   //         baseBarColor: Color.fromARGB(255, 170, 167, 167),
//   //         progressBarColor: Color.fromARGB(234, 255, 255, 255),
//   //         bufferedBarColor: Colors.green,
//   //         thumbColor: Color.fromARGB(255, 240, 236, 237),
//   //         thumbRadius: 6,
//   //         thumbGlowColor: Colors.black,
//   //       ),
//   //     );
//   //   });
//   // }

//   dbSongs databaseSongsFunction(List<dbSongs> songs, String id) {
//     return songs.firstWhere(
//       (element) => element.id.toString().contains(id),
//     );
//   }
// }
