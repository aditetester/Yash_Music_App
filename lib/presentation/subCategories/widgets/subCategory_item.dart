import 'package:boilerplate_new_version/utils/routes/routes.dart';
import 'package:flutter/material.dart';
class SubCategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final String image;

  const SubCategoryItem(this.id, this.title, this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    void ViewSubCategories() async {
      Navigator.of(context).pushNamed(Routes.musicList , arguments: id);
    }

    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      child: GestureDetector(
        onTap: () => ViewSubCategories(),
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          child: Hero(
            tag: id,
            child: FadeInImage(
              placeholder: AssetImage('assets/icon/icon.png'),
              image: NetworkImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
