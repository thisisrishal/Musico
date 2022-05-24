import 'package:flutter/material.dart';
import 'package:musico_scratch/presentation/playlists/widgets/PlaylistSongs.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../database/dbSongs.dart';
import '../../songs/songs.dart';

bool rebuild = false;

class TrailingButtonBottomsheet extends StatefulWidget {
  // final int index;
  final String? playListName;

  TrailingButtonBottomsheet({Key? key,  this.playListName})
      : super(key: key);

  @override
  State<TrailingButtonBottomsheet> createState() =>
      _TrailingButtonBottomsheetState();
}

class _TrailingButtonBottomsheetState extends State<TrailingButtonBottomsheet> {
  final box = MusicBox.getInstance();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      rebuild = false;
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
              'assets/images/bacground_icon.jpg',
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
        trailing: playlistSongs
                .where((element) =>
                    element.id.toString() == SongsList[index].id.toString())
                .isEmpty
            ? IconButton(
                onPressed: () async {
                  playlistSongs.add(SongsList[index]);
                  await box.put(widget.playListName, playlistSongs);

                },
                icon: const Icon(Icons.add))
            : IconButton(
                onPressed: () async {
                  playlistSongs.removeWhere((elemet) =>
                      elemet.id.toString() == SongsList[index].id.toString());

                  await box.put(widget.playListName, playlistSongs);
                    rebuild = true;
                },
                icon: const Icon(Icons.check_box),
              ),

      
      ),
      itemCount: recievedDatabaseSongs.length,
    );
  }
}
