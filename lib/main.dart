import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/home_layout.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import 'shared/bloc.dart';
import 'shared/network/local/cache_helper.dart';

void main()async
{

  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  DioHelper.init();

  Bloc.observer = MyBlocObserver();

  bool? isDark=CacheHelper.getData(key: 'isDark');

  runApp( MyApp(isDark: isDark,));
}

class MyApp extends StatelessWidget {
  bool? isDark;
   MyApp({super.key,this.isDark});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>NewsCubit()..getBusiness()..changeAppTheme(fromShared: isDark),
      child: BlocConsumer<NewsCubit,NewStates>(
        listener: (BuildContext context, state) {
        },
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              floatingActionButtonTheme:FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ) ,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                    systemNavigationBarColor: Colors.white,
                    systemStatusBarContrastEnforced: true,
                    systemNavigationBarContrastEnforced: true,
                    systemNavigationBarIconBrightness: Brightness.dark
                ),
                titleTextStyle: TextStyle(
                  color: Colors.red,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),

              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 100.0,
              ),

              textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: NewsCubit.get(context).changeColorWithTheme()
                  )
              ),


            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              floatingActionButtonTheme:FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ) ,
              appBarTheme: AppBarTheme(
                // backgroundColor: Color.fromRGBO(64, 64, 64, 1),
                elevation: 20.0,
                backgroundColor: Colors.black,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Color.fromRGBO(64, 64, 64, 1),
                    statusBarIconBrightness: Brightness.light,
                    systemNavigationBarColor: Color.fromRGBO(64, 64, 64, 1),
                    systemStatusBarContrastEnforced: true,
                    systemNavigationBarContrastEnforced: true,
                    systemNavigationBarIconBrightness: Brightness.light
                ),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
              ),

              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                // backgroundColor: Color.fromRGBO(64, 64, 64, 1),
                unselectedItemColor: Colors.grey,
                backgroundColor: Colors.black,
                selectedItemColor: Colors.deepOrange,
                elevation: 80.0,
              ),
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: NewsCubit.get(context).changeColorWithTheme(),
                  )
              ),

              scaffoldBackgroundColor: Color.fromRGBO(64, 64, 64, 1),
              //   scaffoldBackgroundColor: Colors.black,

            ),
            themeMode:NewsCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home:  NewsLayout(),
          );
        },
      ),
    );
  }
}
