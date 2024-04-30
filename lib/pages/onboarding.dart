import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profile_builder/models/preference_item.dart';
import 'package:profile_builder/models/user.dart';
import 'package:profile_builder/pages/profile.dart';
import 'package:profile_builder/widgets/custom_preference.dart';

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
    PreferenceItem('Photo', Icons.camera_alt),
    PreferenceItem('Fashion', Icons.accessibility_new),
    PreferenceItem('Tech', Icons.devices),
    PreferenceItem('Art', Icons.palette),
    PreferenceItem('Nature', Icons.eco),
    PreferenceItem('Cars', Icons.directions_car),
    PreferenceItem('Gaming', Icons.videogame_asset),
    PreferenceItem('Cooking', Icons.local_dining),
    PreferenceItem('Pets', Icons.pets),
    PreferenceItem('DIY', Icons.build),
    PreferenceItem('Dancing', Icons.directions_walk),
    PreferenceItem('Yoga', Icons.spa),
  ];

  final List<PreferenceItem> _selectedPreferences = [];

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
                CustomPreferences(
                  preferences: _preferences,
                  selectedPreferences: _selectedPreferences,
                  togglePreference: _togglePreference,
                  includeGestureDetector: true,
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
              _handleNextButtonPress();
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

  void _handleNextButtonPress() {
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
      User user = User(_nameController.text, int.parse(_ageController.text),
          _bioController.text, 'occupation', _selectedPreferences);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Profile(
                user: user)),
      );
    }
    _updateCurrentPageIndex(_currentPageIndex + 1);
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
    setState(() {
      if (_selectedPreferences.contains(item)) {
        _selectedPreferences.remove(item);
      } else if (_selectedPreferences.length < 3) {
        _selectedPreferences.add(item);
      }
    });
  }
}
