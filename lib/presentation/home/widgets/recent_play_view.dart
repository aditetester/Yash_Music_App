import 'package:boilerplate_new_version/constants/app_theme.dart';
import 'package:flutter/material.dart';

class RecentPlayView extends StatelessWidget {
  final String id;
  final String title;
  final String subTitle;
  final String image;

  const RecentPlayView({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: 150, // adjust as needed
          height: 180, // adjust as needed
          child: Stack(
            children: [
              Positioned.fill(
                child: Hero(
                  tag: id,
                  child: FadeInImage(
                    placeholder: AssetImage('assets/icon/icon.png'),
                    image: AssetImage("assets/images/demo_img.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Footer bar
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 50, // Fixed height to prevent collapse
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      // Flexible text column
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ek Tara Rasta", // Title
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              "Ej Sitara", // Subtitle
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      // Icon buttons in a fixed-width box
                      SizedBox(
                        width: 60, // small but enough space for 2 icons
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.download_rounded, size: 20),
                            Icon(Icons.more_vert_outlined, size: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
