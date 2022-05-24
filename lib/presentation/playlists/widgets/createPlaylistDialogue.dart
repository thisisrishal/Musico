import 'package:flutter/material.dart';
import 'package:musico_scratch/database/dbSongs.dart';

class createPlaylistDialogue extends StatefulWidget {
  const createPlaylistDialogue({Key? key}) : super(key: key);

  @override
  State<createPlaylistDialogue> createState() => _createPlaylistDialogueState();
}

class _createPlaylistDialogueState extends State<createPlaylistDialogue> {
  List<dbSongs> playlists = [];

  final box = MusicBox.getInstance();
  // final box1 = MusicBox1.getInstance();

  String? title;

  final formkey = GlobalKey<FormState>();

  // var ListplaylistTitles = [];
  // var textfieldController = TextEditingController();
  String? playlistTitle;

  @override
  Widget build(BuildContext context) {
    // show the dialogue
    return Dialog(
      //   insetAnimationCurve: Curves.decelerate,
      // insetAnimationDuration: Duration(seconds: 100),
      shape: Border.all(
        width: 4,
        color: Colors.black12,
      ),
      backgroundColor: Colors.white,
      child: SizedBox(
        height: 200,
        width: 150,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: 20,
                left: 20,
                top: 20,
              ),
              child: Text(
                'Enter playlist name',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),

            //creating a text filed
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formkey,
                child: TextFormField(
                  // controller: textfieldController,
                  onChanged: (value) {
                    //getname
                    playlistTitle = value.trim();
                  },
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.pop(context);
                  //   },
                  //   child: Text("cancel"),
                  //   style: ElevatedButton.styleFrom(
                  //       primary: Colors.grey,
                  //       visualDensity: VisualDensity(hozzontal: 2)),
                  // ),
                  ElevatedButton(
                    onPressed: () {
                      // box.put(key, value)
                      box.put(playlistTitle, playlists);
                      // box1.put(playlistTitle, playlists);
                      // print('----------${playlistTitle}--------------');
                      Navigator.pop(context);
                      // print{ListplaylistTitles}-------------');
                      // return Navigator.pop(context);
                    },
                    child: Text("save"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      visualDensity: VisualDensity(horizontal: 3.5),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
