import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../store/language/language_store.dart';
import '../store/theme/theme_store.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final LanguageStore _languageStore = getIt<LanguageStore>();
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
                Navigator.of(context).pushReplacementNamed('/');
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
            Divider(color: Colors.white),
            _buildLanguageButton(),
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

  Widget _buildLanguageButton() {
    return ListTile(
      onTap: () {
        _buildLanguageDialog();
      },
      leading: Icon(Icons.language),
      title: Text("CHANGE LANGUAGE"),
    );
  }

  _buildLanguageDialog() {
    _showDialog<String>(
      context: context,
      child: AlertDialog(
        // borderRadius: 5.0,
        // enableFullWidth: true,
        title: Text(
          AppLocalizations.of(context).translate('home_tv_choose_language'),
        ),
        // headerColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // closeButtonColor: Colors.white,
        // enableCloseButton: true,
        // enableBackButton: false,
        // onCloseButtonClicked: () {
        //   Navigator.of(context).pop();
        // },
        actions:
            _languageStore.supportedLanguages
                // children: _languageStore.supportedLanguages
                .map(
                  (object) => ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.all(0.0),
                    title: Text(
                      object.language,
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      // change user language based on selected locale
                      _languageStore.changeLanguage(object.locale);
                    },
                  ),
                )
                .toList(),
      ),
    );
  }

  _showDialog<T>({required BuildContext context, required Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T? value) {
      // The value passed to Navigator.pop() or null.
    });
  }
}
