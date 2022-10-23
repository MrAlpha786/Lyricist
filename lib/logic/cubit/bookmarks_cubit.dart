import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../models/track.dart';

part 'bookmarks_state.dart';

class BookmarksCubit extends Cubit<BookmarksState> with HydratedMixin {
  BookmarksCubit() : super(const BookmarksState());

  void add(Track track) =>
      emit(BookmarksState(tracks: List.of(state.tracks)..add(track)));

  void remove(Track track) =>
      emit(BookmarksState(tracks: List.of(state.tracks)..remove(track)));

  @override
  BookmarksState? fromJson(Map<String, dynamic> json) {
    return BookmarksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(BookmarksState state) {
    return state.toMap();
  }
}
