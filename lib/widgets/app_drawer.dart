import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
      backgroundColor: const Color.fromARGB(204, 34, 51, 63),

      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text('Menu Drawer'),
              automaticallyImplyLeading: false,
            ),
            Divider(color: Colors.white),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('HOME'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(Routes.home);
              },
            ),
            Divider(color: Colors.white),
            ListTile(
              
              leading: Icon(Icons.download),
              title: Text('DOWNLOAD'),
              onTap: () {},
            ),
            Divider(color: Colors.white),
            ListTile(
              
              leading: Icon(Icons.playlist_add),
              title: Text('PLAYLISTS'),
              onTap: () {},
            ),
            Divider(color: Colors.white),
            ListTile(
              
              leading: Icon(Icons.queue_music_rounded),
              title: Text('MY MUSIC'),
              onTap: () {},
            ),
            Divider(color: Colors.white),
            ListTile(
              
              leading: Icon(Icons.notifications_sharp),
              title: Text('NOTIFICATION'),
              onTap: () {},
            ),
            Divider(color: Colors.white),
            ListTile(
              
              leading: Icon(Icons.share),
              title: Text('INVITE / SHARE'),
              onTap: () {},
            ),
            Divider(color: Colors.white),
            ListTile(
              
              leading: Icon(Icons.star_rate),
              title: Text('RATE US'),
              onTap: () {},
            ),
            Divider(color: Colors.white),
            ListTile(
              
              leading: Icon(Icons.text_snippet_rounded),
              title: Text('FEADBACK'),
              onTap: () {},
            ),
            Divider(color: Colors.white),
            ListTile(
              
              leading: Icon(Icons.thumb_up),
              title: Text('ABOUT US'),
              onTap: () {},
            ),
            Divider(color: Colors.white),
            ListTile(
              
              leading: Icon(Icons.usb_outlined),
              title: Text('USB EXPLORER'),
              onTap: () {},
            ),
            Divider(color: Colors.white),
            _buildThemeButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeButton() {
    return Observer(
      builder: (context) {
        return ListTile(
          onTap: () {
            _themeStore.changeBrightnessToDark(!_themeStore.darkMode);
          },
          leading: Icon(
            _themeStore.darkMode ? Icons.brightness_5 : Icons.brightness_3,
          ),
          title: _themeStore.darkMode ? Text('CHANGE TO LIGHT MODE') : Text('CHANGE TO DARK MODE'),
        );
      },
    );
  }
}
