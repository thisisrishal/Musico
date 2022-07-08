import 'package:flutter/material.dart';
import 'package:musico_scratch/main_page/widgets/customTexts.dart';
import 'package:musico_scratch/presentation/artists/widgets/listArtistSongs.dart';
import 'package:musico_scratch/presentation/songs/songs.dart';

class ScreenArtists extends StatelessWidget {
  const ScreenArtists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: allArtists.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => listArtistsongs(
                        newIndex: index,
                        ArtistName: allArtists[index].artist,
                      )),
                ),
              );
            },
            title: normalText(allArtists[index].artist, color: Colors.white),
            trailing: Icon(
              Icons.navigate_next,
              color: Colors.white,
            ),
          );
        });
  }
}
