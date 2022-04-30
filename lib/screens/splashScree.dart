import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:musico_scratch/database/dbSongs.dart';
import 'package:musico_scratch/moved/HomePage.dart';
import 'package:musico_scratch/Home/HomeTab.dart';
import 'package:musico_scratch/Home/HomeSongs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    fetchsongs();
    fetchArtist();
    // fetchAllFavourites();
    navigate();
  }

  final _audioQuery = new OnAudioQuery();
  final box = MusicBox.getInstance(); //check

  navigate() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>HomeTab(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () {
            print('=======gotpath=============${gotPath}==========================');
          },
          child: Center(
            child: Image.asset('assets/images/muzify.png'),
          )),
    );
  }

  void fetchArtist() async {
    List<ArtistModel> fetchallArtists = await _audioQuery.queryArtists();
    for (var song in fetchallArtists) {
      // print('{=====================${song}===================}');
      if (song.artist != '<unknown>') {
        allArtistsSet.add(song);
      }
    }

    // box.put('artists', value);
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
