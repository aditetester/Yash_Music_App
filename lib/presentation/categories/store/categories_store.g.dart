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
  List<dynamic>? get CategoryList {
    _$CategoryListAtom.reportRead();
    return super.CategoryList;
  }

  @override
  set CategoryList(List<dynamic>? value) {
    _$CategoryListAtom.reportWrite(value, super.CategoryList, () {
      super.CategoryList = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_CategoriesStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$_CategoriesStoreActionController =
      ActionController(name: '_CategoriesStore', context: context);

  @override
  List<dynamic>? fetchCategories() {
    final _$actionInfo = _$_CategoriesStoreActionController.startAction(
        name: '_CategoriesStore.fetchCategories');
    try {
      return super.fetchCategories();
    } finally {
      _$_CategoriesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchPostsFuture: ${fetchPostsFuture},
CategoryList: ${CategoryList},
success: ${success}
    ''';
  }
}
