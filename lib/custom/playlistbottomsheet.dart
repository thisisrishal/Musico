import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:musico_scratch/custom/ListSongs.dart';
import 'package:musico_scratch/moved/addToPlaylist.dart';
import 'package:musico_scratch/custom/customTexts.dart';
import 'package:musico_scratch/database/dbSongs.dart';

import 'customBottomSheet.dart';

playListbottomSheet(context, songId) {
  final box = MusicBox1.getInstance();
  List<dbSongs> FunctionSongs = [];
  List<Audio> fullSongs = []; 

  dbSongs databaseSongs(List<dbSongs> songs, String id) {
    return songs.firstWhere(
      (element) => element.id.toString().contains(id),
    );
  }

  final temp = databaseSongs(FunctionSongs, songId);
  return showModalBottomSheet(
    // barrierColor: Colors.black12,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
    backgroundColor: Color.fromARGB(255, 48, 48, 48),
    context: context,
    builder: (context) {
      return Container();
      // AddtoPlayList(song: temp);

      // return Wrap(
      //   children: [
      //     ListSongs(
      //       title: normalText('Play '),
      //       leading_widget: Icon(
      //         Icons.skip_next_outlined,
      //         color: Colors.white,
      //       ),
      //     ),
      //     InkWell(
      //       onTap: () {
      //         bottomSheet(context);
      //       },
      //       child: ListSongs(
      //         title: normalText('Add to '),
      //         leading_widget: Icon(
      //           Icons.playlist_add_outlined,
      //           color: Colors.white,
      //         ),
      //       ),
      //     ),
      //     ListSongs(
      //       title: normalText('Add to '),
      //       leading_widget: Icon(
      //         Icons.favorite_border_outlined,
      //         color: Colors.white,
      //       ),
      //     ),
      //     ListSongs(
      //       title: normalText('Share'),
      //       leading_widget: Icon(
      //         Icons.share_outlined,
      //         color: Colors.white,
      //       ),
      //     ),
      //     ListSongs(
      //       title: normalText('Set sleep timer'),
      //       leading_widget: Icon(
      //         Icons.schedule_outlined,
      //         color: Colors.white,
      //       ),
      //     ),
      //     ListSongs(
      //       title: normalText('Delete'),
      //       leading_widget: Icon(
      //         Icons.delete_outlined,
      //         color: Colors.white,
      //       ),
      //     ),
      //   ],
      // );
    },
  );
}
