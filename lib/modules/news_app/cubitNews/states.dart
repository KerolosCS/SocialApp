abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNav extends NewsStates {}

class NewsBusinessLoadingState extends NewsStates {}

class NewsGetBusinessSuccessState extends NewsStates {}

class NewsGetBusinessErroState extends NewsStates {
  final String error;

  NewsGetBusinessErroState(this.error);
}

class NewsSportsLoadingState extends NewsStates {}

class NewsGetSportsSuccessState extends NewsStates {}

class NewsGetSportsErroState extends NewsStates {
  final String error;

  NewsGetSportsErroState(this.error);
}

class NewsScienceLoadingState extends NewsStates {}

class NewsGetScienceSuccessState extends NewsStates {}

class NewsGetScienceErroState extends NewsStates {
  final String error;

  NewsGetScienceErroState(this.error);
}

class NewsSearchLoadingState extends NewsStates {}

class NewsSearchSuccessState extends NewsStates {}

class NewsSearcheErrorState extends NewsStates {
  final String error;

  NewsSearcheErrorState(this.error);
}

class NewsDarkStates extends NewsStates {}
class MshFahmak3ayezEh extends NewsStates {}
