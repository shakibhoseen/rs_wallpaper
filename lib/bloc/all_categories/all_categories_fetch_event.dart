part of 'all_categories_fetch_bloc.dart';

@immutable
sealed class AllCategoriesFetchEvent {}

class AllCategoriesFetchEventInit extends AllCategoriesFetchEvent{
  
}
class LoadOldCategoriesEvent extends AllCategoriesFetchEvent{}
