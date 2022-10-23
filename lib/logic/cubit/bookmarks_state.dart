// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'bookmarks_cubit.dart';

class BookmarksState extends Equatable {
  const BookmarksState({
    this.tracks = const <Track>[],
  });

  final List<Track> tracks;

  @override
  List<Object> get props => [tracks];

  @override
  bool get stringify => true;

  BookmarksState copyWith({
    List<Track>? tracks,
  }) {
    return BookmarksState(
      tracks: tracks ?? this.tracks,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tracks': tracks.map((x) => x.toMap()).toList(),
    };
  }

  factory BookmarksState.fromMap(Map<String, dynamic> map) {
    return BookmarksState(
      tracks: List<Track>.from(
        (map['tracks'] as List).map<Track>(
          (x) => Track.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory BookmarksState.fromJson(String source) =>
      BookmarksState.fromMap(json.decode(source) as Map<String, dynamic>);
}
