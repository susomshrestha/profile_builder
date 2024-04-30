import 'dart:io';

import 'package:profile_builder/models/preference_item.dart';

class User {
  final String name;
  final int age;
  final String bio;
  final String occupation;
  final File image;
  final List<PreferenceItem> preferences;

  User(this.name, this.age, this.bio, this.occupation, this.preferences, this.image);
}