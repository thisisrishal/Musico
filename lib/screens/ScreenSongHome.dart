import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScreenSongHome extends StatelessWidget {
  final _audioQuery = new OnAudioQuery();

  ScreenSongHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<SongModel>>(
        // SongModel comes from  on_audio_query
        future: _audioQuery.querySongs(
          // to fetch songs querySongs
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, item) {
          // here item is the index one_by_one song get here

          if (item.data == null) {
            // Data is the last value/song get in item

            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (item.data!.isEmpty) {
            return Center(
              child: Text('No Songs '),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) => ListTile(
              leading: Container(height: 30, width: 30),
              title: Text(item
                  .data![index].displayNameWOExt), // check display name also
              subtitle: Text("${item.data![index].title}"),
              trailing: IconButton(
                  onPressed: () {}, icon: Icon(Icons.more_horiz_rounded)),
              ),
              itemCount: item.data!.length,
          );
        },
      ),
    );
  }
}
