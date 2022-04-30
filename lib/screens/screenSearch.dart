import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:musico_scratch/custom/customMade.dart';
import 'package:musico_scratch/screens/NowPlaying2.dart';
import 'package:musico_scratch/Home/HomeSongs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScreenSearch extends StatefulWidget {
  ScreenSearch({Key? key}) : super(key: key);

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  String search = "";
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<Audio> searchTitle = databaseAudioList.where((element) {
      return element.metas.title!.toLowerCase().startsWith(
            search.toLowerCase(),
          );
    }).toList();

    List<Audio> searchArtist = databaseAudioList.where((element) {
      return element.metas.artist!.toLowerCase().startsWith(
            search.toLowerCase(),
          );
    }).toList();

    List<Audio> searchAlbum = databaseAudioList.where((element) {
      if (element.metas.album != null) {
        return element.metas.album!.toLowerCase().startsWith(
              search.toLowerCase(),
            );
      } else {
        return false;
      }
    }).toList();
    Set<Audio> searchResultsSet = {}; 
    List<Audio> searchResults = [];
    if (searchTitle.isNotEmpty) {
      searchResultsSet = searchTitle.toSet();
    } else if (searchArtist.isNotEmpty) {
      searchResultsSet = searchArtist.toSet();
    }
    searchResults = searchResultsSet.toList()
    //  else if (searchAlbum.isNotEmpty) {
    //   searchResults = searchAlbum;
    // }
    // else {
    //   searchResults = searchResults.isEmpty;
    // }
    ;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Container(
        // height: height,
        // width: width,
        color: Colors.black,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  // padding: EdgeInsets.zero,
                  width: width,
                  child: TextField(
                      controller: _controller,
                      style: TextStyle(color: Colors.white70),
                      autofocus: true,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: 16,
                          ),
                          border: InputBorder.none,
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 100, 99, 99),
                          ),
                          suffix: IconButton(
                            onPressed: () {
                              if (search.isEmpty) {
                                Navigator.pop(context);
                              } else {
                                setState(() {
                                  search = '';
                                  _controller.clear();
                                });
                              }
                            },
                            icon: Icon(Icons.clear,
                                color: Color.fromARGB(255, 100, 99, 99)),
                          )
                          // suffix: TextButton(
                          //   onPressed: () => Navigator.pop(context),
                          //   child: const Text(
                          //     'Cancel',
                          //     style: TextStyle(
                          //         color: Colors.white70,
                          //         fontWeight: FontWeight.bold,
                          //         fontSize: 15),
                          //   ),
                          // )
                          ),
                      onChanged: (value) {
                        setState(
                          () {
                            search = value.trim();
                          },
                        );
                      }),
                )
              ],
            ),
            customDivider(),
            Expanded(
                child: search.isNotEmpty
                    ? searchResults.isNotEmpty
                        ? Container(
                            child: Column(
                              children: [
                                Container(
                                  child: Expanded(
                                    child: ListView.builder(
                                      itemCount: searchResults.length,
                                      itemBuilder: (context, index) {
                                        return FutureBuilder(
                                            builder: (context, snapshot) {
                                          // if (snapshot.connectionState ==
                                          //     ConnectionState.done) {
                                          return
                                              //  Container(
                                              //   color: Colors.red,
                                              //   height: 50,
                                              //   width: 50,
                                              // );
                                              GestureDetector(
                                            onTap: () {
                                              // final  temp = databaseAudioList.firstWhere((element) => element.metas.id==searchResults[index].metas.id);

                                              // var  newindex = searchResults[index].metas.id===;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: ((context) {
                                                    return NowPlaying2(
                                                      index: index,
                                                      allSongs: searchResults,
                                                      songId: searchResults[index].metas
                                                          .id
                                                          .toString(),
                                                    );
                                                  }),
                                                ),
                                              );
                                            },
                                            child: ListTile(
                                              leading: SizedBox(
                                                height: 50,
                                                width: 50,
                                                child: QueryArtworkWidget(
                                                  id: int.parse(
                                                      searchResults[index]
                                                          .metas
                                                          .id!),
                                                  type: ArtworkType.AUDIO,
                                                  artworkBorder:
                                                      BorderRadius.circular(15),
                                                  artworkFit: BoxFit.cover,
                                                  nullArtworkWidget: Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15)),
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/images/muzify.png"),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              title: Text(
                                                searchResults[index]
                                                    .metas
                                                    .title!,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              subtitle: Text(
                                                searchResults[index]
                                                    .metas
                                                    .artist!,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          );
                                          // } else {
                                          //   return Container(
                                          //     color: Colors.purple,
                                          //     height: 50,
                                          //     width: 50,
                                          //   );
                                          // }
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        // : Container(
                        //     color: Colors.green, height: 100, width: 100)
                        : Center(
                            child: Container(
                            child: Text(
                              'No songs found',
                              style: TextStyle(color: Colors.white),
                            ),
                          ))
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Play what you love',
                              style: TextStyle(
                                  color: Colors.white30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ))
          ],
        ),
      )),
    );
  }

  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = ['ABC', 'DEF', 'GHI', 'JKL'];
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          // query = suggestion;

          return ListTile(
            title: Text('suggestion'),
            onTap: () {},
          );
        });
  }
}
