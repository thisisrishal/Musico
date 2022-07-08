import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musico_scratch/database/dbSongs.dart';
import 'package:musico_scratch/main_page/NowPlaying.dart';

import 'package:musico_scratch/presentation/songs/songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../main_page/widgets/play_song.dart';

class listArtistsongs extends StatefulWidget {
  final int newIndex;
  final String ArtistName;
  listArtistsongs({Key? key, required this.newIndex, required this.ArtistName})
      : super(key: key);

  @override
  State<listArtistsongs> createState() => _listFavouriteSongsState();
}

class _listFavouriteSongsState extends State<listArtistsongs> {
  final box = MusicBox.getInstance();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.ArtistName,
        ),
        elevation: 0.0,
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: Expanded(
          child: ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (context, value, child) {
                // Set<Audio> allArtistSongs = {};
                Set<Audio> allArtistSongsAudio = {};

                List<Audio> allArtistSongs = [];

                // print('***********777***********');

                for (var song in databaseAudioList) {
                  if (song.metas.artist == allArtists[widget.newIndex].artist) {
                    allArtistSongsAudio.add(song);
                  }
                }
                // List<SongModel> allArtistsSongsSongModel = [];

                // for (var song in fetchedSongs) {
                //   if (song.artist == allArtists[widget.newIndex].artist) {
                //     allArtistsSongsSongModel.add(song);
                //     print('printiiiiiiiiiiiiiiiiiii');
                //     print(song);
                //   }
                // }
                allArtistSongs = allArtistSongsAudio.toList();

                List<SongModel> artistsongModel = [];

                return ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          OpenPlayer(fullSongs: allArtistSongs, index: index)
                              .openAssetPlayer(
                                  index: index, songs: allArtistSongs);

                          Future.delayed(Duration(seconds: 5));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NowPlaying(
                                songList: allArtistSongs,
                                songId: allSongs[index].id.toString(),
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: Container(
                            height: 43,
                            width: 43,
                            child: QueryArtworkWidget(
                              artworkBorder:
                                  BorderRadius.all(Radius.circular(7)),
                              artworkFit: BoxFit.cover,
                              nullArtworkWidget: Container(
                                  child: Image.asset(
                                'assets/images/musical-note (1).png',
                                color: Colors.white30,
                              )),
                              id: int.parse(
                                  allArtistSongs[index].metas.id.toString()),
                              type: ArtworkType.AUDIO,
                            ),
                          ),
                          title: Text(
                            allArtistSongs[index].metas.title.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            allArtistSongs[index].metas.title.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ));
                  },
                  itemCount: allArtistSongs.length,
                );
              }),
        ),
      ),
    ));
  }
}

// return Container(height:10,width: 60,color: Colors.blue,child: Text('data'),);
