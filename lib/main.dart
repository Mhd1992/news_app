import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/layouts/news_app/cubit/AppCubit.dart';
import 'package:new_app/shared/bloc_observer.dart';
import 'package:new_app/shared/local/cache_helper.dart';
import 'package:new_app/shared/network/remote/dio_helper.dart';
import 'package:new_app/shared/styles/themes/themes.dart';

import 'layouts/news_app/cubit/AppState.dart';
import 'layouts/news_app/cubit/news_cubit.dart';
import 'layouts/news_app/news_layout.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.ini();
  await CacheHelper.ini();
  Bloc.observer = MyBlocObserver();
  bool? darkMode = CacheHelper.getData(key: 'isDark');

  runApp( MyApp(darkMode: darkMode,));
}

class MyApp extends StatelessWidget {
  final bool? darkMode;
  const MyApp({this.darkMode,super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()..changeThemeMode(darkMode: darkMode)),
        BlocProvider(create:     (context) => NewsCubit()..getBusiness()..getScience()..getSports(),),
      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: (AppCubit.get(context).isDarkTheme)
                ? ThemeMode.light
                : ThemeMode.dark,
            home: const NewsLayout(),
          );
        },
      ),
    );
  }
}
