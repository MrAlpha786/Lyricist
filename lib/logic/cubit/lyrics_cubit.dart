import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../constants.dart';
import '../data/http_track_repository.dart';
import 'package:http/http.dart' as http;
import '../models/track.dart';

part 'lyrics_state.dart';

class LyricsCubit extends Cubit<LyricsState> {
  LyricsCubit({
    required this.track,
  }) : super(LyricsState(track: track));

  final Track track;
  final HttpTrackRepository httpTrackRepository =
      HttpTrackRepository(apiKey: kMusixMatchApiKey, httpClient: http.Client());

  Future<void> fetch() async {
    try {
      final track = await httpTrackRepository.fetchLyrics(this.track);
      if (track.lyrics != null) {
        emit(state.copyWith(status: LyricsStatus.success, track: track));
      } else {
        emit(state.copyWith(status: LyricsStatus.missing));
      }
    } catch (e) {
      emit(state.copyWith(status: LyricsStatus.failure));
    }
  }
}
