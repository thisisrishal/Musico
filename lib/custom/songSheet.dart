import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../database/dbSongs.dart';
import '../screens/PlaylistSongs.dart';
import '../Home/HomeSongs.dart';


class BottomSheetWidget extends StatefulWidget {
  final String? playListName;
  BottomSheetWidget({Key? key, this.playListName}) : super(key: key);

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  final box = MusicBox.getInstance();
  final box1 = MusicBox1.getInstance();

  fullSongs() {
    SongsList = box.get("musics") as List<dbSongs>;
    playlistSongs = box1.get(widget.playListName)!.cast<dbSongs>();
  }

  @override
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
        trailing: 
        
        
        playlistSongs
                .where((element) =>
                    element.id.toString() == SongsList[index].id.toString())
                .isEmpty
            ? IconButton(
                onPressed: () async {
                  playlistSongs.add(SongsList[index]);
                  await box.put(widget.playListName, playlistSongs);

                  setState(() {});
                },
                icon: const Icon(Icons.add))
            : IconButton(
                onPressed: () async {
                  playlistSongs.removeWhere((elemet) =>
                      elemet.id.toString() == SongsList[index].id.toString());

                  await box.put(widget.playListName, playlistSongs);
                  setState(() {});
                },
                icon: const Icon(Icons.check_box),
              ),

        //  InkWell(
        //     onTap: (() {

        //         tick = true;
        //       setState(() {

        //       });

        //     }),
        //     child: tick == true
        //         ? Container(
        //             height: 30,
        //             width: 30,
        //             color: Colors.red,
        //           )
        //         : Container(
        //             height: 30,
        //             width: 30,
        //             color: Colors.green,
        //           )),

        //     IconButton(
        //   onPressed: () {
        //     print(SongsList[index]);

        //     playlistSongs.add(SongsList[index]);

        //      setState(() {});
        //     // Navigator.push(
        //     //     context,
        //     //     MaterialPageRoute(
        //     //         builder: (context) => PlaylistSongs(
        //     //               songIndex: index,
        //     //             )));
        //     print(index);
        //     // return bottomSheet(context);
        //   },
        //   icon: Icon(Icons.more_horiz_rounded),
        //   color: Colors.white,
        // ),
      ),
      itemCount: recievedDatabaseSongs.length,
    );
  }
}
