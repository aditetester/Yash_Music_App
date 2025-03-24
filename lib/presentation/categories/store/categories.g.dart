// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Categories on _CategoriesStore, Store {
  late final _$CategoryListAtom =
      Atom(name: '_CategoriesStore.CategoryList', context: context);

  @override
  Map<String, dynamic>? get CategoryList {
    _$CategoryListAtom.reportRead();
    return super.CategoryList;
  }

  @override
  set CategoryList(Map<String, dynamic>? value) {
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

  late final _$fetchCategoriesAsyncAction =
      AsyncAction('_CategoriesStore.fetchCategories', context: context);

  @override
  Future<List<dynamic>> fetchCategories() {
    return _$fetchCategoriesAsyncAction.run(() => super.fetchCategories());
  }

  @override
  String toString() {
    return '''
CategoryList: ${CategoryList},
success: ${success}
    ''';
  }
}
