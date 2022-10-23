// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lyricist/constants.dart';
import 'package:flutter_lyricist/logic/data/http_track_repository.dart';
import 'package:flutter_lyricist/logic/models/track.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

part 'trending_event.dart';
part 'trending_state.dart';

const throttleDuration = Duration(milliseconds: 100);

class TrendingBloc extends Bloc<TrendingEvent, TrendingState> {
  TrendingBloc() : super(const TrendingState()) {
    on<TrendingFetched>(_onTrendingFetched,
        transformer: throttleDroppable(throttleDuration));
  }

  final HttpTrackRepository httpTrackRepository =
      HttpTrackRepository(apiKey: kMusixMatchApiKey, httpClient: http.Client());

  EventTransformer<E> throttleDroppable<E>(Duration duration) {
    return (events, mapper) {
      return droppable<E>().call(events.throttle(duration), mapper);
    };
  }

  FutureOr<void> _onTrendingFetched(
      TrendingFetched event, Emitter<TrendingState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == TrendingStatus.initial) {
        final tracks = await httpTrackRepository.fetchTrending();
        return emit(state.copyWith(
          status: TrendingStatus.success,
          tracks: tracks,
          pageNumber: state.pageNumber + 1,
        ));
      }

      final tracks =
          await httpTrackRepository.fetchTrending(pageNumber: state.pageNumber);
      tracks.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(state.copyWith(
              status: TrendingStatus.success,
              tracks: List.of(state.tracks)..addAll(tracks),
              pageNumber: state.pageNumber + 1));
    } catch (e) {
      emit(state.copyWith(status: TrendingStatus.failure));
    }
  }
}
