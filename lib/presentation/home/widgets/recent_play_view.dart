import 'package:boilerplate_new_version/constants/app_theme.dart';
import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/presentation/downloaded_music_list/store/download_list_store.dart';
import 'package:boilerplate_new_version/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

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
    final DownloadListStore _downloadListStore = getIt<DownloadListStore>();

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(Routes.recentMusicPlayListScreen);
        },
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
                    image: NetworkImage(image),
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
                      Container(
                        width: 22.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title, // Title
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
                              subTitle, // Subtitle
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

                      //  SizedBox(width: 13,),
                      SizedBox(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _downloadListStore.getDownloadedList?.contains(
                                      title.toString(),
                                    ) ??
                                    false
                                ? SvgPicture.asset(
                                  "assets/svg/downloaded_icon.svg",
                                  height: 2.h,
                                  width: 2.w,
                                )
                                : SvgPicture.asset(
                                  "assets/svg/download_icon.svg",
                                  height: 2.h,
                                  width: 2.w,
                                ),
                          SizedBox(width: 5,),
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
