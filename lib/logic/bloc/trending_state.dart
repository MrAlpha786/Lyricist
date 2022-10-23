// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'trending_bloc.dart';

class TrendingState extends Equatable {
  const TrendingState({
    this.status = TrendingStatus.initial,
    this.tracks = const <Track>[],
    this.hasReachedMax = false,
    this.pageNumber = 1,
  });

  final TrendingStatus status;
  final List<Track> tracks;
  final bool hasReachedMax;
  final int pageNumber;

  @override
  List<Object> get props => [status, tracks, hasReachedMax, pageNumber];

  TrendingState copyWith({
    TrendingStatus? status,
    List<Track>? tracks,
    bool? hasReachedMax,
    int? pageNumber,
  }) {
    return TrendingState(
      status: status ?? this.status,
      tracks: tracks ?? this.tracks,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      pageNumber: pageNumber ?? this.pageNumber,
    );
  }

  @override
  bool get stringify => true;
}
