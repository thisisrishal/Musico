import 'package:flutter/material.dart';
import 'package:musico_scratch/custom/customTexts.dart';

class ScreenAlbums extends StatelessWidget {
  const ScreenAlbums({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: ListView(
        children: [
          ListTile(
            trailing: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Color(0xff404040),
              ),
              height: 45,
              width: 45,
              child: Icon(
                Icons.music_note_outlined,
                color: Colors.white60,
              ),
            ),
            title: normalText(
              'Download',
            ),
          ),
          ListTile(
            trailing: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Color(0xff404040),
              ),
              height: 45,
              width: 45,
              child: Icon(
                Icons.music_note_outlined,
                color: Colors.white60,
              ),
            ),
            title: normalText('WhatsApp Audio'),
          ),
          ListTile(
            trailing: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Color(0xff404040),
              ),
              height: 45,
              width: 45,
              child: Icon(
                Icons.music_note_outlined,
                color: Colors.white60,
              ),
            ),
            
            title: normalText('Unknown'),
          )
        ],
      ),
    );
  }
}
