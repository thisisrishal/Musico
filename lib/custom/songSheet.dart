import 'package:flutter/material.dart';
import 'package:musico_scratch/database/dbSongs.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../screens/NowPlaying2.dart';
import '../screens/ScreenSongHome.dart';

class songSheet extends StatefulWidget {
  String playlistName;
  songSheet({Key? key, required this.playlistName}) : super(key: key);

  @override
  State<songSheet> createState() => _songSheetState();
}

class _songSheetState extends State<songSheet> {
  @override
  final box = MusicBox.getInstance();

  List<dbSongs> SongsList = []; //get from the database
  List<dbSongs> playlistSongs = [];
  @override
  void initState() {
    super.initState();
    fullSongs();
  }

  fullSongs() {
    SongsList = box.get("musics") as List<dbSongs>;
    playlistSongs = box.get(widget.playlistName)!.cast<dbSongs>();
  }

  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: ((context) {
          //       return NowPlaying2(index: index, allSongs: databaseAudioList);
          //     }),
          //   ),
          // );
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
          onPressed: () {
            
            print(index);
            // return bottomSheet(context);
          },
          icon: Icon(Icons.more_horiz_rounded),
          color: Colors.white,
        ),
      ),
      itemCount: recievedDatabaseSongs.length,
    );
  }
}






// showModalBottomSheet(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(21)),
//                       backgroundColor: Color.fromARGB(255, 48, 48, 48),
//                       context: context,
//                       builder: (context) {
//                         return ListView.builder(
//                           itemCount: databaseSongs.length,
//                           itemBuilder: (context, index1) {
//                             return

//                           },
//                         );
//                       });

// final box = MusicBox.getInstance();
