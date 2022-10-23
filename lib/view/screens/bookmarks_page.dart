import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/bookmarks_cubit.dart';
import '../widgets/track_list_item.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarked Tracks')),
      body: Builder(builder: (context) {
        final bookmarksState = context.watch<BookmarksCubit>().state;

        return ListView.builder(
          itemBuilder: (context, index) {
            return TrackListItem(track: bookmarksState.tracks[index]);
          },
          itemCount: bookmarksState.tracks.length,
        );
      }),
    );
  }
}
