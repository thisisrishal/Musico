import 'package:flutter/material.dart';
import 'package:musico_scratch/database/dbSongs.dart';

class editPlaylist extends StatefulWidget {
  String playlistName;

  editPlaylist({Key? key, required this.playlistName}) : super(key: key);

  @override
  State<editPlaylist> createState() => _editPlaylistState();
}

class _editPlaylistState extends State<editPlaylist> {
  String _newPlaylistName = '';
  final _box = MusicBox.getInstance();
  // final _box1 = MusicBox1.getInstance();


  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // const Padding(
          //   padding: EdgeInsets.only(
          //     right: 20,
          //     left: 20,
          //     top: 20,
          //   ),
          //   child:
          //    Text(
          //     " playlist name.",
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 18,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
          //       fontFamily: 'Poppins',
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 10,
            ),
            child: Form(
              key: formkey,
              child: TextFormField(
                initialValue: widget.playlistName,
                // cursorHeight: 25,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style:  TextStyle(
                  color: Colors.grey[600],
                  fontSize: 20,
                ),
                onChanged: (value) {
                  _newPlaylistName = value.trim();
                },
                validator: (value) {
                  List keys = _box.keys.toList();
                  if (value!.trim() == "") {
                    return "name Required";
                  }
                  if (keys
                      .where((element) => element == value.trim())
                      .isNotEmpty) {
                    return "this name already exits";
                  }
                  return null;
                },
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15,
                    top: 5,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15,
                    top: 5,
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        List? playlists = _box.get(widget.playlistName);
                        _box.put(_newPlaylistName, playlists!);
                        _box.delete(widget.playlistName);
                        Navigator.pop(context);
                      }
                    },
                    child: const Center(
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
