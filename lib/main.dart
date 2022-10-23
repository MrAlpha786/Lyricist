// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'bloc_observer.dart';
import 'constants.dart';
import 'logic/bloc/trending_bloc.dart';
import 'logic/cubit/bookmarks_cubit.dart';
import 'logic/cubit/internet_cubit.dart';
import 'logic/data/http_track_repository.dart';
import 'view/screens/trending_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();
  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  HydratedBlocOverrides.runZoned(
    () => runApp(Lyricist(
      httpTrackRepository: HttpTrackRepository(
          apiKey: kMusixMatchApiKey, httpClient: http.Client()),
      connectivity: Connectivity(),
    )),
    storage: storage,
  );
}

class Lyricist extends StatelessWidget {
  const Lyricist({
    Key? key,
    required this.httpTrackRepository,
    required this.connectivity,
  }) : super(key: key);

  final HttpTrackRepository httpTrackRepository;
  final Connectivity connectivity;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TrendingBloc>(
          create: (context) => TrendingBloc()..add(TrendingFetched()),
        ),
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<BookmarksCubit>(
          create: (context) => BookmarksCubit(),
        )
      ],
      child: const MaterialApp(
        home: TrendingPage(),
      ),
    );
  }
}
