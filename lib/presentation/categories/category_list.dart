import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/domain/entity/post/category_list.dart';
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
  List<dynamic>? categories;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
   categories =  _CategoriesStore.fetchCategories();
     
    print(categories);
    
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Music Categories")),
      body: FutureBuilder<void>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else
            return Container(
              padding: EdgeInsets.all(10),
              child: GridView(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400,
                  childAspectRatio: 4 / 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                children:[]
                    // data!.map((Element) {
                    //   return CategoriesItem(
                    //     Element["_id"],
                    //     Element["category_name"],
                    //     Element["category_name"]["file"],
                    //   );
                    // }).toList(),
              ),
            );
          }
        
      ),
    );
  }
}
