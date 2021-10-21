import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interintel/assistants/notification_api.dart';
import 'package:interintel/config/app_config.dart';
import 'package:interintel/dialog/update_dialog.dart';
import 'package:interintel/models/user.dart';
import 'package:interintel/my_custom_widgets/flip_card_widget.dart';
import 'package:interintel/my_custom_widgets/follow_button_widget.dart';
import 'package:interintel/my_custom_widgets/random_button_widget.dart';
import 'package:interintel/widgets/progress_widget.dart';
import 'package:interintel/widgets/user_card.dart';

class DesignScreen extends StatefulWidget {
  const DesignScreen({Key? key}) : super(key: key);

  @override
  _DesignScreenState createState() => _DesignScreenState();
}

class _DesignScreenState extends State<DesignScreen> {
  // Get an instance of UserProvider class
  final UserProvider userProvider = UserProvider();
  Future<List<User>>? futureUsers;
  final _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();

    // We obtain all the users saved
    setState(() {
      futureUsers = userProvider.getAllUsers();
    });
  }

  void removeUser(User user, int index) async {
    // Remove User from saved list
    _listKey.currentState!.removeItem(
        index,
        (context, animation) => UserCard(
              user: user,
              edit: () => editUserInfo(user),
              remove: () => removeUser(user, index),
            ));

    await userProvider.removeUser(user).then((value) async {
      // Show notification
      await NotificationApi.showNotification(
        title: "User has been deleted!",
        body: "User information for ${user.name} has been deleted",
        payload: user.email,
      );

      Fluttertoast.showToast(
          msg: "Removed ${user.name} successfully",
          backgroundColor: Colors.black45);
      setState(() {
        futureUsers = userProvider.getAllUsers();
      });
    });
  }

  void editUserInfo(User user) async {
    String result = await showDialog(
        context: context,
        builder: (c) {
          return UpdateDialog(
            user: user,
          );
        });

    if (result == "updated") {
      // Show notification
      await NotificationApi.showNotification(
        title: "User Info Updated Successfully",
        body: "User information for ${user.name} has been updated",
        payload: user.email,
      );

      Fluttertoast.showToast(
          msg: "Updated ${user.name} successfully",
          backgroundColor: Colors.black45);
      setState(() {
        futureUsers = userProvider.getAllUsers();
      });
    }
  }

  Widget myCustomWidgets() {
    Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          color: InterIntel.themeColor.withOpacity(0.5),
          height: 1.0,
          width: size.width * 0.8,
        ),
        const SizedBox(
          height: 20.0,
        ),
        Text(
          "My Custom Widgets",
          style: Theme.of(context).textTheme.headline6,
        ),
        const Text("1. Simple Animated Containers"),
        const RandomButtonWidget(),
        const FollowButtonWidget(),
        const SizedBox(
          height: 20.0,
        ),
        const Text("2. 3D Card Flip"),
        const Text("Drag Left or Right to flip"),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: FlipCardWidget(
            front: Image.asset("assets/logo.png"),
            back: Image.asset("assets/back.png"),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = DynamicTheme.of(context)!.theme == ThemeData.dark();

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: isDark ? Colors.grey.shade900 : InterIntel.themeColor,
        title: Text(
          "Design",
          style: GoogleFonts.fredokaOne(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<User>>(
        // Get the list of users saved in shared preferences
        future: futureUsers,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // if the snapshot has NO data we display a circular progress indicator
            return circularProgress();
          } else {
            // If snapshot has data
            // we obtain it and store in users variable
            List<User> users = snapshot.data!;

            if (users.isEmpty) {
              // if the users list has no user we display no users
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.people_alt_rounded,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    const Text(
                      "No User Information",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    myCustomWidgets()
                  ],
                ),
              );
            } else {
              // If the users list has users then we display the list in cards
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    AnimatedList(
                      key: _listKey,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      initialItemCount: users.length,
                      itemBuilder: (context, index, animation) {
                        User user = users[index];

                        return UserCard(
                          user: user,
                          edit: () => editUserInfo(user),
                          remove: () => removeUser(user, index),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    myCustomWidgets()
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}
