import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../logic/notifier.dart';
import '../settings/app_setting.dart';
import '../widgets/card_tag.dart';
import '../widgets/custom_experience_card.dart';
import 'dart:html' as html;

import '../widgets/custom_project_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedSection = 'ABOUT';
  bool isHover = false;
  final _scrollController = ScrollController();
  Map<String, double> sectionTops = {};
  double _scrollThreshold = 50.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _calculateSectionTops());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void navigateToSection(String section) {
    if (section != 'ABOUT') {
      selectedSection = section;
    }
    final targetSectionTop = sectionTops[section] ?? 0.0; // Handle missing key
    _scrollController.animateTo(
      targetSectionTop,
      duration: Duration(milliseconds: 800),
      curve: Curves.ease,
    );
  }

  void _calculateSectionTops() {
    try {
      final aboutSectionRenderBox = context.findRenderObject() as RenderBox?;
      if (aboutSectionRenderBox != null) {
        final aboutSectionTop =
            aboutSectionRenderBox.localToGlobal(Offset.zero).dy;
        sectionTops['ABOUT'] = aboutSectionTop;

        // ... Repeat calculations for other sections

        final experienceSectionTop =
            sectionTops['ABOUT']! + (aboutSectionRenderBox.size.height);
        sectionTops['EXPERIENCE'] = experienceSectionTop;

        final projectsSectionTop = experienceSectionTop +
            (aboutSectionRenderBox.size.height) +
            // Add a small buffer (optional)
            50.0;
        sectionTops['PROJECTS'] = projectsSectionTop;

        print('Section tops: $sectionTops'); // Debugging log
      }
    } catch (error) {
      print('Error calculating section tops: $error');
    }
  }

  void _onScroll() {
    final currentSectionProvider =
        Provider.of<CurrentSection>(context, listen: false); // (optional)

    // Update selectedSection based on scroll position (optimized for PROJECTS)
    final scrollOffset = _scrollController.offset;
    String newSection = '';
    for (var section in sectionTops.keys.toList().reversed) {
      if (scrollOffset >= sectionTops[section]! - _scrollThreshold) {
        newSection = section;
        break;
      }
    }

    // Update only if there's a change and handle edge cases
    if (newSection != selectedSection) {
      selectedSection = newSection;
      currentSectionProvider.updateSection(selectedSection);
      setState(() {});
    }
    setState(() {});
    print('_scrollController.offset: ${scrollOffset}'); // Debugging log
    print(
        'sectionTops[PROJECTS]: ${sectionTops['PROJECTS'] ?? 0.0}'); // Debugging log
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F172A),
      body: Row(
        children: [
          SizedBox(
            width: 500,
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildLeftContainer(),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                alignment: Alignment.center,
                child: Wrap(
                  children: [
                    _buildRightContainer(navigateToSection),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftContainer() {
    return Container(
      width: 500,
      margin: EdgeInsets.all(20),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildHeader(),
          Gap(200),
          _buildSocialIcons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 500,
          child: Text(
            'Oussama Rhayrhay',
            style: TextStyle(
              fontFamily: AppSettings.fontF,
              color: Color(0XFFE2E8F0),
              fontSize: 48,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Gap(10),
        Text(
          'Software Engineer (Flutter Framework)',
          style: TextStyle(
            fontFamily: AppSettings.fontF,
            color: Color(0xFFE2E8F0),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        Gap(10),
        Container(
          width: 270,
          child: Text(
            'Crafting pixel-perfect, engaging, and accessible digital experiences as a Flutter Framework Software Engineer.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Gap(60),
        _buildSectionTitle('ABOUT'),
        Gap(10),
        _buildSectionTitle('EXPERIENCE'),
        Gap(10),
        _buildSectionTitle('PROJECTS'),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        selectedSection == title
            ? Container(
                color: Color(0xFFC4D0EC),
                width: 50,
                height: 1,
              )
            : Container(
                color: Color(0xFF7185AB),
                width: 30,
                height: 0.3,
              ),
        Gap(10),
        InkWell(
          // Make the title clickable for navigation
          onTap: () => navigateToSection(title),
          child: Text(
            title,
            style: TextStyle(
              color: selectedSection == title
                  ? Color(0xFFE2E8F0)
                  : Color(0xFF7185AB),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      children: [
        _buildSocialIcon(
          'assets/images/github-logo.png',
          'https://github.com/oussama3422',
        ),
        Gap(40),
        _buildSocialIcon(
          'assets/images/instagram.png',
          'https://www.instagram.com/rhayrhay_oussama_official/',
        ),
        Gap(40),
        _buildSocialIcon(
          'assets/images/linkedin.png',
          'https://www.linkedin.com/in/oussama-ghayghay-608907207/',
        ),
        Gap(40),
        _buildSocialIcon(
          'assets/images/leetcode.png',
          'https://leetcode.com/oussama_officiel/',
        ),
      ],
    );
  }

  Widget _buildSocialIcon(String imagePath, String url) {
    return InkWell(
      mouseCursor: MouseCursor.uncontrolled,
      onTap: () {
        _launchURL(url);
      },
      child: Image.asset(
        imagePath,
        height: 30,
        width: 30,
      ),
    );
  }

  void _launchURL(String url) {
    html.window.open(url, 'new tab');
  }

  Widget _buildRightContainer(onHover) {
    return Container(
      width: 600,
      child: Column(
        children: [
          _buildExperienceText(),
          Gap(140),
          _buildCustomExperienceCard(),
          _buildCustomExperienceCard(),
          Gap(140),
          textWidget(onHover, isHover),
          Gap(400),
          _buildCustomProjectCard(),
          Gap(200),
        ],
      ),
    );
  }

  Widget textWidget(onHover, iHover) => InkWell(
        onTap: () {
          html.window.open('assets/resume.pdf', 'new tab');
        },
        child: Row(
          children: [
            Text(
              'View Full Résumé',
              style: TextStyle(
                color: Color(0xFFE2E8F0),
                fontFamily: AppSettings.fontF,
                fontWeight: FontWeight.w600,
                fontSize: iHover ? 20 : 16,
              ),
            ),
            Gap(5),
            Icon(
              Icons.arrow_outward_rounded,
              color: Color(0xFFE2E8F0),
            ),
          ],
        ),
      );

  Widget _buildExperienceText() {
    return Text(
      '''As a self-taught Flutter developer, I bring one year of hands-on experience in crafting mobile applications with a focus on cross-platform development. My journey into the world of Flutter has equipped me with a diverse skill set, blending creativity with technical proficiency.Throughout my experience, I've actively contributed to the development of Flutter applications, demonstrating a keen understanding of Dart programming language and Flutter framework. I've successfully translated design concepts into efficient and user-friendly mobile interfaces, ensuring a seamless and engaging user experience.My commitment to staying current with industry trends and continuous learning has allowed me to adapt to evolving technologies. I approach challenges with a problem-solving mindset, and my dedication to delivering high-quality software reflects my passion for creating impactful and innovative solutions.I am eager to further enhance my skills and contribute to projects that leverage my expertise in Flutter development. As I continue my journey, I am enthusiastic about embracing new challenges and collaborating with dynamic teams to build cutting-edge mobile applications.''',
      style: TextStyle(
        fontFamily: AppSettings.fontF,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.2,
        color: Color(0xFF94A3B8),
      ),
    );
  }

  Widget _buildCustomExperienceCard() {
    return CustomExperienceCard(
      title: 'Flutter Developer @ NumerDiv',
      description:
          '''We specialize in mobile development. Our collaborative approach fosters creativity, ensuring that each project is a unique reflection of our client's goals and aspirations.''',
      fromData: 'JAN',
      toData: 'JULY 2023',
      children: [
        Gap(10),
        CardTag(tag: 'Flutter.'),
        Gap(10),
        CardTag(tag: 'Firebase.'),
        Gap(10),
        CardTag(tag: 'Bloc.'),
        Gap(10),
        CardTag(tag: 'Dart.'),
      ],
    );
  }

  Widget _buildCustomProjectCard() {
    return CustomProjectCard(
      title: 'Quran & Hadith App',
      description:
          '''App for showing each sora with info it's info and also allowing to listing to quran''',
      fromData: '',
      toData: '',
      children: [
        Gap(10),
        CardTag(tag: 'Flutter.'),
        Gap(10),
        CardTag(tag: 'Dart.'),
        Gap(10),
        CardTag(tag: 'Firebase.'),
        Gap(10),
        Gap(10),
        CardTag(tag: 'Bloc.'),
      ],
    );
  }
}
