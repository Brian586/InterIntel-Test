import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:interintel/animations/router_animation.dart';
import 'package:interintel/config/app_config.dart';
import 'package:interintel/pages/design.dart';
import 'package:interintel/pages/dictionary.dart';
import 'package:interintel/pages/response.dart';
import 'package:interintel/theme/app_theme.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  navigateToPage(BuildContext context, Widget newPage) {
    Route route = RouterAnimation().popAnimateToRoute(newPage);
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = DynamicTheme.of(context)!.theme == ThemeData.dark();
    Size size = MediaQuery.of(context).size;
    TextStyle style = const TextStyle(color: Colors.grey);

    return Drawer(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          DrawerHeader(
            child: Image.asset(
              "assets/logo.png",
              height: 50.0,
              width: size.width,
              fit: BoxFit.fitWidth,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.person_add_alt_1_rounded,
              color: InterIntel.themeColor,
            ),
            title: Text(
              "Info",
              style: style.apply(color: InterIntel.themeColor),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.people_alt_rounded,
              color: Colors.grey,
            ),
            title: Text(
              "Design",
              style: style,
            ),
            onTap: () => navigateToPage(context, const DesignScreen()),
          ),
          ListTile(
            leading: const Icon(
              Icons.receipt_long_rounded,
              color: Colors.grey,
            ),
            title: Text(
              "Response",
              style: style,
            ),
            onTap: () => navigateToPage(context, const ResponseScreen()),
          ),
          ListTile(
            leading: const Icon(
              Icons.description_outlined,
              color: Colors.grey,
            ),
            title: Text(
              "Dictionary",
              style: style,
            ),
            onTap: () => navigateToPage(context, const DictionaryScreen()),
          ),
          const SizedBox(
            height: 60.0,
          ),
          ListTile(
            leading: const Icon(
              Icons.palette,
              color: Colors.grey,
            ),
            title: Text(
              "Dark Theme",
              style: style,
            ),
            trailing: Switch(
              activeColor: InterIntel.themeColor,
              inactiveThumbColor: Theme.of(context).scaffoldBackgroundColor,
              inactiveTrackColor: Colors.grey,
              value: isDark,
              onChanged: (value) {
                print(value);
                if (value) {
                  DynamicTheme.of(context)!.setTheme(AppThemes.dark);
                } else {
                  DynamicTheme.of(context)!.setTheme(AppThemes.light);
                }
                //changeBrightness();
              },
            ),
          )
        ],
      ),
    );
  }
}
