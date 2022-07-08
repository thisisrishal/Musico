import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:musico_scratch/database/dbSongs.dart';

import 'package:on_audio_query/on_audio_query.dart';

import '../presentation/playlists/widgets/addToPlaylist.dart';
import 'widgets/play_song.dart';

// ignore: must_be_immutable
class NowPlaying extends StatefulWidget {
  //currently playing song id as string
  final String songId;
  List<Audio> songList;

  NowPlaying({Key? key, required this.songList, required this.songId})
      : super(key: key);

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  final box = MusicBox.getInstance();

  List<dbSongs> databaseSongs = [];
  List<dynamic>? favSongs = [];

  IconData playbtn = Icons.pause_circle_outline_rounded;

  bool isplaying = false;
  bool isLooping = false;

  @override
  Widget build(BuildContext context) {
    final databaseSongs = box.get("musics") as List<dbSongs>;

    // got the current playing song  song in databaseSong
    final temp = getCurrentPlayingSong(databaseSongs, widget.songId);
    favSongs = box.get("favourites");
    double fullHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: ,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(250, 7, 23, 32),
            Color.fromARGB(250, 9, 20, 27),
            Colors.black,
            Colors.black,
            Color.fromARGB(211, 0, 0, 0)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Stack(children: [
          Container(
              // decoration: BoxDecoration(image: DecorationImage(image: MemoryImage())),
              ),
          Column(
            children: [
              StreamBuilder<Playing?>(
                stream: assetsAudioPlayer.current,
                builder: (context, playing) {
                  if (playing.data != null) {
                    final myaudio = find(
                        widget.songList, playing.data!.audio.assetAudioPath);
                    final currentSong = databaseSongs.firstWhere((element) =>
                        element.id.toString() == myaudio.metas.id.toString());

                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.height * 0.03),
                      child: Column(children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                        ),
                        ListTile(
                          title: Text(
                            myaudio.metas.title.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                          subtitle: Text(
                            myaudio.metas.artist.toString(),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: MediaQuery.of(context).size.height * 0.35,
                              //
                              child: QueryArtworkWidget(
                                size: 2000,
                                artworkQuality: FilterQuality.high,

                                artworkBorder: BorderRadius.circular(20),

                                // artworkClipBehavior: Clip.antiAliasWithSaveLayer,
                                artworkFit: BoxFit.cover,
                                nullArtworkWidget: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    color: Color(0xff404040),
                                  ),
                                  height: 45,
                                  width: 45,
                                  child: Icon(
                                    Icons.music_note_outlined,
                                    size: MediaQuery.of(context).size.width *
                                        0.35,
                                    color: Colors.white60,
                                  ),
                                ),
                                id: int.parse(myaudio.metas.id!),
                                type: ArtworkType.AUDIO,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            seekBarWidget(context),
                            Padding(
                              padding: const EdgeInsets.only(right: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      assetsAudioPlayer.previous();
                                      setState(() {});
                                    },
                                    child: const Icon(
                                      Icons.skip_previous_rounded,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.08,
                                  ),
                                  PlayerBuilder.isPlaying(
                                    player: assetsAudioPlayer,
                                    builder: (context, isplaying) {
                                      return IconButton(
                                        iconSize: 70,
                                        onPressed: () async {
                                          await assetsAudioPlayer.playOrPause();
                                        },
                                        icon: Icon(
                                          isplaying
                                              ? playbtn = Icons
                                                  .pause_circle_outline_rounded
                                              : playbtn = Icons
                                                  .play_circle_filled_rounded,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.09,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      assetsAudioPlayer.next();
                                      setState(() {
                                        playbtn = Icons.pause_circle_outlined;
                                        isplaying = false;
                                      });
                                      setState(() {});
                                    },
                                    child: const Icon(
                                      Icons.skip_next_rounded,
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
                                height: fullHeight * 0.08,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        const Color.fromARGB(255, 58, 61, 59)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) =>
                                              AddtoPlayList(song: temp),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.playlist_add,
                                        color: Colors.white,
                                        size: 30.0,
                                      ),
                                    ),
                                    Container(
                                        child: favSongs!
                                                .where(
                                                  (element) =>
                                                      element.id.toString() ==
                                                      currentSong.id.toString(),
                                                )
                                                .isEmpty
                                            ? IconButton(
                                                onPressed: () async {
                                                  favSongs?.add(currentSong);
                                                  box.put(
                                                      "favourites", favSongs!);
                                                  favSongs =
                                                      box.get('favourites');
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        temp.title! +
                                                            " Added to Favourites",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  );
                                                  setState(() {});
                                                },
                                                icon: Image.asset(
                                                  'assets/images/love.png',
                                                  color: Colors.white,
                                                  height: 25,
                                                ),
                                              )
                                            : IconButton(
                                                onPressed: () async {
                                                  favSongs!.removeWhere(
                                                      (element) =>
                                                          element.id
                                                              .toString() ==
                                                          temp.id.toString());
                                                  await box.put(
                                                      "favourites", favSongs!);
                                                  favSongs =
                                                      box.get('favourites');
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        temp.title! +
                                                            " Removed from Favourites",
                                                        // style: const TextStyle(fontFamily: 'Poppins'),
                                                      ),
                                                    ),
                                                  );
                                                  setState(() {});
                                                },
                                                icon: Image.asset(
                                                  'assets/images/love.png',
                                                  color: Color.fromARGB(
                                                      255, 194, 36, 25),
                                                  height: 25,
                                                ),
                                              )),
                                    !isLooping
                                        ? IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isLooping = true;
                                                assetsAudioPlayer.setLoopMode(
                                                    LoopMode.single);
                                              });
                                            },
                                            icon: const Icon(Icons.repeat,
                                                color: Colors.white),
                                          )
                                        : IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isLooping = false;
                                                assetsAudioPlayer.setLoopMode(
                                                    LoopMode.playlist);
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.repeat_one,
                                              color: Colors.white,
                                            ),
                                          )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ]),
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
          barHeight: 3,
          progress: currentPosition,
          total: total,
          onSeek: (to) {
            assetsAudioPlayer.seek(to);
          },
          baseBarColor: Color.fromARGB(255, 170, 167, 167),
          progressBarColor: Color.fromARGB(234, 255, 255, 255),
          bufferedBarColor: Colors.green,
          thumbColor: Color.fromARGB(255, 240, 236, 237),
          thumbRadius: 6,
          thumbGlowColor: Colors.black,
        ),
      );
    });
  }

// take the currently playing audio with the list the given
  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) {
      return element.path == fromPath;
    });
  }

// get the function
  dbSongs getCurrentPlayingSong(List<dbSongs> songs, String id) {
    return songs.firstWhere(
      (element) => element.id.toString().contains(id),
    );
  }
}
