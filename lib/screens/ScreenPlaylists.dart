import 'package:flutter/material.dart';
import 'package:musico_scratch/custom/listOfPlaylist.dart';

class ScreenPlaylists extends StatelessWidget {
  const ScreenPlaylists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            ListView(
              children: [
                listofPlaylists(
                  leadingIcon: Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                  leadingColor: Color(0xffdb5960),
                  title: 'Favourites',
                ),
                listofPlaylists(
                  leadingIcon: Icon(Icons.watch_later),
                  leadingColor: Color(0xffba9e84),
                  title: 'Recently Played',
                ),
                listofPlaylists(
                  title: 'Playlist 1',
                ),
                listofPlaylists(
                  leadingColor: Color(0xff3d3d3d),
                  title: 'Playlist 2',
                ),
              ],
            ),
            Positioned(
                right: 10,
                bottom: 60,
                child: FloatingActionButton(
                  onPressed: () {},
                  child: Icon(Icons.add),
                ))
          ],
        ),
      ),
    );
  }
}
