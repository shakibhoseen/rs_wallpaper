part of 'all_categories_fetch_bloc.dart';

//@immutable
 class AllCategoriesFetchState extends Union5Impl<_FetchInitial, _LoadingState, _SuccessfulState, _ErrorState, _LoadOldCategory> {
  AllCategoriesFetchState._(Union5<_FetchInitial, _LoadingState, _SuccessfulState, _ErrorState, _LoadOldCategory> union): super(union);
  static const _factory = Quintet<_FetchInitial, _LoadingState, _SuccessfulState, _ErrorState, _LoadOldCategory>();

  factory AllCategoriesFetchState.initial() => AllCategoriesFetchState._(_factory.first(_FetchInitial()));

  factory AllCategoriesFetchState.loading() => AllCategoriesFetchState._(_factory.second(_LoadingState()));
  factory AllCategoriesFetchState.success(AllCategories allCategories) => AllCategoriesFetchState._(_factory.third(_SuccessfulState(allCategories: allCategories)));
  factory AllCategoriesFetchState.error(String error) => AllCategoriesFetchState._(_factory.fourth(_ErrorState(error: error)));
  factory AllCategoriesFetchState.oldData(List<Category> categories) => AllCategoriesFetchState._(_factory.fifth(_LoadOldCategory(categories: categories)));

}

 class _FetchInitial {}

 class _LoadingState {}

class _SuccessfulState {
  final AllCategories allCategories;
  _SuccessfulState({ required this.allCategories});
}

class _ErrorState  {
  final String error;

  _ErrorState({required this.error});

}
class _LoadOldCategory {
  final List<Category> categories;

  _LoadOldCategory({required this.categories});
}