import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlaying2 extends StatefulWidget {
  int index;
  List<Audio> allSongs;

  NowPlaying2({Key? key, required this.index, required this.allSongs})
      : super(key: key);

  @override
  State<NowPlaying2> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying2> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  final AssetsAudioPlayer player = AssetsAudioPlayer.withId("0");

  // final List<StreamSubscription> subscription = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    // subscription.add(assetsAudioPlayer.playlistAudioFinished.listen((data) {
    //print('playlistAudioFinished :$data');
    // }));
    // subscription.add(assetsAudioPlayer.audioSessionId.listen((sessionId) {
    //print('audioSessionId : $sessionId');
    // }));
    openPlayer();
  }

  void openPlayer() async {
    await assetsAudioPlayer.open(
        Playlist(audios: widget.allSongs, startIndex: widget.index),
        showNotification: true,
        autoStart: true,
        // loopMode: LoopMode.playlist,
        playInBackground: PlayInBackground.enabled,
        notificationSettings: NotificationSettings(stopEnabled: false));
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) {
      // print('---------------------------${fromPath}---');

      return element.path == fromPath;
    });
    //assertion
  }

  bool isplaying = false;
  IconData playbtn = Icons.pause_circle_outline_rounded;

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_drop_down),
        ),
        backgroundColor: const Color.fromARGB(255, 24, 3, 18),
        centerTitle: true,
        title: const Text(
          'Now Playing',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 24, 3, 18),
            Color.fromARGB(255, 130, 134, 135)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Column(
          children: [
            StreamBuilder<Playing?>(
              stream: assetsAudioPlayer.current,
              builder: (context, playing) {
                if (playing.data != null) {
                  final myaudio =
                      find(widget.allSongs, playing.data!.audio.assetAudioPath);
                  // print('----ddddddd----${myaudio.metas.extra}-----dddddddd--');

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Container(
                          height: 250,
                          width: 250,
                          decoration: BoxDecoration(
                              //color: Color.fromARGB(96, 0, 0, 0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0))),
                          child: QueryArtworkWidget(
                            // artworkClipBehavior: Clip.antiAliasWithSaveLayer,
                            artworkFit: BoxFit.fill,
                            nullArtworkWidget:
                                Image.asset('assets/images/muzify.png'),
                            id: int.parse(myaudio.metas.id!),
                            type: ArtworkType.AUDIO,
                          ),

                          // myaudio.metas.image?.path == null
                          //     ? const SizedBox()
                          //     : myaudio.metas.image?.type == ImageType.network
                          //         ? Image.network(
                          //             myaudio.metas.image!.path,
                          //             height: 200,
                          //             width: 200,
                          //             fit: BoxFit.contain,
                          //           )
                          //         : Image.asset(
                          //             myaudio.metas.image!.path,
                          //             height: 200,
                          //             width: 200,
                          //             fit: BoxFit.cover,
                          //           ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                            width: 250,
                            child: Marquee(
                              text: "${myaudio.metas.title}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Text(
                            "${myaudio.metas.artist}",
                            style: const TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              child: seekBarWidget(context)),
                          Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    assetsAudioPlayer.previous();
                                    setState(() {
                                      // playbtn = Icons.pause_circle_outline;
                                      // isplaying = false;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.skip_previous,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.08,
                                ),
                                PlayerBuilder.isPlaying(
                                  player: assetsAudioPlayer,
                                  builder: (context, isplaying) {
                                    return IconButton(
                                      iconSize: 50,
                                      onPressed: () async {
                                        await assetsAudioPlayer.playOrPause();
                                      },
                                      icon: Icon(
                                        isplaying
                                            ? playbtn =
                                                Icons.pause_circle_outlined
                                            : playbtn = Icons
                                                .play_circle_filled_outlined,
                                      ),
                                    );
                                  },
                                ),

                                // GestureDetector(
                                //   onTap: () {
                                //     if (isplaying != true) {
                                //       setState(() {
                                //         playbtn =
                                //             Icons.play_circle_filled_outlined;
                                //         isplaying = true;
                                //         assetsAudioPlayer.playOrPause();
                                //       });
                                //     } else {
                                //       setState(() {
                                //         playbtn = Icons.pause_circle_outlined;
                                //         isplaying = false;
                                //         assetsAudioPlayer.playOrPause();
                                //       });
                                //     }
                                //   },

                                //   child: Icon(
                                //     playbtn,
                                //     size: 60,
                                //     color: Colors.white,
                                //   ),
                                // ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.09,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    assetsAudioPlayer.next();
                                    setState(() {
                                      playbtn = Icons.pause_circle_outlined;
                                      isplaying = false;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.skip_next,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 50.0, right: 50.0),
                            child: Container(
                              height: myHeight * 0.08,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromARGB(255, 58, 61, 59)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.playlist_add,
                                      color: Colors.white,
                                      size: 30.0,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Image.asset(
                                      'assets/images/love.png',
                                      color: Colors.white,
                                      height: 25,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.repeat,
                                      color: Colors.white,
                                      size: 30.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget seekBarWidget(BuildContext ctx) {
    return assetsAudioPlayer.builderRealtimePlayingInfos(builder: (ctx, infos) {
      Duration currentPosition = infos.currentPosition;
      Duration total = infos.duration;
      return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: ProgressBar(
          progress: currentPosition,
          total: total,
          onSeek: (to) {
            assetsAudioPlayer.seek(to);
          },
          baseBarColor: Color.fromARGB(255, 190, 190, 190),
          progressBarColor: Color.fromARGB(234, 209, 120, 184),
          bufferedBarColor: Colors.green,
          thumbColor: Color.fromARGB(255, 214, 12, 157),
        ),
      );
    });
  }
}
