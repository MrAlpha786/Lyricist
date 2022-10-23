// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'lyrics_cubit.dart';

class LyricsState extends Equatable {
  const LyricsState({
    this.status = LyricsStatus.initial,
    required this.track,
  });

  final LyricsStatus status;
  final Track track;

  @override
  List<Object> get props => [status];

  LyricsState copyWith({
    LyricsStatus? status,
    Track? track,
  }) {
    return LyricsState(
      status: status ?? this.status,
      track: track ?? this.track,
    );
  }

  @override
  bool get stringify => true;
}
