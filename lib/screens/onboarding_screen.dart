import 'package:flutter/material.dart';
import 'package:kelas_baca/models/appPages.dart';
import 'package:kelas_baca/models/models.dart';
import 'package:kelas_baca/screens/student_screens/student_screens.dart';
import 'package:provider/provider.dart';
import '../theme.dart';
import './login_screen.dart';
import 'student_screens/_student_login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: AppPages.onboardingPath,
      key: ValueKey(AppPages.onboardingPath),
      child: const OnboardingScreen(),
    );
  }

  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text('Kelas Baca'),
        leading: GestureDetector(
          child: const Icon(
            Icons.chevron_left,
            size: 35,
          ),
          onTap: () {
            Navigator.pop(context, true);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: buildPages()),
            buildIndicator(),
            buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MaterialButton(
          child: const Text('Lanjut'),
          onPressed: () {
            Provider.of<AppStateManager>(context, listen: false)
                .completeOnboarding();
          },
        ),
      ],
    );
  }

  Widget buildPages() {
    return PageView(
      controller: controller,
      children: [
        onboardPageView(
          const AssetImage('assets/images/recommend.png'),
          '''Check out weekly recommended recipes and what your friends are cooking!''',
        ),
        onboardPageView(const AssetImage('assets/images/sheet.png'),
            'Cook with step by step instructions!'),
      ],
    );
  }

  Widget onboardPageView(ImageProvider imageProvider, String text) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image(
              fit: BoxFit.fitWidth,
              image: imageProvider,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            text,
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget buildIndicator() {
    return SmoothPageIndicator(
      controller: controller,
      count: 2,
      effect: WormEffect(activeDotColor: const Color.fromRGBO(64, 143, 77, 1)),
    );
  }
}
