import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/domain/entity/subCategories/subCategory.dart';
import 'package:boilerplate_new_version/presentation/subCategories/store/sub_categories_store.dart';
import 'package:boilerplate_new_version/presentation/subCategories/widgets/subCategory_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class SubCategoryList extends StatefulWidget {
  const SubCategoryList({super.key});

  @override
  State<SubCategoryList> createState() => _SubCategoryListState();
}

class _SubCategoryListState extends State<SubCategoryList> {
  SubCategoriesStore _subCategoryStore = getIt<SubCategoriesStore>();
  List<SubCategoryModule>? subcategoryList = [];
  
  @override
  void initState() {
    super.initState();
     _subCategoryStore.fetchSubCategories();
  }

  @override
  Widget build(BuildContext context) {
    final String categoryId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: Text("Music Section")),
      body: Observer(
        builder: (_) {
           _subCategoryStore.SelectSubCategories(categoryId);
          if (_subCategoryStore.fetchPostsFuture.status ==
              FutureStatus.pending) {
            return Center(child: CircularProgressIndicator());
          } else if (_subCategoryStore.fetchPostsFuture.status ==
              FutureStatus.fulfilled) {
            subcategoryList = _subCategoryStore.subCategoryList;

            if (subcategoryList == null || subcategoryList!.isEmpty) {
              return Center(child: Text("No categories available"));
            }
          }
          return Container(
            padding: EdgeInsets.all(10),
            child: GridView(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 2.7 / 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              children:
                  subcategoryList!.map((singleSubCategory) {
                    return SubCategoryItem(
                      singleSubCategory.id.toString(),
                      singleSubCategory.name.toString(),
                      singleSubCategory.image.toString(),
                    );
                  }).toList(),
            ),
          );
        },
      ),
    );
  }
}
