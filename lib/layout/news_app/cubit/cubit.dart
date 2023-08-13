import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/settings/settings_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewStates>{
  NewsCubit(): super(NewInitialStates());

  static NewsCubit get(context)=> BlocProvider.of(context);

  int currentIndex=0;
  List<BottomNavigationBarItem> bottomItems=[
    BottomNavigationBarItem(
        icon: Icon(
            Icons.business,
        ),
        label: 'Business',

    ),
    BottomNavigationBarItem(
        icon: Icon(
            Icons.sports,
        ),
        label: 'Sports',

    ),
    BottomNavigationBarItem(
        icon: Icon(
            Icons.science,
        ),
        label: 'Science',

    ),
    // BottomNavigationBarItem(
    //     icon: Icon(
    //         Icons.settings,
    //     ),
    //     label: 'Settings',
    //
    // ),
  ];

  List<Widget>screens=[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    // SettingsScreen(),
  ];

  void ChangeIndex(int index){
    currentIndex=index;
    emit(NewsBottomNavChanger());
    if(index==0){
      getBusiness();
    }if(index==1){
      getSports();
    }if(index==2){
      getScience();
    }
  }

  List<dynamic> business=[];

  List<dynamic> sports=[];

  List<dynamic> science=[];

  void getBusiness(){

    if(sports.length==0){
      emit(NewsGetBusinessLoadingState());

      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'business',
            // 'q':'egypt',
            'apiKey':'e4c5fc84d6614d348cd22772b61f15f2',
          }
      ).then((value) {
        print(value?.data['articles'][0]);
        business=value?.data['articles'] ;
        print(business[1]['source']['id']);
        emit(NewsGetBusinessSuccessState());
      }).catchError((onError){
        print('the error you encountered while getting the data is : ${onError.toString()}');
        emit(NewsGetBusinessErrorState(onError.toString()));
      });
    }
    else{
      emit(NewsGetBusinessSuccessState());
    }


  }

  List<dynamic> search=[];

  void getSearch(String? keyword){
print('the keyword you are trying to search for is ::: $keyword ');
search=[];
    if(search.length==0){
      emit(NewsGetSearchLoadingState());

      DioHelper.getData(
          url: 'v2/everything',
          query: {
            'q':'$keyword',
            'apiKey':'e4c5fc84d6614d348cd22772b61f15f2',
          }
      ).then((value) {
        search=value?.data['articles'] ;
        emit(NewsGetSearchSuccessState());
      }).catchError((onError){
        print('the error you encountered while getting the data is : ${onError.toString()}');
        emit(NewsGetSearchErrorState(onError.toString()));
      });
    }
    else{
      emit(NewsGetSearchSuccessState());
    }


  }

  void getSports(){

    if(sports.length==0){
      emit(NewsGetSportsLoadingState());

      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'Sports',
            // 'q':'egypt',
            'apiKey':'e4c5fc84d6614d348cd22772b61f15f2',
          }
      ).then((value) {
        sports=value?.data['articles'] ;
        emit(NewsGetSportsSuccessState());
      }).catchError((onError){
        print('the error you encountered while getting the data is : ${onError.toString()}');
        emit(NewsGetSportsErrorState(onError.toString()));
      });
    }
    else{
      emit(NewsGetSportsSuccessState());
    }

  }

  void getScience(){

    if(science.length==0){

      emit(NewsGetScienceLoadingState());

      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'Science',
            // 'q':'egypt',
            'apiKey':'e4c5fc84d6614d348cd22772b61f15f2',
          }
      ).then((value) {
        science=value?.data['articles'] ;
        emit(NewsGetScienceSuccessState());
      }).catchError((onError){
        print('the error you encountered while getting the data is : ${onError.toString()}');
        emit(NewsGetScienceErrorState(onError.toString()));
      });
    }

    else{
      emit(NewsGetScienceSuccessState());
    }

  }

  bool isDark=false;

  bool toRef=false;

  void changeAppTheme({bool? fromShared}){
    if(fromShared!=null){
      isDark=fromShared;
    }
    else
      isDark=!isDark;
    CacheHelper.pudData(key: 'isDark', value: isDark).then((value) => emit(ChangeAppThemeLightState()));
    emit(ChangeAppThemeLightState());

  }
  Color changeColorWithTheme(){
    if(isDark){
      print('the choosen color is white and the theme is dark');
      if(toRef){
        toRef=false;
        emit(ChangTextColorState());
      }
    return Colors.white;
  }
  else{
    if(toRef==false){
      toRef=true;
      emit(ChangTextColorState());

    }
    print('the choosen color is black and the theme is white');

    return Colors.black;
    }
  }

}