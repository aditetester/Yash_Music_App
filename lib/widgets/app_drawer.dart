import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/utils/routes/routes.dart';
import 'package:flutter_svg/svg.dart';
import '../presentation/home/store/theme/theme_store.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final ThemeStore _themeStore = getIt<ThemeStore>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      backgroundColor: Color.fromARGB(229, 255, 255, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          
          color: const Color.fromARGB(181, 239, 237, 237),
          // gradient: LinearGradient(
          //   colors: [Colors.white.withOpacity(0.3), Colors.white.withOpacity(0.3)],
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          // ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom header with back and title
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Image.asset(
                          'assets/images/drawer_back_icon.png',
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Menu",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    _buildMenuItem(Icons.home, 'Home', () {
                      Navigator.of(context).pushReplacementNamed(Routes.home);

                    }, selected: true),
                    _buildMenuItem(Icons.download, 'Downloads', () {
                      Navigator.of(
                        context,
                      ).pop();
                      Navigator.of(
                        context,
                      ).pushNamed(Routes.downloadedMusicPlayList);
                    }),
                    _buildMenuItem(
                      Icons.queue_music_rounded,
                      'My Music',
                      () {},
                    ),
                    _buildMenuItem(Icons.playlist_add, 'Playlists', () {}),
                    _buildMenuItemWithBadge(
                      Icons.notifications,
                      'Notifications',
                      5,
                      () {},
                    ),
                    _buildDarkModeToggle(),
                    _buildMenuItem(Icons.share, 'Invite/Share', () {}),
                    _buildMenuItem(Icons.star_border, 'Rate Us', () {}),
                    _buildMenuItem(Icons.feedback_outlined, 'Feedback', () {}),
                    _buildMenuItem(Icons.info_outline, 'About Us', () {}),
                    _buildMenuItem(Icons.usb_outlined, 'USB Explorer', () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title,
    VoidCallback onTap, {
    bool selected = false,
  }) {
    return ListTile(
      selected: selected,
      selectedTileColor: const Color.fromARGB(255, 150, 196, 233),
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildMenuItemWithBadge(
    IconData icon,
    String title,
    int badgeCount,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing:
          badgeCount > 0
              ? Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$badgeCount',
                  style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Poppins'),
                ),
              )
              : null,
      onTap: onTap,
    );
  }

  Widget _buildDarkModeToggle() {
    return Observer(
      builder: (context) {
        return SwitchListTile(
          activeColor: Colors.blue,
          title: Text(
            'Dark Mode',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          secondary: Icon(Icons.nightlight_round),
          value: _themeStore.darkMode,
          onChanged: (value) {
            // _themeStore.changeBrightnessToDark(value);
          },
        );
      },
    );
  }
}
