abstract class NewStates{}

class NewInitialStates extends NewStates{}

class ChangeAppThemeDarkState extends NewStates{}

class ChangeAppThemeLightState extends NewStates{}

class ChangTextColorState extends NewStates{}


class NewsBottomNav extends NewStates{}

class NewsBottomNavChanger extends NewStates{}

class NewsGetBusinessLoadingState extends NewStates{}


class NewsGetSearchLoadingState extends NewStates{}

class NewsGetBusinessSuccessState extends NewStates{}

class NewsGetSearchSuccessState extends NewStates{}

class NewsGetBusinessErrorState extends NewStates{
  final String error;

  NewsGetBusinessErrorState(this.error);

}
class NewsGetSearchErrorState extends NewStates{
  final String error;

  NewsGetSearchErrorState(this.error);

}

class NewsGetSportsLoadingState extends NewStates{}

class NewsGetSportsSuccessState extends NewStates{}

class NewsGetSportsErrorState extends NewStates{
  final String error;

  NewsGetSportsErrorState(this.error);

}

class NewsGetScienceLoadingState extends NewStates{}

class NewsGetScienceSuccessState extends NewStates{}

class NewsGetScienceErrorState extends NewStates{
  final String error;

  NewsGetScienceErrorState(this.error);

}


