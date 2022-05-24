import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../presentation/songs/songs.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial(fullSongs: [])) {
    on<SearchInputEvent>(_onSearchInputevent);
  }

  _onSearchInputevent(SearchInputEvent event, Emitter<SearchState> state) {
    List<Audio> searchTitle = databaseAudioList.where((element) {
      return element.metas.title!.toLowerCase().startsWith(
            event.search.toLowerCase(),
          );
    }).toList();

    List<Audio> searchArtist = databaseAudioList.where((element) {
      return element.metas.artist!.toLowerCase().startsWith(
            event.search.toLowerCase(),
          );
    }).toList();

    List<Audio> searchAlbum = databaseAudioList.where((element) {
      if (element.metas.album != null) {
        return element.metas.album!.toLowerCase().startsWith(
              event.search.toLowerCase(),
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
    searchResults = searchResultsSet.toList();
    emit(SearchInitial(fullSongs: searchResults));
    //  else if (searchAlbum.isNotEmpty) {
    //   searchResults = searchAlbum;
    // }
    // else {
    //   searchResults = searchResults.isEmpty;
    // }
    ;
  }
}
