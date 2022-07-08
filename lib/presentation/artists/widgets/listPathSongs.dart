import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:musico_scratch/main_page/NowPlaying.dart';
import 'package:musico_scratch/presentation/songs/songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../main_page/widgets/play_song.dart';

class listPathSongs extends StatefulWidget {
  final int index;

  listPathSongs({Key? key, required this.index}) : super(key: key);

  @override
  State<listPathSongs> createState() => _listPathSongsState();
}

class _listPathSongsState extends State<listPathSongs> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Set<Audio> folderSongSet = {};
    List<Audio> folderSongList = [];

    // // List<String> pathList;
    List<String> _SplittedPath = [];
    // List<Audio> newList = [];

    for (var i = 0; i < allSongs.length; i++) {
      String _path = allSongs[i].data.toString();
      _SplittedPath = _path.split('/').toList();

      if (_SplittedPath[_SplittedPath.length - 2] == gotPath[widget.index]) {
        print(
            '${_SplittedPath[_SplittedPath.length - 2]}==========================> ${gotPath[widget.index]}');

        for (int j = 0; j < databaseAudioList.length; j++) {
          if (databaseAudioList[j].metas.id.toString() ==
              allSongs[i].id.toString()) {
            print('kittiyedaaaaaaaaaaaaaa');
            folderSongSet.add(databaseAudioList[j]);
          }
        }
      }
    }
    print('folderSongSet: ${folderSongSet.length}');
    print(folderSongSet);

    folderSongList = folderSongSet.toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          gotPath[widget.index],
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Container(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: GestureDetector(
                    onTap: () {
                      // print('--------------${pathSongList[index]}');
                      OpenPlayer(fullSongs: folderSongList, index: index)
                          .openAssetPlayer(index: index, songs: folderSongList);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => NowPlaying(
                              songList: folderSongList,
                              songId: databaseAudioList[index]
                                  .metas
                                  .id
                                  .toString())),
                        ),
                      );
                    },
                    child: Text(folderSongList[index].metas.title.toString())),
                leading: Container(
                  // decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),color: Colors.white30,),
                  height: 43,
                  width: 43,

                  // color: Colors.grey,
                  child: QueryArtworkWidget(
                    artworkBorder: BorderRadius.all(Radius.circular(7)),
                    // artworkClipBehavior: Clip.antiAliasWithSaveLayer,
                    artworkFit: BoxFit.cover,
                    nullArtworkWidget: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Color(0xff404040),
                      ),
                      height: 45,
                      width: 45,
                      child: Icon(
                        Icons.music_note_outlined,
                        color: Colors.white60,
                      ),
                    ),
                    id: int.parse(folderSongList[index].metas.id.toString()),
                    type: ArtworkType.AUDIO,
                  ),
                ),
              );
            },
            itemCount: (folderSongList.length),
          ),
        ),
      ),
    );
  }

//   fetchSongs(temp) {
  Set<SongModel> pathSongset = {};
  List<dynamic> pathSongList = [];
}
