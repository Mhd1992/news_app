import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/components/widget_main.dart';
import 'package:new_app/layouts/news_app/cubit/AppCubit.dart';
import 'package:new_app/layouts/news_app/cubit/news_cubit.dart';
import 'package:new_app/shared/search_screen/search_screen.dart';

import 'cubit/news_state.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..getBusiness(),
      child: BlocConsumer<NewsCubit,  NewsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(

            appBar: AppBar(
              title: const Text('NewsApp'),
              actions:  [
                IconButton(onPressed: (){
                   navigateTo(context, SearchScreen());
                },icon: const Icon(Icons.search)),
                IconButton(onPressed: (){
                  AppCubit.get(context).changeThemeMode();
                },icon: const Icon(Icons.brightness_4_outlined)),

              ],

            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,

                onTap: (index){
                  cubit.changeBottomNavIcon(index);
                },
                items: cubit.items),
          );
        },
      ),
    );
  }
}
