import 'package:flutter/material.dart';
import 'package:interintel/config/app_config.dart';
import 'package:interintel/models/user.dart';
import 'package:interintel/widgets/custom_textfield.dart';

class UpdateDialog extends StatefulWidget {
  final User? user;
  const UpdateDialog({Key? key, this.user}) : super(key: key);

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  UserProvider provider = UserProvider();

  //Update user information
  updateUserInfo() async {
    User newUserInfo = User(
      name: nameController.text.trim(),
      email: widget.user!.email!,
      phone: phoneController.text.trim(),
      timestamp: DateTime.now().millisecondsSinceEpoch
    );


    await provider.updateUserInfo(widget.user!, newUserInfo).then((value) => Navigator.pop(context, "updated"));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //key: key,
      contentPadding: EdgeInsets.zero,
      title: Center(child: Text("Edit: ${widget.user!.name}", style: const TextStyle(color: InterIntel.themeColor),)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20.0,),
          CustomTextField(
            controller: nameController,
            data: Icons.person,
            hintText: "Name",
            inputType: TextInputType.name,
          ),
          CustomTextField(
            controller: phoneController,
            data: Icons.phone_android_rounded,
            hintText: "Phone Number",
            inputType: TextInputType.phone,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: ()=> Navigator.pop(context, "not"),
          child: const Text("CANCEL", style: TextStyle(color: Colors.grey),),
        ),
        TextButton(
          onPressed: () => updateUserInfo(),
          child: const Text("UPDATE", style: TextStyle(color: InterIntel.themeColor),),
        )
      ],
    );
  }
}
