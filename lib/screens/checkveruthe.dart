

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';
import 'package:musico_scratch/database/dbSongs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayBackWidget extends StatefulWidget {
  List<Audio> finalSong;
  int? index;
  PlayBackWidget({Key? key, required this.finalSong, this.index})
      : super(key: key);

  @override
  State<PlayBackWidget> createState() => _PlayBackWidgetState();
}

class _PlayBackWidgetState extends State<PlayBackWidget> {
  List<dbSongs> databasesongs = [];
  List<dynamic>? likedSongs = [];
  dbSongs? currentSong;

  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  final box = MusicBox.getInstance();

  bool isPlaying = false;
  bool isPause = false;
  bool isLooping = false;
  bool isShuffle = false;

  IconData iconPlay = Icons.play_circle_outline_rounded;
  IconData iconPause = Icons.pause_circle_outline_rounded;

  @override
  void initState() {
    databasesongs = box.get('songs') as List<dbSongs>;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffffffff), Color(0xffbfbfc1)])),
      child: Scaffold(
          appBar: AppBar(
            actions: [
              PopupMenuButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.more_vert_rounded,
                      color: Colors.grey[600],
                    ),
                  ),
                  color: Colors.grey,
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: const Text(
                            'Add to Play List',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins-Regular'),
                          ),
                          onTap: () {
                            // showBottomSheet(
                            //     context: context,
                            //     builder: (context) =>
                            //         AddtoPlayList(song: currentSong!));
                          },
                        ),
                      ]),
            ],
            title: Text(
              'Now playing',
              style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 18.sp,
                  fontFamily: 'Poppins-Regular'),
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 30.sp,
                  color: Colors.grey[600],
                )),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body:
              audioPlayer.builderCurrent(builder: (context, Playing? playing) {
            final myAudio =
                find(widget.finalSong, playing!.audio.assetAudioPath);

            currentSong = databasesongs.firstWhere((element) =>
                element.id.toString() == myAudio.metas.id.toString());

            likedSongs = box.get("favourites");

            return SingleChildScrollView(
              child: SafeArea(
                  child: Column(
                children: [
                  // if(widget.finalSong !=null){
                  SizedBox(
                    height: 40.h,
                  ),
                  SizedBox(
                    height: 200.h,
                    width: 200.h,
                    child: QueryArtworkWidget(
                        // artworkColor: Colors.black,
                        artworkBorder: BorderRadius.circular(3.r),
                        nullArtworkWidget: const Image(
                            image: AssetImage('asset/nullPlay.gif')),
                        id: int.parse(myAudio.metas.id!),
                        artworkFit: BoxFit.cover,
                        type: ArtworkType.AUDIO),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),

                  SizedBox(
                    height: 40.h,
                    width: 200.h,
                    child: Marquee(
                      text: myAudio.metas.title!,
                      scrollAxis: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      blankSpace: 20.0,
                      velocity: 50.0,
                      pauseAfterRound: const Duration(seconds: 1),
                      startPadding: 5.0,
                      accelerationDuration: const Duration(seconds: 1),
                      accelerationCurve: Curves.linear,
                      decelerationDuration: const Duration(milliseconds: 500),
                      decelerationCurve: Curves.easeOut,
                      style: TextStyle(
                          fontSize: 18.sp, fontFamily: 'Poppins-regular'),
                    ),
                  ),

                  SizedBox(
                      width: 200.w,
                      child: Column(
                        children: [
                          Text(
                            myAudio.metas.artist!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: 'Poppins-regular',
                                color: Colors.black87),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 150.h,
                    // width: 200.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            StatefulBuilder(builder: (BuildContext context,
                                void Function(void Function()) setState) {
                              return !isShuffle
                                  ? IconButton(
                                      onPressed: () async {
                                        setState(
                                          () {
                                            isShuffle = true;
                                            audioPlayer.toggleShuffle();
                                          },
                                        );
                                      },
                                      icon: const Icon(Icons.shuffle_rounded),
                                    )
                                  : IconButton(
                                      onPressed: () async {
                                        setState(
                                          () {
                                            isShuffle = false;
                                            audioPlayer
                                                .setLoopMode(LoopMode.playlist);
                                          },
                                        );
                                      },
                                      icon: const Icon(Icons.cached_rounded));
                            }),
                            StatefulBuilder(builder: (BuildContext context,
                                void Function(void Function()) setState) {
                              return likedSongs!
                                      .where((element) =>
                                          element.id.toString() ==
                                          currentSong!.id.toString())
                                      .isEmpty
                                  ? IconButton(
                                      onPressed: () async {
                                        setState(
                                          () {
                                            likedSongs?.add(currentSong);
                                            box.put('favourites', likedSongs!);
                                            likedSongs = box.get('favourites');
                                          },
                                        );

                                        // setState(() {});
                                      },
                                      icon: const Icon(
                                          Icons.favorite_border_rounded),
                                    )
                                  : IconButton(
                                      onPressed: () async {
                                        setState(
                                          () {
                                            likedSongs?.removeWhere((element) =>
                                                element.id.toString() ==
                                                currentSong!.id.toString());
                                            box.put('favourites', likedSongs!);
                                          },
                                        );
                                      },
                                      icon: const Icon(Icons.favorite));
                            }),
                            StatefulBuilder(
                              builder: (BuildContext context,
                                  void Function(void Function()) setState) {
                                return !isLooping
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isLooping = true;
                                            audioPlayer
                                                .setLoopMode(LoopMode.single);
                                          });
                                        },
                                        icon: const Icon(Icons.repeat_rounded),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isLooping = false;
                                            audioPlayer
                                                .setLoopMode(LoopMode.playlist);
                                          });
                                        },
                                        icon: const Icon(
                                            Icons.repeat_one_rounded),
                                      );
                              },
                            ),
                          ],
                        ),
                        Container(
                          child: seekBar(context),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  audioPlayer.previous();
                                },
                                child: Icon(
                                  Icons.skip_previous_rounded,
                                  size: 40.sp,
                                )),
                            SizedBox(
                              width: 40.w,
                            ),
                            PlayerBuilder.isPlaying(
                                player: audioPlayer,
                                builder: (context, isPlaying) {
                                  return GestureDetector(
                                      onTap: () async {
                                        await audioPlayer.playOrPause();
                                      },
                                      child: Icon(
                                        isPlaying ? iconPause : iconPlay,
                                        size: 40.sp,
                                      ));
                                }),
                            SizedBox(
                              width: 40.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                audioPlayer.next();
                              },
                              child: Icon(
                                Icons.skip_next_rounded,
                                size: 40.sp,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )),
            );
          })),
    );
  }

  Widget seekBar(BuildContext ctx) {
    return audioPlayer.builderRealtimePlayingInfos(
      builder: (ctx, infos) {
        Duration currentPos = infos.currentPosition;
        Duration total = infos.duration;
        return Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: ProgressBar(
            progress: currentPos,
            total: total,
            progressBarColor: Colors.black54,
            baseBarColor: Colors.grey,
            thumbColor: Colors.black87,
            onSeek: (to) {
              audioPlayer.seek(to);
            },
          ),
        );
      },
    );
  }
}








// GestureDetector(
//         onTap: (() {
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder: (context) => NowPlaying2(index: 0, allSongs: databaseAudioList, songId: 0),
//           //   ),
//           // );
//         }),
//         child: SizedBox(
//           height: 60,
//           child: assetAudioPlayer.builderCurrent(
//             builder: (BuildContext context, Playing? playing) {
//               final myAudio =
//                   find(databaseAudioList, playing!.audio.assetAudioPath);
//               return Row(
//                 children: [
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   SizedBox(
//                     height: 50,
//                     width: 50,
//                     child: CircleAvatar(
//                       child: QueryArtworkWidget(
//                         id: int.parse(myAudio.metas.id!),
//                         type: ArtworkType.AUDIO,
//                         artworkBorder:
//                             const BorderRadius.all(Radius.circular(28)),
//                         artworkFit: BoxFit.cover,
//                         nullArtworkWidget: const Icon(FontAwesomeIcons.music),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                         left: 12,
//                         top: 12,
//                       ),  
//                       child: SwipeTo(
//                         iconSize: 0,
//                         onLeftSwipe: () {
//                           assetAudioPlayer.next();
//                         },
//                         onRightSwipe: () {
//                           assetAudioPlayer.previous();
//                         },
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               myAudio.metas.title!,
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: const TextStyle(
//                                   fontFamily: 'Poppins',
//                                   fontWeight: FontWeight.w500),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               myAudio.metas.artist!,
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: const TextStyle(
//                                   fontSize: 12, fontFamily: 'Poppins'),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           assetAudioPlayer.previous();
//                         },
//                         icon: const Icon(FontAwesomeIcons.stepBackward),
//                       ),
//                       PlayerBuilder.isPlaying(
//                           player: assetAudioPlayer,
//                           builder: (context, isPlaying) {
//                             return IconButton(
//                               onPressed: () async {
//                                 await assetAudioPlayer.playOrPause();
//                               },
//                               icon: Icon(
//                                 isPlaying
//                                     ? FontAwesomeIcons.pause
//                                     : FontAwesomeIcons.play,
//                               ),
//                             );
//                           }),
//                       GestureDetector(
//                         child: IconButton(
//                           onPressed: () {
//                             assetAudioPlayer.next();
//                           },
//                           icon: const Icon(FontAwesomeIcons.stepForward),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               );
//             },
//           ),
//         ),
//             )