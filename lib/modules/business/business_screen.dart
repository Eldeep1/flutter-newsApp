import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        NewsCubit cubit=NewsCubit.get(context);
        var list=cubit.business;
        if (list.length==0) {
          return Center(child: CircularProgressIndicator());
        } else if(list.length>0){
          return ListView.separated(
            physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildArticleItem(list[index],context),
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(height: 2,width: double.infinity,color: Colors.black12,),
              ),
              itemCount: 10
          );
        }
        return Text('data');
      },
    );
  }
}
