import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: (){
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                ),
                );
                }, icon: Icon(Icons.search)),
              IconButton(onPressed: NewsCubit.get(context).changeAppTheme,
                  icon: Icon(Icons.brightness_4_outlined)),
            ],
            title: Text(
              'News App',
            ),
          ),

          body: cubit.screens[cubit.currentIndex],

          // floatingActionButton: FloatingActionButton(
          //   onPressed: (){
          //     // DioHelper.getData(
          //     //     url: 'v2/top-headlines',
          //     //     query: {
          //     //       'country':'eg',
          //     //       'category':'business',
          //     //       'apiKey':'e4c5fc84d6614d348cd22772b61f15f2',
          //     //     }
          //     // ).then((value)  {
          //     //   print(value!.data['articles'][0]['title']);
          //     // }).catchError((onError){
          //     //   print('the error we encountered is : ${onError.toString()}');
          //     // });
          //
          //     cubit.getBusiness();
          //     if(cubit.business.length==0){
          //
          //     }
          //     else print(cubit.business[1]);
          //   },
          //   child:  Icon(
          //     Icons.add
          //   ),
          // ),

          bottomNavigationBar: BottomNavigationBar(
            items: [
              cubit.bottomItems[0],
              cubit.bottomItems[1],
              cubit.bottomItems[2],
              // cubit.bottomItems[3],
            ],
            onTap: (index){
              cubit.ChangeIndex(index);

            },
            currentIndex: cubit.currentIndex,
          ),
        );
      },
    );
  }
}
