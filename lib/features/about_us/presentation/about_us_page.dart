import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../widgets/feature_card.dart';
import '../widgets/mission_statement.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  // Animation Controllers
  late AnimationController _logoAnimationController;
  late AnimationController _contentAnimationController;

  // Animations
  late Animation<double> _logoFadeAnimation;
  // late Animation<double> _contentFadeAnimation;

  late VideoPlayerController _videoController;

  double _logoOpacity = 1.0;
  double _videoOpacity = 0.0;

  double _featuresOpacity = 0.0;
  double _missionOpacity = 0.0;
  // double _buttonOpacity = 1.0;

  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();

    // Logo animation
    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoAnimationController, curve: Curves.easeIn),
    );

    // Content animation
    _contentAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // _contentFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
    //   CurvedAnimation(
    //     parent: _contentAnimationController,
    //     curve: Curves.easeIn,
    //   ),
    // );

    // Start animations in sequence
    _startAnimations();

    // Scroll listener for fade effects
    _scrollController.addListener(() {
      setState(() {
        double offset = _scrollController.offset;

        // Logo fades out as you scroll
        _logoOpacity = (1 - (offset / 200)).clamp(0.0, 1.0);

        // Video fades in when you scroll down
        _videoOpacity = ((offset - 100) / 200).clamp(0.0, 1.0);

        // Features fade in
        _featuresOpacity = ((offset - 300) / 200).clamp(0.0, 1.0);

        // Mission fades in
        _missionOpacity = ((offset - 500) / 200).clamp(0.0, 1.0);

        // Button fades in
        // _buttonOpacity = ((offset - 700) / 200).clamp(0.0, 1.0);
      });
    });

    // Initialize video
    _videoController =
        VideoPlayerController.networkUrl(
            Uri.parse(
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
            ),
          )
          ..initialize().then((_) {
            setState(() {
              _isVideoInitialized = true;
            });
          });
  }

  void _startAnimations() async {
    _logoAnimationController.forward();

    await Future.delayed(const Duration(milliseconds: 600));
    _contentAnimationController.forward();
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _contentAnimationController.dispose();
    _scrollController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Main scrollable content
            SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // Logo Section with fade out on scroll
                  SizedBox(
                    height: 600,
                    child: Center(
                      child: AnimatedBuilder(
                        animation: _logoAnimationController,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _logoOpacity * _logoFadeAnimation.value,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 140,
                                    height: 140,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF00D856),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(
                                            0,
                                            216,
                                            86,
                                            0.3,
                                          ),
                                          blurRadius: 30,
                                          spreadRadius: 5,
                                          offset: Offset(0, 10),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.stadium,
                                      size: 70,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  const Text(
                                    'Stadium Reports',
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF00D856),
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Excellence in Stadium Management',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Content Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20),

                        // Video Section - Fades in on scroll
                        Opacity(
                          opacity: _videoOpacity,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                const BoxShadow(
                                  color: Color.fromRGBO(158, 158, 158, 0.2),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF00D856),
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.play_circle_filled,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Watch Our Story',
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF00D856),
                                              ),
                                            ),
                                            Text(
                                              'See how we transform stadiums',
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),

                                  // Video Player
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 16 / 9,
                                          child: _isVideoInitialized
                                              ? VideoPlayer(_videoController)
                                              : Container(
                                                  color: Colors.grey[100],
                                                  child: const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                          color: Color(
                                                            0xFF00D856,
                                                          ),
                                                          strokeWidth: 3,
                                                        ),
                                                  ),
                                                ),
                                        ),

                                        // Play button overlay - tappable entire video area
                                        if (_isVideoInitialized)
                                          Positioned.fill(
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (_videoController
                                                      .value
                                                      .isPlaying) {
                                                    _videoController.pause();
                                                  } else {
                                                    _videoController.play();
                                                  }
                                                });
                                              },
                                              child: Container(
                                                color: Colors.transparent,
                                                child: Center(
                                                  child: AnimatedOpacity(
                                                    opacity:
                                                        _videoController
                                                            .value
                                                            .isPlaying
                                                        ? 0.0
                                                        : 1.0,
                                                    duration: const Duration(
                                                      milliseconds: 300,
                                                    ),
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            10,
                                                          ),
                                                      decoration:
                                                          const BoxDecoration(
                                                            color: Color(
                                                              0xFF00D856,
                                                            ),
                                                            shape:
                                                                BoxShape.circle,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color:
                                                                    Color.fromRGBO(
                                                                      0,
                                                                      216,
                                                                      86,
                                                                      0.5,
                                                                    ),
                                                                blurRadius: 20,
                                                                spreadRadius: 5,
                                                              ),
                                                            ],
                                                          ),
                                                      child: const Icon(
                                                        Icons.play_arrow,
                                                        size: 20,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Features Grid - Fades in on scroll
                        Opacity(
                          opacity: _featuresOpacity,
                          child: const Row(
                            children: [
                              Expanded(
                                child: FeatureCard(
                                  icon: Icons.security,
                                  title: 'Secure',
                                  subtitle: 'Top-level security',
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: FeatureCard(
                                  icon: Icons.speed,
                                  title: 'Fast',
                                  subtitle: 'Real-time reports',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),

                        Opacity(
                          opacity: _featuresOpacity,
                          child: const Row(
                            children: [
                              Expanded(
                                child: FeatureCard(
                                  icon: Icons.verified_user,
                                  title: 'Reliable',
                                  subtitle: 'Always available',
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: FeatureCard(
                                  icon: Icons.analytics,
                                  title: 'Smart',
                                  subtitle: 'AI-powered insights',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Mission Statement - Fades in on scroll
                        MissionStatement(missionOpacity: _missionOpacity),
                        const SizedBox(height: 50),

                        // Back Button - Fades in on scroll
                        const BackButton(),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Back button at top
            Positioned(
              top: 16,
              left: 16,
              child: AnimatedBuilder(
                animation: _logoAnimationController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _logoFadeAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(158, 158, 158, 0.3),
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color(0xFF00D856),
                          size: 26,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
