import 'package:films/core/platform/network_info.dart';
import 'package:films/feature/data/datasourses/film_local_data_sourse.dart';
import 'package:films/feature/data/datasourses/film_remote_data_sourse.dart';
import 'package:films/feature/data/repositories/film_repository_impl.dart';
import 'package:films/feature/domain/repositories/film_repository.dart';
import 'package:films/feature/domain/usecases/get_all_films.dart';
import 'package:films/feature/domain/usecases/search_film.dart';
import 'package:films/feature/presentation/bloc/film_list_cubit/film_list_cubit.dart';
import 'package:films/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Регистрация внешних зависимостей
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Регистрация NetworkInfo
  sl.registerLazySingleton<NetWorkInfo>(
      () => NetWorkInfoIpml(connectionChecker: sl()));

  // Регистрация data sources
  sl.registerLazySingleton<FilmRemoteDataSource>(() => FilmRemoteDataSourceImpl(
      client: sl(), apiKey: 'a3a17d40288a9309c3ecd7de8c79d570'));

  sl.registerLazySingleton<FilmLocalDataSourse>(
      () => FilmLocalDataSourseImpl(sharedPreferences: sl()));

  // Регистрация repository
  sl.registerLazySingleton<FilmRepository>(() => FilmRepositoryImpl(
      remoteDataSource: sl(), localDataSourse: sl(), networkInfo: sl()));

  // Регистрация use cases
  sl.registerLazySingleton(() => GetAllFilms(sl()));
  sl.registerLazySingleton(() => SearchFilm(sl()));

  // Регистрация блока
  sl.registerFactory(() => FilmListCubit(getAllFilms: sl()));
  sl.registerFactory(() => FilmSearchBloc(searchFilm: sl()));
}
