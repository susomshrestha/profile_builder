import 'package:flutter/material.dart';
import 'package:profile_builder/models/user.dart';
import 'package:profile_builder/widgets/custom_preference.dart';

class Profile extends StatelessWidget {
  const Profile({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 140,
            child: user.image.path.isEmpty
                ? Image.asset(
                    'assets/images/profile.jpg',
                    fit: BoxFit.fill,
                  )
                : Image.file(user.image, fit: BoxFit.cover),
          ),
          _buildUserInfo(context),
          _buildUserBio(context)
        ],
      ),
    );
  }

  Widget _buildUserBio(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: 150,
      child: Card(
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.zero,
            bottomRight: Radius.zero,
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 60, // Set a fixed height for the bio
                child: SingleChildScrollView(
                  child: Text(
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                    user.bio,
                    overflow:
                        TextOverflow.clip, // Clip the text if it's too long
                  ),
                ),
              ),
              CustomPreferences(preferences: user.preferences),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Positioned(
      bottom: 140,
      left: 0,
      right: 0,
      height: 150,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.black.withOpacity(0.7),
            Colors.black.withOpacity(0.6),
            Colors.black.withOpacity(0),
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${user.name}, ${user.age}',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.work,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          user.occupation,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(
                        Icons.favorite_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: ShapeDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: const StarBorder.polygon(pointRounding: 0.4)),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.star_rate_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
