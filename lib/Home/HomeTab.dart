import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:musico_scratch/custom/customTexts.dart';
import 'package:musico_scratch/screens/NowPlaying2.dart';
import 'package:musico_scratch/screens/ScreenFolders.dart';
import 'package:musico_scratch/Home/HomeArtists.dart';
import 'package:musico_scratch/Home/HomePlaylists.dart';
import 'package:musico_scratch/screens/ScreenSettings.dart';
import 'package:musico_scratch/Home/HomeSongs.dart';
import 'package:musico_scratch/screens/bottomSheetQdr.dart';
import 'package:musico_scratch/screens/screenSearch.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:swipe_to/swipe_to.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with TickerProviderStateMixin {
  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);

    requestPermission();
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

  @override
  Widget build(BuildContext context) {
    int? index;
    final AssetsAudioPlayer assetAudioPlayer = AssetsAudioPlayer.withId("0");

    // Audio? currentSong;
    // int currentIndex = 1;
    return SafeArea(
      child: Scaffold(
        bottomSheet: GestureDetector(
          onTap: (() {}),
          child: SizedBox(
            height: 60,
            child: assetAudioPlayer.builderCurrent(
              builder: (BuildContext context, Playing? playing) {
                final myAudio =
                    find(databaseAudioList, playing!.audio.assetAudioPath);

                return GestureDetector(
                  onTap: () {
                    // var gotId = gotId() {
                      for (int i = 0; i < databaseAudioList.length; i++) {
                        if (databaseAudioList[i].metas.id == myAudio.metas.id!) {
                          index = i;
                        }
                      }
                      // return 0;
                    // };
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NowPlaying2(
                              index: index!,
                              allSongs: databaseAudioList,
                              songId: allSongs[index!].id.toString())),
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
                              id: int.parse(myAudio.metas.id!),
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
                                assetAudioPlayer.next();
                              },
                              onRightSwipe: () {
                                assetAudioPlayer.previous();
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    myAudio.metas.title!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.black,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    
                                    myAudio.metas.artist!,
                                    
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.black,

                                        fontSize: 12, fontFamily: 'Poppins'),
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
                                assetAudioPlayer.previous();
                              },
                              icon: const Icon(FontAwesomeIcons.stepBackward),
                            ),
                            PlayerBuilder.isPlaying(
                                player: assetAudioPlayer,
                                builder: (context, isPlaying) {
                                  return IconButton(
                                    onPressed: () async {
                                      await assetAudioPlayer.playOrPause();
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
                                  assetAudioPlayer.next();
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
}
