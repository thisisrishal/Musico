import 'package:flutter/material.dart';
import 'package:musico_scratch/database/dbSongs.dart';
import 'package:musico_scratch/screens/ScreenSongHome.dart';
import 'package:on_audio_query/on_audio_query.dart';

class listPathSongs extends StatefulWidget {
  final int index;

  listPathSongs({Key? key, required this.index}) : super(key: key);

  @override
  State<listPathSongs> createState() => _listPathSongsState();
}

class _listPathSongsState extends State<listPathSongs> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List<String> pathList;
    List<String> _getSplitPath = [];
// List<String> gotPathnew = [];

    // String path = '';

    // for (var i = 0; i < allSongs.length; i++) {
    //   path = allSongs[i].data;
    //   List<String> _getSplitPath;
    //   _getSplitPath = path.split('/');
    //   gotPathnew.add(_getSplitPath[_getSplitPath.length - 2]);
    // }
    // gotPathnew = gotPathset.toList();
    // print('========pth=========${gotPathnew}========================');

// \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\?
    // allSongs.forEach((element1) {
    //   String _path = element1.data.toString();
    //   _getSplitPath = _path.split('/').toList();

    //   if (_getSplitPath[_getSplitPath.length - 2] == gotPath[widget.index]) {
    //        print(
    //         '===========_getSplitPath.length - 2================${_getSplitPath[_getSplitPath.length - 2]}=======================');
    //     print(
    //         '===========gotPath[widget.index]================${gotPath[widget.index]}=======================');

    //     print(
    //         '===========element================${element1.id}=======================');
    //          print(
    //         '===========next=======================================');
    //     pathSongList.add(element1);
    //   }
    // }
    // );
    // \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\?

    // print(
    //     '===========ererererer================${pathSongList.length}=======================');
    // pathSongList = pathSongListset.toList();
    // Set<SongModel> setnew1 = {};
    // pathSongList.firstWhere((element) {
    //   return
    // });
    print(
        '===========allsongs================${fetchedSongs.length}=======================');
    for (var i = 1; i < allSongs.length; i++) {
      String _path = allSongs[i].data.toString();
      _getSplitPath = _path.split('/').toList();

      if (_getSplitPath[_getSplitPath.length - 2] == gotPath[widget.index]) {
        print(
            '===========_getSplitPath.length - 2================${_getSplitPath[_getSplitPath.length - 2]}=======================');

        print(
            '===========gotPath[widget.index]================${gotPath[widget.index]}=======================');

        print(
            '===========element================${allSongs[i].id}=======================');
        print('===========next=======================================');
        pathSongList.add(allSongs[i]);
      }
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {},
                title: Text(pathSongList[index].title),
                // subtitle: Text(index.toString()),
              );
              // newfunction(index);
              // return ListTile(
              //   title: GestureDetector(
              //       onTap: () {
              //         print('====ontap==========${pathSongList[index].title}==================');
              //       },
              //       child: Text(pathSongList[index].title)),
              //   leading: Container(
              //     // decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),color: Colors.white30,),
              //     height: 43,
              //     width: 43,

              //     // color: Colors.grey,
              //     child: QueryArtworkWidget(
              //       artworkBorder: BorderRadius.all(Radius.circular(7)),
              //       // artworkClipBehavior: Clip.antiAliasWithSaveLayer,
              //       artworkFit: BoxFit.fill,
              //       nullArtworkWidget: Container(
              //           child: Image.asset(
              //         'assets/images/muzify.png',
              //         color: Colors.white30,
              //       )),
              //       id: int.parse(pathSongList[index].id.toString()),
              //       type: ArtworkType.AUDIO,
              //     ),
              //   ),
              // );
            },
            itemCount: (pathSongList.length),
          ),
        ),
      ),
    );
  }

//   fetchSongs(temp) {
  Set<SongModel> pathSongListset = {};
  List<dynamic> pathSongList = [];
}
