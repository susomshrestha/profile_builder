import 'package:flutter/material.dart';
import 'package:profile_builder/models/preference_item.dart';
import 'package:profile_builder/models/user.dart';
import 'package:profile_builder/widgets/custom_preference.dart';

class Profile extends StatelessWidget {
  const Profile({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          const Column(
            children: [
              Image(image: AssetImage('assets/images/profile.jpg')),
            ],
          ),
          Positioned(
            bottom: 150,
            left: 0,
            right: 0,
            height: 140,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.black.withOpacity(0.2),
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
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.work,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Chef',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: Colors.orange,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
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
                        decoration: const ShapeDecoration(
                            color: Colors.orange,
                            shape: StarBorder.polygon(pointRounding: 0.4)),
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
          ),
          Positioned(
            height: 150,
            bottom: 0,
            left: 0,
            right: 0,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 60, // Set a fixed height for the bio
                      child: SingleChildScrollView(
                        child: Text(
                          user.bio,
                          overflow: TextOverflow
                              .clip, // Clip the text if it's too long
                        ),
                      ),
                    ),
                    CustomPreferences(preferences: user.preferences),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
