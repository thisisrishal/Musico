import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:musico_scratch/database/dbSongs.dart';
import 'package:musico_scratch/moved/MusicListMenu.dart';
import 'package:musico_scratch/openAssetAudio/openAssetAudio.dart';
import 'package:musico_scratch/screens/NowPlaying.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScreenSongHome extends StatefulWidget {
  ScreenSongHome({Key? key}) : super(key: key);



  @override
  State<ScreenSongHome> createState() => _ScreenSongHomeState();
}

class _ScreenSongHomeState extends State<ScreenSongHome> {
  @override
  void initState() {
    super.initState();
  }

  final _audioQuery = new OnAudioQuery();

  final box = MusicBox.getInstance(); //check

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<SongModel>>(
        // SongModel comes from  on_audio_query

        future: _audioQuery.querySongs(
          // to fetch songs querySongs
          sortType: SongSortType.DATE_ADDED,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, item) {
          // print('--------------{$context  } ------${item} ---------');

          // here item is the index one_by_one song get her1

          if (item.data == null) {
            // Data is the last value/song get in item

            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (item.data!.isEmpty) {
            return Center(
              child: TextButton(
                  onPressed: () async {},
                  child: Text(
                    'No Songs',
                    style: TextStyle(color: Colors.grey),
                  )),
            );
          }

          return ListView.builder(
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                OpenPlayer(fullSongs: databaseAudioList, index: index)
                    .openAssetPlayer(index: index, songs: databaseAudioList);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) {
                      return NowPlaying(
                        songList: databaseAudioList,
                        songId: allSongs[index].id.toString(),
                      );
                    }),
                  ),
                );

                
              },

              leading: Container(
                height: 43,
                width: 43,

                child: QueryArtworkWidget(
                  artworkBorder: BorderRadius.all(Radius.circular(7)),
                  artworkFit: BoxFit.fill,
                  nullArtworkWidget: Container(
                      child: Image.asset(
                    'assets/images/muzify.png',
                    color: Colors.white30,
                  )),
                  id: int.parse(allSongs[index].id.toString()),
                  type: ArtworkType.AUDIO,
                ),
              ),

              title: SizedBox(
                width: 200,
                child: Text(
                  recievedDatabaseSongs[index].title.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ), 
              subtitle: Text(
                "${recievedDatabaseSongs[index].artist}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: MusicListMenu(
                songId: databaseAudioList[index].metas.id.toString(),
                index: index,
              ),
            ),
            itemCount: recievedDatabaseSongs.length,
          );
        },
      ),
    );
  }
}

List<SongModel> fetchedSongs = [];
List<SongModel> allSongs = [];
List<dbSongs> mappedSongs = [];
List<dbSongs> recievedDatabaseSongs = [];
List<Audio> databaseAudioList = [];
List<Audio> favouriteSongsAudio = [];
List<dynamic>? likedSongs = [];
Set<ArtistModel> allArtistsSet = {};
List<ArtistModel> allArtists = allArtistsSet.toList();
Set<String> gotPathset = {};

List<String> gotPath = [];
