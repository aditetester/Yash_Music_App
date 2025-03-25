import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/domain/entity/post/category.dart';
import 'package:boilerplate_new_version/domain/entity/post/category_list.dart';
import 'package:boilerplate_new_version/presentation/categories/store/categories_store.dart';
import 'package:boilerplate_new_version/presentation/categories/widgets/categories_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  CategoriesStore _CategoriesStore = getIt<CategoriesStore>();
  List<Category>? categories = [];

  @override
  void initState() {
    super.initState();
    _CategoriesStore.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Music Categories")),
      body: Observer(
        builder: (_) {
          if (_CategoriesStore.fetchPostsFuture.status ==
              FutureStatus.pending) {
            return Center(child: CircularProgressIndicator());
          } else if (_CategoriesStore.fetchPostsFuture.status ==
              FutureStatus.fulfilled) {
            categories = _CategoriesStore.CategoryList;

            if (categories == null || categories!.isEmpty) {
              return Center(child: Text("No categories available"));
            }
          }
          return Container(
            padding: EdgeInsets.all(10),
            child: GridView(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
                childAspectRatio: 4 / 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              children:
                  categories!.map((Category) {
                    return CategoriesItem(
                      Category.id.toString(),
                      Category.name.toString(),
                      Category.image.toString(),
                    );
                  }).toList(),
            ),
          );
        },
      ),
    );
  }
}
