import 'package:flutter/material.dart';
import 'package:musico_scratch/custom/customTexts.dart';
import 'package:musico_scratch/custom/listPathSongs.dart';
import 'package:musico_scratch/presentation/songs/songs.dart';

class ScreenAlbums extends StatefulWidget {
  const ScreenAlbums({Key? key}) : super(key: key);

  @override
  State<ScreenAlbums> createState() => _ScreenAlbumsState();
}

class _ScreenAlbumsState extends State<ScreenAlbums> {
  @override
  void initState() {
    super.initState();
    accessPath();

  }

  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: ListView.builder(itemBuilder: (context, index) 
        {
          
          return ListTile(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => listPathSongs(index: index)),
                ),
              ),
            title: normalText(
              gotPath[index],color: Colors.white
            ),
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
          );
          
        },
        itemCount: gotPath.length,),
      ),
    );
  }
    void accessPath() {
    for (var i = 0; i < allSongs.length; i++) {
      String _path = allSongs[i].data;
      List<String> _getSplitPath;
      _getSplitPath = _path.split('/');
      gotPathset.add(_getSplitPath[_getSplitPath.length - 2]);
    }
    gotPath = gotPathset.toList();
    // print('=================${gotPath}========================');
  }
}
