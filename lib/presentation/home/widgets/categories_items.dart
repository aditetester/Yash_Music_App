import 'package:flutter/material.dart';
class CategoriesItem extends StatelessWidget {
  final String id;
  final String title;
  final String image;

  const CategoriesItem(this.id, this.title, this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    void productView() async {

    }

    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      child: GestureDetector(
        onTap: () => productView(),
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20),
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
