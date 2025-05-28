import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/layouts/news_app/cubit/news_state.dart';
import 'package:new_app/modules/business/BusinessScreen.dart';
import 'package:new_app/modules/science/science_screen.dart';
import 'package:new_app/modules/settings/settings_screen.dart';
import 'package:new_app/modules/sports/sports_screen.dart';
import 'package:new_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit():super(NewsInitialState());

  static NewsCubit get(context)=>BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> items=[
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',

    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports_score),
      label: 'Sport',

    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',

    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settingd',

    ),
  ];

  List<Widget> screens = const [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavIcon(int index){
    currentIndex = index;
    emit(NewsBottomNvaState());
  }
  List<dynamic> business = [];
  void getBusiness(){
    
    emit(NewsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines',
        query: {
          'country':'us',
          'category':'business',
          'apikey':'84a9a5a645bc4d73880a09141bf3506d'
        }
    ).then((value){
      emit(NewsSuccessState());
      business = value.data['articles'];
      print(business[0]['title']);
    }).catchError((error){
      emit(NewsErrorState());
      error.toString();
    });
  }

}