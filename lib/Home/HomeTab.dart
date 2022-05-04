import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:musico_scratch/custom/customTexts.dart';
import 'package:musico_scratch/openAssetAudio/openAssetAudio.dart';
import 'package:musico_scratch/screens/NowPlaying.dart';
import 'package:musico_scratch/screens/ScreenFolders.dart';
import 'package:musico_scratch/Home/HomeArtists.dart';
import 'package:musico_scratch/Home/HomePlaylists.dart';
import 'package:musico_scratch/screens/ScreenSettings.dart';
import 'package:musico_scratch/Home/HomeSongs.dart';
import 'package:musico_scratch/screens/screenSearch.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:swipe_to/swipe_to.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

// for Tab Bar  using multiple inheritence(mixin)

class _HomeTabState extends State<HomeTab> with TickerProviderStateMixin {
  late TabController _tabController;
  int? index = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);

    //to change the tab bar
    _tabController.addListener(_handleTabSelection);

    requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomSheet: SizedBox(
          height: 60,
          child:

              //using builderCurrent take the current playing Audio
              assetsAudioPlayer.builderCurrent(
            builder: (BuildContext context, Playing? playing) {
              
              //  got the current playing audio in "databaseAudioList"
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
                  color: Colors.grey,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: CircleAvatar(
                          child: QueryArtworkWidget(
                            id: int.parse(currentPlayingAudio.metas.id!),
                            type: ArtworkType.AUDIO,
                            artworkBorder:
                                const BorderRadius.all(Radius.circular(28)),
                            artworkFit: BoxFit.cover,
                            nullArtworkWidget:
                                const Icon(FontAwesomeIcons.music),
                          ),
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
                                Text(
                                  currentPlayingAudio.metas.title!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  currentPlayingAudio.metas.artist!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Poppins'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              assetsAudioPlayer.previous();
                            },
                            icon: const Icon(FontAwesomeIcons.stepBackward),
                          ),
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
                                );
                              }),
                          GestureDetector(
                            child: IconButton(
                              onPressed: () {
                                assetsAudioPlayer.next();
                              },
                              icon: const Icon(FontAwesomeIcons.stepForward),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
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
                  // print('==================${gotPath}=======================');

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
      ),
    );
  }

  void requestPermission() async {
    var requestStatus = await Permission.storage.status;
    if (requestStatus.isDenied) {
      Permission.storage.request();
    }
  }

  void _handleTabSelection() {
    setState(() {});
  }
}
