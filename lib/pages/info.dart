import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interintel/animations/router_animation.dart';
import 'package:interintel/assistants/notification_api.dart';
import 'package:interintel/config/app_config.dart';
import 'package:interintel/dialog/error_dialog.dart';
import 'package:interintel/dialog/loading_dialog.dart';
import 'package:interintel/models/user.dart';
import 'package:interintel/pages/design.dart';
import 'package:interintel/widgets/custom_drawer.dart';
import 'package:interintel/widgets/custom_textfield.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  UserProvider userProvider = UserProvider();

  @override
  void initState() {
    super.initState();

    // We initialize our notifications plugin
    NotificationApi.init();

    // Then we listen for notifications
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) {
    // When the notification is clicked we navigate to the DesignScreen()

    Route route = RouterAnimation().animateToRoute(const DesignScreen());
    Navigator.push(context, route);
  }

  void showError(String message) {
    // Close the loading dialog
    Navigator.pop(context);

    //Open Error dialog
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(
            message: message,
          );
        });
  }

  void saveUserInfo() async {
    // Show the loading dialog
    showDialog(
        context: context,
        builder: (c) {
          return const LoadingAlertDialog(
            message: "Saving Information...",
          );
        });

    // If user gives all information
    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty) {
      // Lets create a user object
      User user = User(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          phone: phoneController.text.trim(),
          timestamp: DateTime.now()
              .millisecondsSinceEpoch // This captures the time user info was saved
          );

      // Then we save the user information in shared preferences

      await userProvider.addUser(user).then((response) async {
        if (response == "success") {
          // Show notification
          await NotificationApi.showNotification(
            title: "User Info saved Successfully!",
            body:
                "Hey ${nameController.text.trim()}, your information has been saved successfully!",
            payload: emailController.text.trim(),
          );

          // Clear the textFields
          nameController.clear();
          emailController.clear();
          phoneController.clear();

          // Close the loading dialog
          Navigator.pop(context);
          // Then navigate to the Design Screen
          Route route = RouterAnimation().animateToRoute(const DesignScreen());
          Navigator.push(context, route);
        } else if (response == "exists") {
          //if response is "exists"
          showError(
              "User Already Exists! Please try with another email address");
        } else {
          showError("Error: Failed");
        }
      });
    } else {
      // If user does NOT provide all information
      showError("Please Provide All Information");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isDark = DynamicTheme.of(context)!.theme == ThemeData.dark();

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: isDark ? Colors.grey.shade900 : InterIntel.themeColor,
        title: Text(
          "User Information",
          style: GoogleFonts.fredokaOne(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Image.asset(
                "assets/admin.png",
                height: size.height * 0.3,
                width: size.width * 0.8,
                fit: BoxFit.contain,
              ),
              CustomTextField(
                controller: nameController,
                data: Icons.person,
                hintText: "Name",
                inputType: TextInputType.name,
              ),
              const SizedBox(
                height: 20.0,
              ),
              CustomTextField(
                controller: emailController,
                data: Icons.email_outlined,
                hintText: "Email Address",
                inputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20.0,
              ),
              CustomTextField(
                controller: phoneController,
                data: Icons.phone_android,
                hintText: "Phone Number",
                inputType: TextInputType.phone,
              ),
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                height: 50.0,
                width: 120.0,
                child: RaisedButton(
                  onPressed: saveUserInfo,
                  color: InterIntel.themeColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Text(
                    "Submit",
                    style: GoogleFonts.fredokaOne(
                      color: Colors.white,
                      //fontWeight: FontWeight.bold
                    ),
                  ),
                  elevation: 5.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
