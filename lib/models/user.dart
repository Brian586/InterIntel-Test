import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String? name;
  final String? email;
  final String? phone;
  final int? timestamp;

  User({
    this.name,
    this.email,
    this.phone,
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "timestamp": timestamp,
      "phone": phone,
    };
  }

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
        name: jsonData["name"],
        email: jsonData["email"],
        timestamp: jsonData["timestamp"],
        phone: jsonData["phone"],
    );
  }

  // This converts a list of users to encoded json data
  static String encode(List<User> usersList) => json.encode(
    usersList
        .map<Map<String, dynamic>>((user) => user.toMap())
        .toList(),
  );

  // This converts a string of encoded data into a list of users
  static List<User> decode(String usersString) {
    if (usersString.isNotEmpty) {
      return (json.decode(usersString) as List<dynamic>)
          .map<User>((user) => User.fromJson(user))
          .toList();
    } else {
      return [];
    }
  }

}


class UserProvider {
  Future<String> addUser(User user) async {
    // Get instance of shared preferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get saved string from "users" key
    final String usersString = prefs.getString("users") ?? "";

    // Decode the usersString variable into a list of Users
    List<User> usersList = User.decode(usersString);

    if(usersList.where((mUser) => mUser.email == user.email).toList().isNotEmpty)
      {
        // if this list already has the user
        Fluttertoast.showToast(msg: "User already exists!", backgroundColor: Colors.black45);

        return "exists";
      }
    else
      {
        // if this list does not have this user

        // Add this user
        usersList.add(user);

        // Encode the usersList
        final String encodedData = User.encode(usersList);

        // Save the encoded data to sharedPrefs
        await prefs.setString("users", encodedData);

        Fluttertoast.showToast(msg: "Success!", backgroundColor: Colors.black45);

        return "success";
      }
  }

  Future<List<User>> getAllUsers() async {
    // Get instance of shared preferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get saved string from "users" key
    final String usersString = prefs.getString("users") ?? "";

    // Decode the usersString variable into a list of Users
    List<User> usersList = User.decode(usersString);

    // This sorts the list of users according to the time the information
    // was created (in ascending order)
    usersList.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));

    // Return the usersList in the preferred order
    return usersList.reversed.toList();
  }

  Future<void> removeUser(User user) async {
    // Get instance of shared preferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get saved string from "users" key
    final String usersString = prefs.getString("users") ?? "";

    // Decode the usersString variable into a list of Users
    List<User> usersList = User.decode(usersString);

    usersList.removeWhere((mUser) => mUser.timestamp == user.timestamp);

    // Encode the usersList
    final String encodedData = User.encode(usersList);

    // Save the encoded data to sharedPrefs
    await prefs.setString("users", encodedData);

  }

  Future<void> updateUserInfo(User oldUserInfo, User newUserInfo) async {
    // Get instance of shared preferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get saved string from "users" key
    final String usersString = prefs.getString("users") ?? "";

    // Decode the usersString variable into a list of Users
    List<User> usersList = User.decode(usersString);

    usersList.removeWhere((mUser) => mUser.timestamp == oldUserInfo.timestamp);

    usersList.add(newUserInfo);

    // Encode the usersList
    final String encodedData = User.encode(usersList);

    // Save the encoded data to sharedPrefs
    await prefs.setString("users", encodedData);

    Fluttertoast.showToast(msg: "Success!", backgroundColor: Colors.black45);

  }
}