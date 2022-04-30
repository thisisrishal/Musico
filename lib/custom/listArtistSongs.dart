import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musico_scratch/database/dbSongs.dart';

import 'package:musico_scratch/screens/NowPlaying2.dart';
import 'package:musico_scratch/Home/HomeSongs.dart';
import 'package:on_audio_query/on_audio_query.dart';

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
                for (var song in databaseAudioList) {
                  if (song.metas.artist == allArtists[widget.newIndex].artist) {
                    allArtistSongsAudio.add(Audio.file(
                      song.metas.artist.toString(),
                      metas: Metas(
                        title: song.metas.title,
                        artist: song.metas.artist,
                        id: song.metas.id.toString(),
                      ),
                    ));
                  }
                }
                allArtistSongs = allArtistSongsAudio.toList();

                return ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => NowPlaying2(
                                index: index,
                                allSongs: databaseAudioList,
                                songId: allSongs[index].id.toString(),
                              )),
                        ),
                      ),
                      child: ListTile(
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
                            id: int.parse(allArtists[index].id.toString()),
                            type: ArtworkType.AUDIO,
                          ),
                        ),
                        title: SizedBox(
                          width: 200,
                          height: 40,
                          child: Text(
                            allArtistSongs[index].metas.title.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        subtitle: Text(
                          allArtistSongs[index].metas.title.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: PopupMenuButton(
                          icon: Icon(
                            Icons.more_vert_outlined,
                            color: Colors.white,
                          ),
                          itemBuilder: (BuildContext context) => [
                            const PopupMenuItem(
                              value: "1",
                              child: Text(
                                "Remove song",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                          onSelected: (value) {
                            if (value == "1") {
                              setState(() {});
                            }
                          },
                        ),
                      ),
                    );
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
