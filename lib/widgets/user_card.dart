import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:interintel/config/app_config.dart';
import 'package:interintel/config/time_converter.dart';
import 'package:interintel/models/user.dart';
import 'dart:math' as math;

class UserCard extends StatelessWidget {
  final User? user;
  final void Function()? edit;
  final void Function()? remove;

  const UserCard({Key? key, this.user, this.edit, this.remove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        height: size.height * 0.4,
        width: size.width,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
            topLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(5.0),
          )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: size.width,
                      decoration: BoxDecoration(
                          color: InterIntel.themeColor.withOpacity(0.3),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            topLeft: Radius.circular(5.0),
                          )),
                    ),
                    Positioned(
                      top: 0.0,
                      left: 0.0,
                      right: 0.0,
                      bottom: 0.0,
                      child: Center(
                        child: Text(
                          user!.name![0],
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .apply(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 30.0,
                  backgroundColor:
                      Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                          .withOpacity(1.0), // this displays random colors
                  child: Center(
                    child: Text(
                      user!.name![0],
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                title: Text(
                  user!.name!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Created " +
                    TimeConverter().readTimestamp(user!.timestamp!)),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Table(
                  columnWidths: const {0: FractionColumnWidth(.2)},
                  children: [
                    TableRow(children: [
                      const Text(
                        "Email",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Text(user!.email!)
                    ]),
                    TableRow(children: [
                      const Text(
                        "Phone",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Text(user!.phone!)
                    ]),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('EDIT'),
                    onPressed: edit,
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    child: const Text('REMOVE'),
                    onPressed: remove,
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
