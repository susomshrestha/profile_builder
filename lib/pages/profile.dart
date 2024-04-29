import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile(
      {super.key,
      required this.fullName,
      required this.age,
      required this.bio});

  final String fullName;
  final int age;
  final String bio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prifle'),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          const Column(
            children: [
              Text('profile'),
              Image(image: AssetImage('assets/images/profile.jpg')),
            ],
          ),
          Positioned(
              bottom: 140,
              left: 0,
              right: 0,
              height: 100,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0),
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                ),
                child: Text(
                  '$fullName $age',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              )),
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
                    children: [
                      Text('$fullName is $age years old with this $bio'),
                      const Text('Things i like'),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
