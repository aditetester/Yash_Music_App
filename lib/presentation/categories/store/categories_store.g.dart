// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CategoriesStore on _CategoriesStore, Store {
  late final _$fetchPostsFutureAtom =
      Atom(name: '_CategoriesStore.fetchPostsFuture', context: context);

  @override
  ObservableFuture<AllCategoryList?> get fetchPostsFuture {
    _$fetchPostsFutureAtom.reportRead();
    return super.fetchPostsFuture;
  }

  @override
  set fetchPostsFuture(ObservableFuture<AllCategoryList?> value) {
    _$fetchPostsFutureAtom.reportWrite(value, super.fetchPostsFuture, () {
      super.fetchPostsFuture = value;
    });
  }

  late final _$CategoryListAtom =
      Atom(name: '_CategoriesStore.CategoryList', context: context);

  @override
  List<Category>? get CategoryList {
    _$CategoryListAtom.reportRead();
    return super.CategoryList;
  }

  @override
  set CategoryList(List<Category>? value) {
    _$CategoryListAtom.reportWrite(value, super.CategoryList, () {
      super.CategoryList = value;
    });
  }

  late final _$fetchCategoriesAsyncAction =
      AsyncAction('_CategoriesStore.fetchCategories', context: context);

  @override
  Future<void> fetchCategories() {
    return _$fetchCategoriesAsyncAction.run(() => super.fetchCategories());
  }

  @override
  String toString() {
    return '''
fetchPostsFuture: ${fetchPostsFuture},
CategoryList: ${CategoryList}
    ''';
  }
}
