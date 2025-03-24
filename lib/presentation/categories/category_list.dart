import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/presentation/categories/store/categories_store.dart';
import 'package:boilerplate_new_version/presentation/categories/widgets/categories_items.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  CategoriesStore _CategoriesStore = getIt<CategoriesStore>();
  Future<List<dynamic>>? categories;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    categories = _CategoriesStore.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Music Categories")),
      body: FutureBuilder<List<dynamic>>(
        future: categories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No categories available."));
          } else {
            final data = snapshot.data!;
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
                    data.map((category) {
                      return CategoriesItem(
                        category['_id'], // Pass category ID
                        category['category_name'], // Pass category name
                        "http://192.168.1.143:3000/${category['image']['file']}", // Construct image URL
                      );
                    }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
