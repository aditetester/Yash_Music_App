import 'package:boilerplate_new_version/constants/app_theme.dart';
import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/domain/entity/categories/category.dart';
import 'package:boilerplate_new_version/presentation/categories/store/categories_store.dart';
import 'package:boilerplate_new_version/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';


class CategoryViewScreen extends StatefulWidget {
 const CategoryViewScreen({super.key});


 @override
 State<CategoryViewScreen> createState() => _CategoryViewScreenState();
}


class _CategoryViewScreenState extends State<CategoryViewScreen> {
 final CategoryStore _CategoryStore = getIt<CategoryStore>();
 List<CategoryModule>? categories = [];
 bool _isExpanded = false;
 bool _showShimmer = true;


 @override
 void initState() {
   super.initState();
   _CategoryStore.fetchCategories();


   // Delay for 3 seconds before removing shimmer
   Future.delayed(Duration(seconds: 2), () {
     setState(() {
       _showShimmer = false;
     });
   });
 }


 @override
 Widget build(BuildContext context) {
   return Container(
     padding: EdgeInsets.only(left: 10, right: 0),
     child: Column(
       children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text("Categories", style: AppThemeData.textThemeBold),
             GestureDetector(
               onTap: () {
                 setState(() {
                   _isExpanded = !_isExpanded;
                 });
               },
               child: Text(
                 _isExpanded ? "See less" : "See all",
                 style: AppThemeData.textThemeRegular,
               ),
             ),
           ],
         ),
         Observer(
           builder: (_) {
             if (_showShimmer) {
               return _shimmerGrid(); // Show shimmer for 3 secs
             }


             if (_CategoryStore.fetchPostsFuture.status ==
                 FutureStatus.fulfilled) {
               categories = _CategoryStore.CategoryList;


               if (categories == null || categories!.isEmpty) {
                 return Padding(
                   padding: const EdgeInsets.only(top: 20.0),
                   child: Text(
                     "No categories available",
                     style: AppThemeData.textThemeMedium,
                   ),
                 );
               }


               int visibleItemCount =
                   _isExpanded
                       ? categories!.length
                       : (categories!.length >= 4 ? 4 : categories!.length);


               return GridView.builder(
                 shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
                 itemCount: visibleItemCount,
                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2,
                   crossAxisSpacing: 14,
                   mainAxisSpacing: 14,
                   childAspectRatio: 3,
                 ),
                 itemBuilder: (context, index) {
                   final item = categories![index];
                   return GestureDetector(
                     onTap: () {
                       Navigator.of(context).pushNamed(
                         Routes.subCategoryList,
                         arguments: {'id': item.id, 'name': item.name},
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
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           Container(
                             width: 9.h,
                             child: Text(
                               item.name ?? "",
                               style: TextStyle(
                                 fontFamily: 'Poppins',
                                 fontSize: 14,
                                 fontWeight: FontWeight.w600,
                                 color: Colors.white,
                               ),
                               overflow: TextOverflow.ellipsis,
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(
                               top: 5.0,
                               left: 15,
                               right: 5,
                             ),
                             child: Image.asset(
                               "assets/images/demo_category_icon.png",
                               height: 7.h,
                               width: 10.w,
                               fit: BoxFit.fitHeight,
                             ),
                           ),
                         ],
                       ),
                     ),
                   );
                 },
               );
             }


             return SizedBox.shrink(); // Fallback if not fulfilled yet and shimmer is done
           },
         ),
       ],
     ),
   );
 }


 Widget _shimmerGrid() {
   return GridView.builder(
     shrinkWrap: true,
     physics: NeverScrollableScrollPhysics(),
     itemCount: 4,
     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
       crossAxisCount: 2,
       crossAxisSpacing: 14,
       mainAxisSpacing: 14,
       childAspectRatio: 3,
     ),
     itemBuilder: (context, index) {
       return Shimmer.fromColors(
         baseColor: Colors.grey.shade300,
         highlightColor: Colors.grey.shade100,
         child: Container(
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(16),
             color: Colors.white,
           ),
           padding: EdgeInsets.symmetric(horizontal: 12),
           child: Row(
             children: [
               Container(width: 8.h, height: 4.h, color: Colors.white),
               SizedBox(width: 10),
               Container(
                 width: 7.h,
                 height: 7.h,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(8),
                 ),
               ),
             ],
           ),
         ),
       );
     },
   );
 }
}

// old ui----------------------------------------------------------
//  ListView.builder(
//   scrollDirection: Axis.horizontal,
//   itemCount: 3, // Example data count
//   itemBuilder: (context, index) {
//     final item = categories![index];
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).pushNamed(
//           Routes.subCategoryList,
//           arguments: categories![index].id,
//         );
//       },
//       child: Container(
//         width: 120,
//         margin: EdgeInsets.only(right: 10),
//         decoration: BoxDecoration(
//           color: Colors.teal[800],
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Stack(
//           fit: StackFit.expand,
//           children: [
//             Image.network(
//               item.image.toString(),
//               fit: BoxFit.cover,
//             ),
//             Positioned.fill(
//               child: Container(
//                 color: Colors.black.withOpacity(
//                   0.5,
//                 ), // Adjust opacity for desired lightness
//               ),
//             ),
//             Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.headphones,
//                     color: Colors.white,
//                     size: 48,
//                   ),
//                   SizedBox(height: 8),
//                   FittedBox(
//                     fit: BoxFit.contain,
//                     child: Text(
//                       item.name.toString(),
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   },
// );