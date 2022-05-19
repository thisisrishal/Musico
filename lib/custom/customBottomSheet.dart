import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:musico_scratch/custom/ListSongs.dart';
import 'package:musico_scratch/custom/customTexts.dart';
import 'package:musico_scratch/custom/playlistbottomsheet.dart';
import 'package:musico_scratch/presentation/songs/songs.dart';

bottomSheethomePage(context, index) {
  // List<Audio> getAllSongsForBottomSheet = [];
  return showModalBottomSheet(
    // barrierColor: Colors.black12,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
    backgroundColor: Color.fromARGB(255, 48, 48, 48),
    context: context,
    builder: (context) {
      return Wrap(
        children: [
          ListSongs(
            title: normalText('Play next'),
            leading_widget: Icon(
              Icons.skip_next_outlined,
              color: Colors.white,
            ),
          ),
          InkWell(
            onTap: () {
              // Navigator.pushAndRemoveUntil(
              // context, playListbottomSheet(context), (route) => false);
              String songId = databaseAudioList[index].metas.id.toString();
              playListbottomSheet(context, songId);
            },
            child: ListSongs(
              title: normalText('Add to playlist'),
              leading_widget: Icon(
                Icons.playlist_add_outlined,
                color: Colors.white,
              ),
            ),
          ),
          ListSongs(
            title: normalText('Add to favorites'),
            leading_widget: Icon(
              Icons.favorite_border_outlined,
              color: Colors.white,
            ),
          ),
          ListSongs(
            title: normalText('Share'),
            leading_widget: Icon(
              Icons.share_outlined,
              color: Colors.white,
            ),
          ),
          ListSongs(
            title: normalText('Set sleep timer'),
            leading_widget: Icon(
              Icons.schedule_outlined,
              color: Colors.white,
            ),
          ),
          ListSongs(
            title: normalText('Delete'),
            leading_widget: Icon(
              Icons.delete_outlined,
              color: Colors.white,
            ),
          ),
        ],
      );
    },
  );
}
