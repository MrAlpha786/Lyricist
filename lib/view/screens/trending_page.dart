import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants.dart';
import '../../logic/bloc/trending_bloc.dart';
import '../../logic/cubit/internet_cubit.dart';
import '../widgets/bottom_loader.dart';
import '../widgets/track_list_item.dart';
import 'bookmarks_page.dart';

class TrendingPage extends StatefulWidget {
  const TrendingPage({super.key});

  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trending Tracks')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BookmarkPage(),
              ));
        },
        child: const Icon(Icons.bookmark),
      ),
      body: Builder(builder: (context) {
        final trendingState = context.watch<TrendingBloc>().state;
        final internetState = context.watch<InternetCubit>().state;

        if (internetState is InternetDisconnected) {
          return const Center(
            child: Text('NO INTERNET CONNECTION!'),
          );
        } else {
          switch (trendingState.status) {
            case TrendingStatus.failure:
              return const Center(
                child: Text('FAILED TO LOAD DATA!'),
              );
            case TrendingStatus.success:
              if (trendingState.tracks.isEmpty) {
                return const Center(
                  child: Text('NO TRACKS AVAILABLE!'),
                );
              }
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return (index >= trendingState.tracks.length)
                      ? const BottomLoader()
                      : TrackListItem(track: trendingState.tracks[index]);
                },
                itemCount: trendingState.hasReachedMax
                    ? trendingState.tracks.length
                    : trendingState.tracks.length + 1,
                controller: _scrollController,
              );

            case TrendingStatus.initial:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        }
      }),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<TrendingBloc>().add(TrendingFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.8);
  }
}
