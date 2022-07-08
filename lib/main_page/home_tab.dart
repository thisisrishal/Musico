import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marquee/marquee.dart';
import 'package:musico_scratch/main_page/widgets/customTexts.dart';
import 'package:musico_scratch/main_page/NowPlaying.dart';
import 'package:musico_scratch/presentation/settings/ScreenSettings.dart';
import 'package:musico_scratch/main_page/widgets/play_song.dart';
import 'package:musico_scratch/presentation/artists/artists.dart';
import 'package:musico_scratch/presentation/playlists/playlists.dart';
import 'package:musico_scratch/presentation/songs/songs.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:swipe_to/swipe_to.dart';
import '../presentation/folders/folders.dart';
import '../presentation/search/screenSearch.dart';


class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}


class _HomeTabState extends State<HomeTab> with TickerProviderStateMixin {
  late TabController _tabController;
  int? index = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);

    // _tabController.addListener(_handleTabSelection);

    // requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) {
                      return ScreenSearch();
                    }),
                  ),
                );
              },
              icon: Icon(Icons.search),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) {
                        return ScreenSettings();
                      }),
                    ),
                  );
                },
                icon: Icon(Icons.settings))
          ],
          bottom: TabBar(
            controller: _tabController,
            labelPadding: EdgeInsets.only(bottom: 20, top: 10),
            tabs: [
              richTextHead('Songs'),
              richTextHead('Artists'),
              richTextHead('Folders'),
              richTextHead('Playlists')
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            controller: _tabController,
            children: [
              ScreenSongHome(), // ScreenSongs(),
              ScreenArtists(),
              ScreenAlbums(),
              ScreenPlaylists(),
            ],
          ),
        ),
        bottomSheet: SizedBox(
          height: 60,
          child:

              assetsAudioPlayer.builderCurrent(
            builder: (BuildContext context, Playing? playing) {
              final currentPlayingAudio =
                  find(databaseAudioList, playing!.audio.assetAudioPath);

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NowPlaying(
                          songList: databaseAudioList,
                          songId: allSongs[index!].id.toString()),
                    ),
                  );
                },
                child: Container(
                  color: Colors.black,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: QueryArtworkWidget(
                          artworkBorder: BorderRadius.all(Radius.circular(7)),
                          artworkFit: BoxFit.fill,

                          id: int.parse(currentPlayingAudio.metas.id!),
                          type: ArtworkType.AUDIO,
                          // artworkBorder:
                          //     const BorderRadius.all(Radius.circular(28)),
                          // artworkFit: BoxFit.cover,
                          nullArtworkWidget: const Icon(FontAwesomeIcons.music),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 12,
                            top: 12,
                          ),
                          child: SwipeTo(
                            iconSize: 0,
                            onLeftSwipe: () {
                              assetsAudioPlayer.next();
                            },
                            onRightSwipe: () {
                              assetsAudioPlayer.previous();
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 17,
                                  width: 300,
                                  child: Marquee(
                                    text: currentPlayingAudio.metas.title!,
                                  
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                                    // ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  currentPlayingAudio.metas.artist!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // IconButton(
                          //   onPressed: () {
                          //     assetsAudioPlayer.previous();
                          //   },
                          //   icon: const Icon(FontAwesomeIcons.stepBackward),
                          // ),
                          PlayerBuilder.isPlaying(
                              player: assetsAudioPlayer,
                              builder: (context, isPlaying) {
                                return IconButton(
                                  onPressed: () async {
                                    await assetsAudioPlayer.playOrPause();
                                  },
                                  icon: Icon(
                                    isPlaying
                                        ? FontAwesomeIcons.pause
                                        : FontAwesomeIcons.play,
                                  ),
                                  color: Colors.white,
                                );
                              }),
                          GestureDetector(
                            child: IconButton(
                              onPressed: () {
                                assetsAudioPlayer.next();
                              },
                              icon: const Icon(
                                FontAwesomeIcons.forwardStep,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }



//   void _handleTabSelection() {
//     setState(() {}
//     );
//   }
}
