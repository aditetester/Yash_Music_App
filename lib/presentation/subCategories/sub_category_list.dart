import 'package:boilerplate_new_version/constants/app_theme.dart';
import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/domain/entity/subCategories/subCategory.dart';
import 'package:boilerplate_new_version/presentation/musicPlayer/store/musicController/music_controller_store.dart';
import 'package:boilerplate_new_version/presentation/subCategories/store/sub_categories_store.dart';
import 'package:boilerplate_new_version/presentation/subCategories/widgets/subCategory_item.dart';
import 'package:boilerplate_new_version/utils/routes/routes.dart';
import 'package:boilerplate_new_version/widgets/bottom_downloadedMusicPlayer_bar.dart';
import 'package:boilerplate_new_version/widgets/bottom_musicPlayer_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:sizer/sizer.dart';

class SubCategoryList extends StatefulWidget {
  const SubCategoryList({super.key});

  @override
  State<SubCategoryList> createState() => _SubCategoryListState();
}

class _SubCategoryListState extends State<SubCategoryList> {
  final MusicControllerStore _musicControllerStore =
      getIt<MusicControllerStore>();
  SubCategoriesStore _subCategoryStore = getIt<SubCategoriesStore>();
  List<SubCategoryModule>? subcategoryList = [];

  @override
  void initState() {
    super.initState();
    _subCategoryStore.fetchSubCategories();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> category =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xC7DFDDEA),
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 15, right: 20),
                  child: Column(
                    children: [
                      //App Bar Section
                      _builderTopArea(context, category['name'].toString()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _builderBodyArea(
                          context,
                          category['id'].toString(),
                        ),
                      ),
                      // Categories Section
                      // CategoryViewScreen(),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Observer(
        builder:
            (context) => IntrinsicHeight(
              child: Column(
                mainAxisSize:
                    MainAxisSize
                        .min, // Ensure the column takes only required height
                children: [
                  _musicControllerStore.isDownloadedPlaying
                      ? BottomDownloadedMusicPlayerBar(
                        musicControllerStore: _musicControllerStore,
                      )
                      : BottomMusicPlayerBar(
                        musicControllerStore: _musicControllerStore,
                      ),
                  // AdsScreen(),
                ],
              ),
            ),
      ),
    );
  }

  Widget _builderTopArea(BuildContext context, String heading) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Image.asset(
                  'assets/images/drawer_back_icon.png',
                  height: 7.5.h,
                  width: 7.5.w,
                ),
              );
            },
          ),
          SizedBox(width: 5),
          Expanded(
            child: Container(
              height: 4.h,

              alignment: Alignment.centerLeft,
              child: Text(
                heading,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _builderBodyArea(BuildContext context, String categoryId) {
    return Observer(
      builder: (_) {
        _subCategoryStore.SelectSubCategories(categoryId);
        if (_subCategoryStore.fetchPostsFuture.status == FutureStatus.pending) {
          return Center(child: CircularProgressIndicator());
        } else if (_subCategoryStore.fetchPostsFuture.status ==
            FutureStatus.fulfilled) {
          subcategoryList = _subCategoryStore.subCategoryList;

          if (subcategoryList!.isEmpty || subcategoryList!.isEmpty) {
            return Center(child: Text("No categories available"));
          }
        }
        return subcategoryList!.length == 0
            ? Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Text(
                "No Sub categories available",
                style: AppThemeData.textThemeMedium,
              ),
            )
            : Column(
              children: [
                GridView.builder(
                  padding: EdgeInsets.zero,
                
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: subcategoryList!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final item = subcategoryList![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          Routes.musicList,
                          arguments: {
                            'id': subcategoryList![index].id,
                            'name': subcategoryList![index].name,
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 29, 162, 244),
                              Color.fromARGB(255, 156, 213, 251),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 90,
                              child: Text(
                                item.name.toString(),
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            //   Image.network(
                            //   item.image.toString(),
                            //   fit: BoxFit.cover,
                            // ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
      },
    );
  }
}

// old UI---------------------------------------------------------

// import 'package:boilerplate_new_version/di/service_locator.dart';
// import 'package:boilerplate_new_version/domain/entity/subCategories/subCategory.dart';
// import 'package:boilerplate_new_version/presentation/musicPlayer/store/musicController/music_controller_store.dart';
// import 'package:boilerplate_new_version/presentation/subCategories/store/sub_categories_store.dart';
// import 'package:boilerplate_new_version/presentation/subCategories/widgets/subCategory_item.dart';
// import 'package:boilerplate_new_version/widgets/bottom_downloadedMusicPlayer_bar.dart';
// import 'package:boilerplate_new_version/widgets/bottom_musicPlayer_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:mobx/mobx.dart';

// class SubCategoryList extends StatefulWidget {
//   const SubCategoryList({super.key});

//   @override
//   State<SubCategoryList> createState() => _SubCategoryListState();
// }

// class _SubCategoryListState extends State<SubCategoryList> {
//   final MusicControllerStore _musicControllerStore =
//       getIt<MusicControllerStore>();
//   SubCategoriesStore _subCategoryStore = getIt<SubCategoriesStore>();
//   List<SubCategoryModule>? subcategoryList = [];

//   @override
//   void initState() {
//     super.initState();
//     _subCategoryStore.fetchSubCategories();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final String categoryId =
//         ModalRoute.of(context)!.settings.arguments as String;
//     return Scaffold(
//       appBar: AppBar(title: Text("Music Section")),
//       body: Observer(
//         builder: (_) {
//           _subCategoryStore.SelectSubCategories(categoryId);
//           if (_subCategoryStore.fetchPostsFuture.status ==
//               FutureStatus.pending) {
//             return Center(child: CircularProgressIndicator());
//           } else if (_subCategoryStore.fetchPostsFuture.status ==
//               FutureStatus.fulfilled) {
//             subcategoryList = _subCategoryStore.subCategoryList;

//             if (subcategoryList == null || subcategoryList!.isEmpty) {
//               return Center(child: Text("No categories available"));
//             }
//           }
//           return Container(
//             padding: EdgeInsets.all(10),
//             child: GridView(
//               gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                 maxCrossAxisExtent: 300,
//                 childAspectRatio: 2.7 / 3,
//                 crossAxisSpacing: 20,
//                 mainAxisSpacing: 20,
//               ),
//               children:
//                   subcategoryList!.map((singleSubCategory) {
//                     return SubCategoryItem(
//                       singleSubCategory.id.toString(),
//                       singleSubCategory.name.toString(),
//                       singleSubCategory.image.toString(),
//                     );
//                   }).toList(),
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar: Observer(
//         builder: (context) => IntrinsicHeight(
//           child: Column(
//             mainAxisSize:
//                 MainAxisSize.min, // Ensure the column takes only required height
//             children: [
//               _musicControllerStore.isDownloadedPlaying
//                   ? BottomDownloadedMusicPlayerBar(
//                     musicControllerStore: _musicControllerStore,
//                   )
//                   : BottomMusicPlayerBar(
//                     musicControllerStore: _musicControllerStore,
//                   ),
//               // AdsScreen(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
