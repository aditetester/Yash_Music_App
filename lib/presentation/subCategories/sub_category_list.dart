import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/presentation/subCategories/store/sub_categories_store.dart';
import 'package:boilerplate_new_version/presentation/subCategories/widgets/subCategories_items.dart';
import 'package:flutter/material.dart';

class SubCategoryList extends StatefulWidget {
  const SubCategoryList({super.key});

  @override
  State<SubCategoryList> createState() => _SubCategoryListState();
}

class _SubCategoryListState extends State<SubCategoryList> {
 SubCategoriesStore _SubCategoriesStore = getIt<SubCategoriesStore>();
  Future<List<dynamic>>? subCategories;
  @override
  void initState() {
    super.initState();
  }

  Future<void> getData(var categoryId) async {
    // subCategories = _SubCategoriesStore.fetchSubCategories(categoryId);
    
  }
  @override
  Widget build(BuildContext context) {

    final categoryId = ModalRoute.of(context)?.settings.arguments as String;
    getData(categoryId);
    return Scaffold(
      appBar: AppBar(title: Text("Sub Categories")),
      body: FutureBuilder<List<dynamic>>(
        future: subCategories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No Subcategories available."));
          } else {
            final data = snapshot.data!;
            print(data);
            return Container(
              padding: EdgeInsets.all(10),
              child: GridView(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  childAspectRatio: 2.4 / 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                children:
                    data.map((subCategory) {
                      
                      return subCategory['category']['_id'] == categoryId ? SubCategoriesItem(
                        subCategory['_id'], // Pass category ID
                        subCategory['subcategory_name'], // Pass category name
                        "http://192.168.1.143:3000/${subCategory['image']['file']}", // Construct image URL
                      ): Container();
                    }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
