import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/lyrics_cubit.dart';
import '../../logic/models/track.dart';
import '../screens/lyrics_page.dart';

class TrackListItem extends StatelessWidget {
  const TrackListItem({super.key, required this.track});

  final Track track;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        leading: const Icon(
          Icons.collections,
          size: 50.0,
        ),
        title: Text(
          track.name ?? '?',
          style: const TextStyle(fontSize: 15),
        ),
        isThreeLine: true,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(track.album ?? '?', style: const TextStyle(fontSize: 14)),
            Text(track.artist ?? '?'),
          ],
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) => LyricsCubit(
                track: track,
              )..fetch(),
              child: LyricsPage(track: track),
            ),
          ),
        ),
      ),
    );
  }
}
