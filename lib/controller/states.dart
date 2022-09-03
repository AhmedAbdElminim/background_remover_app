abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class PickImageLoadingState extends HomeStates {}

class PickImageSuccessState extends HomeStates {}

class PickImageErrorState extends HomeStates {}

class NewImageLoadingState extends HomeStates {}

class NewImageSuccessState extends HomeStates {}

class NewImageErrorState extends HomeStates {
  final String error;
  NewImageErrorState(this.error);
}
