import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list=NewsCubit.get(context).search;
    TextEditingController searchController=TextEditingController();
    return BlocConsumer<NewsCubit,NewStates>(
      listener: (context, state) {

      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(

                  scrollPhysics: NeverScrollableScrollPhysics(),
                  context: context,
                  controller: searchController,
                  prefixIcon: Icons.search,
                  labelText: 'Search',
                  validation: false,
                  onFieldSubmitted: (string){
                    print(string);
                    NewsCubit.get(context).getSearch(string);
                  },
                ),
              ),

              if(state is NewsGetSearchLoadingState)
                Center(child: CircularProgressIndicator())

              else if (list.length == 0)
                Center(child: Container())
              else if(list.length>0)
    ListView.separated(
      shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) => buildArticleItem(list[index],context),
    separatorBuilder: (context, index) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Container(height: 2,width: double.infinity,color: Colors.black12,),
    ),
    itemCount: 10
    )

            ],
          ),
        ),
      ),
    );
  }
}
