// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_categories_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SubCategoriesStore on _SubCategoriesStore, Store {
  late final _$fetchPostsFutureAtom =
      Atom(name: '_SubCategoriesStore.fetchPostsFuture', context: context);

  @override
  ObservableFuture<AllSubCategoryList?> get fetchPostsFuture {
    _$fetchPostsFutureAtom.reportRead();
    return super.fetchPostsFuture;
  }

  @override
  set fetchPostsFuture(ObservableFuture<AllSubCategoryList?> value) {
    _$fetchPostsFutureAtom.reportWrite(value, super.fetchPostsFuture, () {
      super.fetchPostsFuture = value;
    });
  }

  late final _$subCategoryListAtom =
      Atom(name: '_SubCategoriesStore.subCategoryList', context: context);

  @override
  List<SubCategoryModule>? get subCategoryList {
    _$subCategoryListAtom.reportRead();
    return super.subCategoryList;
  }

  @override
  set subCategoryList(List<SubCategoryModule>? value) {
    _$subCategoryListAtom.reportWrite(value, super.subCategoryList, () {
      super.subCategoryList = value;
    });
  }

  late final _$fetchCategoriesAsyncAction =
      AsyncAction('_SubCategoriesStore.fetchCategories', context: context);

  @override
  Future<void> fetchCategories() {
    return _$fetchCategoriesAsyncAction.run(() => super.fetchCategories());
  }

  @override
  String toString() {
    return '''
fetchPostsFuture: ${fetchPostsFuture},
subCategoryList: ${subCategoryList}
    ''';
  }
}
