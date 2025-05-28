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
    if(index == 1)
      {
        getSports();
      }
    if(index == 2)
    {
      getScience();
    }
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

  List<dynamic> sports = [];
  void getSports(){

    emit(NewsLoadingState());
    if(sports.isEmpty)
      {
        DioHelper.getData(url: 'v2/top-headlines',
            query: {
              'country':'us',
              'category':'sports',
              'apikey':'84a9a5a645bc4d73880a09141bf3506d'
            }
        ).then((value){
          emit(NewsSportsSuccessState());
          sports = value.data['articles'];
          print(sports[0]['title']);
        }).catchError((error){
          emit(NewsErrorState());
          error.toString();
        });
      }

  }

  List<dynamic> science = [];
  void getScience(){

    emit(NewsLoadingState());
    if(science.isEmpty){
      DioHelper.getData(url: 'v2/top-headlines',
          query: {
            'country':'us',
            'category':'science',
            'apikey':'84a9a5a645bc4d73880a09141bf3506d'
          }
      ).then((value){
        emit(NewsScienceSuccessState());
        science = value.data['articles'];
        print(science[0]['title']);
      }).catchError((error){
        emit(NewsErrorState());
        error.toString();
      });
    }

  }

  List<dynamic> searchResult = [];
  void getSearchResult(String text){

    emit(NewsSearchLoadingState());
    searchResult =[];
    if(searchResult.isEmpty){
      DioHelper.getData(url: 'v2/everything',
          query: {
            'q':text,
            'apikey':'84a9a5a645bc4d73880a09141bf3506d'
          }
      ).then((value){
        emit(NewsSearchSuccessState());
        searchResult = value.data['articles'];
        print(searchResult[0]['title']);
      }).catchError((error){
        emit(NewsSearchErrorState());
        error.toString();
      });
    }

  }

}