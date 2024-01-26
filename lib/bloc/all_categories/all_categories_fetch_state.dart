part of 'all_categories_fetch_bloc.dart';

@immutable
sealed class AllCategoriesFetchState {}

final class AllCategoriesFetchInitial extends AllCategoriesFetchState {}

final class LoadingState extends AllCategoriesFetchState {}

class SuccessfulState extends AllCategoriesFetchState {
  final AllCategories allCategories;
 
  SuccessfulState({ required this.allCategories});

}

class ErrorState extends AllCategoriesFetchState {
  final String error;

  ErrorState({required this.error});

}