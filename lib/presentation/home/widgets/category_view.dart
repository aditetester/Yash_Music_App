import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/presentation/categories/store/categories_store.dart';
import 'package:boilerplate_new_version/utils/routes/routes.dart';
import 'package:flutter/material.dart';

class CategoryViewScreen extends StatefulWidget {
  const CategoryViewScreen({super.key});

  @override
  State<CategoryViewScreen> createState() => _CategoryViewScreenState();
}

class _CategoryViewScreenState extends State<CategoryViewScreen> {
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
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.categoryList);
                },
                child: Text(
                  "View All",
                  style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: FutureBuilder<List<dynamic>>(
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
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3, // Example data count
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(Routes.categoryList);
                        },
                        child: Container(
                          width: 120,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Colors.teal[800],
                            borderRadius:  BorderRadius.circular(8),
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                "http://192.168.1.143:3000/${item['image']['file']}",
                                fit: BoxFit.cover,
                              ),
                              Positioned.fill(
                                child: Container(
                                  color: Colors.black.withOpacity(
                                    0.5,
                                  ), // Adjust opacity for desired lightness
                                ),
                              ),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.headphones,
                                      color: Colors.white,
                                      size: 48,
                                    ),
                                    SizedBox(height: 8),
                                    FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        item['category_name'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
