import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profile_builder/pages/profile.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Padding(
        padding: EdgeInsets.all(40),
        child: OnboardingPage(),
      ),
    );
  }
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late PageController _pageViewController;
  int _currentPageIndex = 0;

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _bioController = TextEditingController();

  final List<PreferenceItem> _preferences = [
    PreferenceItem('Soccer', Icons.sports_soccer),
    PreferenceItem('Movies', Icons.movie),
    PreferenceItem('Books', Icons.book),
    PreferenceItem('Music', Icons.music_note),
    PreferenceItem('Travel', Icons.airplanemode_active),
    PreferenceItem('Food', Icons.restaurant),
    PreferenceItem('Fitness', Icons.fitness_center),
    PreferenceItem('Photography', Icons.camera_alt),
    PreferenceItem('Fashion', Icons.accessibility_new),
    PreferenceItem('Technology', Icons.devices),
    PreferenceItem('Art', Icons.palette),
    PreferenceItem('Nature', Icons.eco),
    PreferenceItem('Cars', Icons.directions_car),
    PreferenceItem('Gaming', Icons.videogame_asset),
    PreferenceItem('Cooking', Icons.local_dining),
    PreferenceItem('Pets', Icons.pets),
    PreferenceItem('DIY', Icons.build),
    PreferenceItem('Meditation', Icons.self_improvement),
    PreferenceItem('Dancing', Icons.music_video),
    PreferenceItem('Yoga', Icons.spa),
  ];

  List<PreferenceItem> _selectedPreferences = [];

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: _pageViewController,
          onPageChanged: _handlePageViewChanged,
          children: [
            const Column(
              children: [
                // initial welcome page
                SizedBox(
                  height: 300,
                  child: Icon(
                    Icons.person_3_outlined,
                    size: 150,
                  ),
                ),
                // name page
                Text('Continue',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
                Text('To',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
                Text(
                  'Build Your Profile',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('What is you First Name?',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('What is your Age?',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Add your Bio.',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _bioController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Preferences',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
                const SizedBox(
                  height: 20,
                ),
                Wrap(
                  spacing: 8.0, // spacing between widgets
                  runSpacing: 8.0, // spacing between lines
                  children: _preferences
                      .map((e) => GestureDetector(
                            onTap: () => _togglePreference(e),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(20.0),
                                color: _selectedPreferences.contains(e)
                                    ? Colors.blue
                                    : null,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(e.iconData, size: 20,),
                                  const SizedBox(width: 8.0),
                                  Text(e.name, style: TextStyle(fontSize: 14),),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ],
            )
          ],
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            onPressed: () {
              switch (_currentPageIndex) {
                case 1:
                  if (_nameController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Name is Required'),
                    ));
                    return;
                  }
                  break;
                case 2:
                  if (_ageController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Age is Required'),
                    ));
                    return;
                  }
                  break;
                case 3:
                  if (_bioController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Bio is Required'),
                    ));
                    return;
                  }
                  break;
              }
              if (_currentPageIndex == 4) {
                String bio = _bioController.text;
                String name = _nameController.text;
                int age = int.parse(_ageController.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Profile(fullName: name, age: age, bio: bio)),
                );
              }
              _updateCurrentPageIndex(_currentPageIndex + 1);
            },
            shape: const CircleBorder(),
            child: const Icon(
              Icons.chevron_right,
              size: 40,
            ),
          ),
        )
      ],
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _togglePreference(PreferenceItem item) {
    if (_selectedPreferences.length < 3) {
      setState(() {
        if (_selectedPreferences.contains(item)) {
          _selectedPreferences.remove(item);
        } else {
          _selectedPreferences.add(item);
        }
      });
    }
  }
}

class PreferenceItem {
  final String name;
  final IconData iconData;

  PreferenceItem(this.name, this.iconData);
}
