import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/domain/entity/categories/category.dart';
import 'package:boilerplate_new_version/presentation/ads/ads_screen.dart';
import 'package:boilerplate_new_version/presentation/categories/store/categories_store.dart';
import 'package:boilerplate_new_version/presentation/categories/widgets/category_items.dart';
import 'package:boilerplate_new_version/presentation/musicPlayer/store/musicController/music_controller_store.dart';
import 'package:boilerplate_new_version/widgets/bottom_musicPlayer_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  CategoryStore _categoryStore = getIt<CategoryStore>();
  final MusicControllerStore _musicControllerStore = getIt<MusicControllerStore>();
  List<CategoryModule>? categoryList = [];

  @override
  void initState() {
    super.initState();
    _categoryStore.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Music Categories")),
      body: Observer(
        builder: (_) {
          if (_categoryStore.fetchPostsFuture.status ==
              FutureStatus.pending) {
            return Center(child: CircularProgressIndicator());
          } else if (_categoryStore.fetchPostsFuture.status ==
              FutureStatus.fulfilled) {
            categoryList = _categoryStore.CategoryList;

            if (categoryList == null || categoryList!.isEmpty) {
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
                  categoryList!.map((singleCategory) {
                    return CategoryItem(
                      singleCategory.id.toString(),
                      singleCategory.name.toString(),
                      singleCategory.image.toString(),
                    );
                  }).toList(),
            ),
          );
        },
      ),
         bottomNavigationBar: SizedBox(
        height: 150, // Adjust the height as needed
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BottomMusicPlayerBar(musicControllerStore: _musicControllerStore),
            AdsScreen(),
          ],
        ),
      ),
    );
  }
}
