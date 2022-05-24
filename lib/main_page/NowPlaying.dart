import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musico_scratch/logic/nowPlaying/nowplaying_bloc.dart';

import 'package:on_audio_query/on_audio_query.dart';

import '../database/dbSongs.dart';
import '../logic/Icon Bloc/icon_bloc_bloc.dart';
import '../presentation/playlists/widgets/addToPlaylist.dart';
import 'widgets/play_song.dart';

// ignore: must_be_immutable
class NowPlaying extends StatefulWidget {
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

  //default pause
  IconData playbtn = Icons.pause_circle_outline_rounded;

  bool isplaying = false;
  bool isLooping = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final databaseSongs = box.get("musics") as List<dbSongs>;

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
              assetsAudioPlayer.builderCurrent(
                  builder: (context, Playing? playing) {
                if (playing!.audio.assetAudioPath.isEmpty) {
                  return Center(child: Text('empty'));
                }

                final myaudio =
                    find(widget.songList, playing.audio.assetAudioPath);
                final currentSong = databaseSongs.firstWhere((element) =>
                    element.id.toString() == myaudio.metas.id.toString());
                context.read<NowplayingBloc>().add(NowPlayingLoadedEvent(
                    songId: widget.songId,
                    songList: widget.songList,
                    playing: playing.audio.assetAudioPath));
                return BlocBuilder<NowplayingBloc, NowplayingState>(
                  builder: (context, state) {
                    if (state is NowPlayingLoaded) {
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
                              state.title.toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                            ),
                            subtitle: Text(
                              state.subtitle.toString(),
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
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                width:
                                    MediaQuery.of(context).size.height * 0.35,
                                //
                                child: QueryArtworkWidget(
                                  size: 2000,
                                  artworkQuality: FilterQuality.high,

                                  artworkBorder: BorderRadius.circular(8),

                                  // artworkClipBehavior: Clip.antiAliasWithSaveLayer,
                                  artworkFit: BoxFit.cover,
                                  nullArtworkWidget: Container(
                                      child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white24,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/bacground_icon.jpg',
                                        ),
                                      ),
                                    ),
                                    // child: Image.asset(
                                    //                   'assets/images/bacground_icon.jpg',
                                    //                   // color: Colors.white30,
                                    //                 ),
                                  )),
                                  id: int.parse(state.id),
                                  type: ArtworkType.AUDIO,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
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
                                            await assetsAudioPlayer
                                                .playOrPause();
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
                                        playbtn = Icons.pause_circle_outlined;
                                        isplaying = false;
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
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, left: 50.0, right: 50.0),
                                  child: Container(
                                    height: fullHeight * 0.08,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color.fromARGB(
                                            255, 58, 61, 59)),
                                    child: BlocBuilder<IconBlocBloc,
                                            IconBlocState>(
                                        builder: (context, state) {
                                      return Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            BlocBuilder<NowplayingBloc,
                                                    NowplayingState>(
                                                builder: (context, state) {
                                              if (state is NowPlayingLoaded) {
                                                return IconButton(
                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder: (context) =>
                                                          AddtoPlayList(
                                                              song: state
                                                                  .nowPlaying),
                                                    );
                                                  },
                                                  icon: const Icon(
                                                    Icons.playlist_add,
                                                    color: Colors.white,
                                                    size: 30.0,
                                                  ),
                                                );
                                              }
                                              return Container();
                                            }),
                                            // BlocBuilder<FavSongsBloc,
                                            //         FavSongsState>(
                                            //     builder: (context, state) {
                                            //   context.read<FavSongsBloc>().add(
                                            //       FavItemEvent(
                                            //           playing: playing,
                                            //           songList: widget.songList));

                                            // if (state is FavItem) {
                                            // return
                                            BlocBuilder<IconBlocBloc,
                                                IconBlocState>(
                                              builder: (context, state) {
                                                return Container(
                                                    child: favSongs!
                                                            .where(
                                                              (element) =>
                                                                  element.id
                                                                      .toString() ==
                                                                  currentSong.id
                                                                      .toString(),
                                                            )
                                                            .isEmpty
                                                        ? IconButton(
                                                            onPressed:
                                                                () async {
                                                              // print(
                                                              //     '============= Clicked ========');

                                                              // context
                                                              //     .read<
                                                              //         FavSongsBloc>()
                                                              //     .add(AddtoFavEvent(
                                                              //         playing:
                                                              //             playing,
                                                              //         songList: widget
                                                              //             .songList));
                                                              // // context
                                                              //     .read<
                                                              //         FavSongsBloc>()
                                                              //     .add(FavItemEvent(
                                                              //         playing:
                                                              //             playing,
                                                              //         songList: widget
                                                              //             .songList));
                                                              context.read<
                                                                  IconBlocBloc>().add(IconChangeEvent(iconData: Icons.favorite));

                                                              favSongs?.add(
                                                                  currentSong);
                                                              box.put(
                                                                  "favourites",
                                                                  favSongs!);
                                                              favSongs = box.get(
                                                                  'favourites');
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    temp.title! +
                                                                        " Added to Favourites",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            icon:Icon(Icons.favorite_border,
                                                                color:
                                                                    Colors.red))
                                                        : IconButton(
                                                            onPressed:
                                                                () async {
                                                              favSongs!.removeWhere(
                                                                  (element) =>
                                                                      element.id
                                                                          .toString() ==
                                                                      temp.id
                                                                          .toString());
                                                              await box.put(
                                                                  "favourites",
                                                                  favSongs!);
                                                              favSongs = box.get(
                                                                  'favourites');
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    temp.title! +
                                                                        " Removed from Favourites",
                                                                    // style: const TextStyle(fontFamily: 'Poppins'),
                                                                  ),
                                                                ),
                                                              );
                                                              context
                                                                  .read<
                                                                      IconBlocBloc>()
                                                                  .add(IconChangeEvent(
                                                                      iconData:
                                                                          Icons
                                                                              .favorite_border));
                                                            },
                                                            icon:Icon(Icons.favorite,color: Colors.red
                                                            ,)
                                                            
                                                          ));
                                              },
                                            ),
                                            // }),
                                            Container(
                                              child: !isLooping
                                                  ? IconButton(
                                                      onPressed: () {
                                                        isLooping = true;
                                                        assetsAudioPlayer
                                                            .toggleShuffle();
                                                        context
                                                            .read<
                                                                IconBlocBloc>()
                                                            .add(
                                                              const IconChangeEvent(
                                                                iconData: Icons
                                                                    .shuffle,
                                                              ),
                                                            );
                                                        //   isLooping = true;
                                                        //   assetsAudioPlayer.setLoopMode(
                                                        //       LoopMode.single);
                                                      },
                                                      icon: const Icon(
                                                          Icons.shuffle,
                                                          color: Colors.white),
                                                    )
                                                  : IconButton(
                                                      onPressed: () {
                                                        // isLooping = false;
                                                        // assetsAudioPlayer
                                                        //     .setLoopMode(
                                                        //         LoopMode
                                                        //             .playlist);
                                                        isLooping = false;
                                                        assetsAudioPlayer
                                                            .setLoopMode(
                                                                LoopMode
                                                                    .playlist);
                                                        context
                                                            .read<
                                                                IconBlocBloc>()
                                                            .add(
                                                              const IconChangeEvent(
                                                                iconData: Icons
                                                                    .cached,
                                                              ),
                                                            );
                                                      },
                                                      icon: const Icon(
                                                        Icons.repeat_one,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                            )
                                          ]);
                                    }),
                                  ))
                            ],
                          ),
                        ]),
                      );
                    }
                    return Center(
                        child: Text('NowPlayingLoaded State not working'));
                  },
                );

                // return Center(
                //     child: Text('NowPlayingLoaded State not working'));
              }

                  // return const SizedBox();
                  // );

                  // else {
                  //     return Text('now playing not loading ');
                  //   }

                  // );
                  // },
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
  // Audio find(List<Audio> source, String fromPath) {
  //   return source.firstWhere((element) {
  //     return element.path == fromPath;
  //   });
  // }

// get the function
  dbSongs getCurrentPlayingSong(List<dbSongs> songs, String id) {
    return songs.firstWhere(
      (element) => element.id.toString().contains(id),
    );
  }
}
