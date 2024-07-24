import 'package:films/app_dependensies.dart';
import 'package:films/common/app_colors.dart';
import 'package:films/feature/presentation/bloc/film_list_cubit/film_list_cubit.dart';
import 'package:films/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:films/feature/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_dependensies.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<FilmListCubit>(
              create: (context) => sl<FilmListCubit>()..loadFilm()),
          BlocProvider<FilmSearchBloc>(
              create: (context) => sl<FilmSearchBloc>()),
        ],
        child: MaterialApp(
          theme: ThemeData.dark()
              .copyWith(scaffoldBackgroundColor: AppColors.mainBackground),
          home: const HomePage(),
        ));
  }
}
