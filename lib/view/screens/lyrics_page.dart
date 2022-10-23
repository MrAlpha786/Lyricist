// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lyricist/constants.dart';
import 'package:flutter_lyricist/logic/cubit/bookmarks_cubit.dart';
import 'package:flutter_lyricist/logic/cubit/lyrics_cubit.dart';
import 'package:flutter_lyricist/view/widgets/property_tile.dart';

import 'package:flutter_lyricist/logic/cubit/internet_cubit.dart';
import 'package:flutter_lyricist/logic/models/track.dart';

class LyricsPage extends StatelessWidget {
  const LyricsPage({
    Key? key,
    required this.track,
  }) : super(key: key);

  final Track track;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Lyrics'),
        actions: [
          BlocBuilder<BookmarksCubit, BookmarksState>(
              builder: (context, state) {
            if (state.tracks.contains(track)) {
              return IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Bookmark Removed!'),
                      duration: kSnackbarDuration,
                    ));
                    BlocProvider.of<BookmarksCubit>(context).remove(track);
                  },
                  icon: const Icon(Icons.bookmark_added));
            }
            return IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Bookmark Added!'),
                    duration: kSnackbarDuration,
                  ));
                  BlocProvider.of<BookmarksCubit>(context).add(track);
                },
                icon: const Icon(Icons.bookmark_add));
          }),
        ],
      ),
      body: ListView(
        children: [
          PropertyTile(
              property: track.name ?? '?', propertyType: 'Track Title'),
          PropertyTile(property: track.album ?? '?', propertyType: 'Album'),
          PropertyTile(property: track.artist ?? '?', propertyType: 'Artist'),
          PropertyTile(
              property: track.rating?.toString() ?? '?',
              propertyType: 'Rating'),
          PropertyTile(
              property: track.explicit?.toString() ?? '?',
              propertyType: 'Explicit'),
          ListTile(
            title: const Text(
              'Lyrics:',
              style: TextStyle(fontSize: 15),
            ),
            subtitle: Builder(builder: (context) {
              final internetState = context.watch<InternetCubit>().state;
              final lyricsState = context.watch<LyricsCubit>().state;

              if (internetState is InternetDisconnected &&
                  lyricsState.status != LyricsStatus.success) {
                return const Center(
                  child: Text('NO INTERNET CONNECTION!'),
                );
              }

              switch (lyricsState.status) {
                case LyricsStatus.failure:
                  return const Center(
                    child: Text('ERROR WHILE LOADING LYRICS!'),
                  );

                case LyricsStatus.success:
                  return Text(lyricsState.track.lyrics!,
                      style: const TextStyle(fontSize: 15));

                case LyricsStatus.initial:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                case LyricsStatus.missing:
                  return const Center(
                    child: Text('NO LYRICS FOUND!'),
                  );
              }
            }),
          ),
        ],
      ),
    );
  }
}
