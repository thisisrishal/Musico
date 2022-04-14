import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:musico_scratch/database/dbSongs.dart';
import 'package:musico_scratch/screens/NowPlaying2.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScreenSongHome extends StatefulWidget {
  ScreenSongHome({Key? key}) : super(key: key);

  @override
  State<ScreenSongHome> createState() => _ScreenSongHomeState();
}

class _ScreenSongHomeState extends State<ScreenSongHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchsongs();
  }

  final _audioQuery = new OnAudioQuery();

  List<SongModel> fetchedSongs = [];
  List<SongModel> allSongs = [];
  List<dbSongs> mappedSongs = [];
  List<dbSongs> recievedDatabaseSongs = [];
  List<Audio> databaseAudioList = [];

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
          // here item is the index one_by_one song get here

          if (item.data == null) {
            // Data is the last value/song get in item

            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (item.data!.isEmpty) {
            return Center(
              child: Text('No Songs '),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) {
                      return NowPlaying2(
                          index: index, allSongs: databaseAudioList);
                    }),
                  ),
                );
                // openPlayer(audios, index);
              },

              leading: Container(
                // decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),color: Colors.white30,),
                height: 43,
                width: 43,

                // color: Colors.grey,
                child: QueryArtworkWidget(
                  artworkBorder: BorderRadius.all(Radius.circular(7)),
                  // artworkClipBehavior: Clip.antiAliasWithSaveLayer,
                  artworkFit: BoxFit.fill,
                  nullArtworkWidget: Container(
                      
                      
                      child: Image.asset('assets/images/muzify.png',color: Colors.white30,)),
                  id: int.parse(allSongs[index].id.toString()),
                  type: ArtworkType.AUDIO,
                ),
              ),

              title: SizedBox(
                width: 200,
                height: 40,
                child: Text(
                  recievedDatabaseSongs[index].title.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ), // check display name also
              subtitle: Text(
                "${recievedDatabaseSongs[index].artist}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_horiz_rounded),
                color: Colors.white,
              ),
            ),
            itemCount: recievedDatabaseSongs.length,
          );
        },
      ),
    );
  }

  fetchsongs() async {
    fetchedSongs = await _audioQuery.querySongs();

    for (var song in fetchedSongs) {
      if (song.fileExtension == 'mp3') {
        allSongs.add(song);
      }
      // return allSongs;
    }

    // get all the item in dbSongs as a key
    mappedSongs = allSongs
        .map(
          (audio) => dbSongs(
            title: audio.title,
            artist: audio.artist,
            uri: audio.uri,
            duration: audio.duration,
            id: audio.id,
          ),
        )
        .toList();

    // print('-----------------${mappedSongs}');

    await box.put('musics', mappedSongs);
    recievedDatabaseSongs = box.get('musics') as List<dbSongs>;

    for (var element in recievedDatabaseSongs) {
      databaseAudioList.add(
        Audio.file(element.uri.toString(),
            metas: Metas(
                title: element.title,
                artist: element.artist,
                id: element.id.toString())),
      );
    }
    setState(() {});
  }
}
