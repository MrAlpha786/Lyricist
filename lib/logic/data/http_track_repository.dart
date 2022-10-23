// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_lyricist/constants.dart';
import 'package:flutter_lyricist/logic/models/track.dart';
import 'package:http/http.dart' as http;

class HttpTrackRepository {
  const HttpTrackRepository({
    required this.apiKey,
    required this.httpClient,
  });

  final String apiKey;
  final http.Client httpClient;

  void _checkApi(int code) {
    if (code == 401) {
      throw ApiAuthenticationException();
    }
  }

  Future<List<Track>> fetchTrending({int pageNumber = 1}) async {
    final response = await httpClient.get(
      Uri.https(
        kMusixMatchApiBaseUrl,
        '$kMusixMatchApi/chart.tracks.get',
        <String, String>{
          'chart_name': kChartName,
          'page': '$pageNumber',
          'page_size': '$kPageSize',
          'f_has_lyrics': '${(kHasLyrics) ? 1 : 0}',
          'apikey': kMusixMatchApiKey
        },
      ),
    );
    _checkApi(response.statusCode);
    if (response.statusCode == 200) {
      final trackList =
          json.decode(response.body)['message']['body']['track_list'] as List;
      return await Future.wait(trackList.map((dynamic json) async {
        final id = json['track']['commontrack_id'] as int;
        return await fetchTrack(id);
      }).toList());
    }
    throw Exception('error fetching trending list');
  }

  Future<Track> fetchTrack(int id) async {
    final response = await httpClient.get(Uri.https(
      kMusixMatchApiBaseUrl,
      '$kMusixMatchApi/track.get',
      <String, String>{'commontrack_id': '$id', 'apikey': kMusixMatchApiKey},
    ));

    _checkApi(response.statusCode);
    if (response.statusCode == 200) {
      final map = json.decode(response.body)['message']['body']['track']
          as Map<String, dynamic>;
      return Track(
          id: map['commontrack_id'] as int,
          name: map['track_name'] as String,
          album: map['album_name'] as String,
          artist: map['artist_name'] as String,
          rating: map['track_rating'] as int,
          explicit: map['explicit'] as int == 0 ? false : true);
    }
    throw Exception('error fetching track details');
  }

  Future<Track> fetchLyrics(Track track) async {
    final response = await httpClient.get(
      Uri.https(
        kMusixMatchApiBaseUrl,
        '$kMusixMatchApi/track.lyrics.get',
        <String, String>{
          'commontrack_id': '${track.id}',
          'apikey': kMusixMatchApiKey
        },
      ),
    );
    _checkApi(response.statusCode);
    if (response.statusCode == 200) {
      return track.copyWith(
          lyrics: json.decode(response.body)['message']['body']['lyrics']
              ['lyrics_body'] as String);
    }
    if (response.statusCode == 404) {
      return track;
    }
    throw Exception('error fetching track lyrics');
  }
}

class ApiAuthenticationException implements Exception {}
