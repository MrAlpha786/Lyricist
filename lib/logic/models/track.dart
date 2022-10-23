// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Track extends Equatable {
  const Track({
    required this.id,
    this.name,
    this.album,
    this.artist,
    this.rating,
    this.explicit,
    this.lyrics,
  });

  final int id;
  final String? name;
  final String? album;
  final String? artist;
  final int? rating;
  final bool? explicit;
  final String? lyrics;

  @override
  List<Object> get props => [id];

  Track copyWith({
    int? id,
    String? name,
    String? album,
    String? artist,
    int? rating,
    bool? explicit,
    String? lyrics,
  }) {
    return Track(
      id: id ?? this.id,
      name: name ?? this.name,
      album: album ?? this.album,
      artist: artist ?? this.artist,
      rating: rating ?? this.rating,
      explicit: explicit ?? this.explicit,
      lyrics: lyrics ?? this.lyrics,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'album': album,
      'artist': artist,
      'rating': rating,
      'explicit': explicit,
      'lyrics': lyrics,
    };
  }

  factory Track.fromMap(Map<String, dynamic> map) {
    return Track(
      id: map['id'] as int,
      name: map['name'] != null ? map['name'] as String : null,
      album: map['album'] != null ? map['album'] as String : null,
      artist: map['artist'] != null ? map['artist'] as String : null,
      rating: map['rating'] != null ? map['rating'] as int : null,
      explicit: map['explicit'] != null ? map['explicit'] as bool : null,
      lyrics: map['lyrics'] != null ? map['lyrics'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Track.fromJson(String source) =>
      Track.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
