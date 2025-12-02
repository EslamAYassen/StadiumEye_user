import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _logoAnimationController;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _logoScaleAnimation;
  late VideoPlayerController _videoController;

  double _logoOpacity = 1.0;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();

    // Logo animation setup
    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoAnimationController, curve: Curves.easeIn),
    );

    _logoScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    _logoAnimationController.forward();

    // Scroll listener for fade out effect
    _scrollController.addListener(() {
      setState(() {
        double offset = _scrollController.offset;
        _logoOpacity = (1 - (offset / 200)).clamp(0.0, 1.0);
      });
    });

    // Initialize video player
    // Replace with your video URL or asset
    _videoController =
        VideoPlayerController.networkUrl(
            Uri.parse(
              'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
            ),
          )
          ..initialize().then((_) {
            setState(() {
              _isVideoInitialized = true;
            });
          });
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _scrollController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF00D856), Color(0xFF00B347)],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Scrollable content
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    // Logo section with animation
                    SizedBox(
                      height: 300,
                      child: Center(
                        child: Opacity(
                          opacity: _logoOpacity,
                          child: FadeTransition(
                            opacity: _logoFadeAnimation,
                            child: ScaleTransition(
                              scale: _logoScaleAnimation,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 20,
                                          offset: const Offset(0, 10),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.stadium,
                                      size: 60,
                                      color: Color(0xFF00D856),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    'Stadium Reports',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Content section
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 20),

                            // About Us Title
                            const Text(
                              'About Us',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00D856),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),

                            // Description
                            const Text(
                              'We provide comprehensive stadium reporting solutions to ensure the best experience for fans and efficient management for venues.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 40),

                            // Video Section
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    const Row(
                                      children: [
                                        Icon(
                                          Icons.video_library,
                                          color: Color(0xFF00D856),
                                          size: 28,
                                        ),
                                        SizedBox(width: 12),
                                        Text(
                                          'Watch Our Story',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),

                                    // Video Player
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: AspectRatio(
                                        aspectRatio: 16 / 9,
                                        child: _isVideoInitialized
                                            ? Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  VideoPlayer(_videoController),
                                                  // Play/Pause button overlay
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (_videoController
                                                            .value
                                                            .isPlaying) {
                                                          _videoController
                                                              .pause();
                                                        } else {
                                                          _videoController
                                                              .play();
                                                        }
                                                      });
                                                    },
                                                    child: Container(
                                                      color: Colors.transparent,
                                                      child: Center(
                                                        child: Icon(
                                                          _videoController
                                                                  .value
                                                                  .isPlaying
                                                              ? Icons
                                                                    .pause_circle_outline
                                                              : Icons
                                                                    .play_circle_outline,
                                                          size: 60,
                                                          color: Colors.white
                                                              .withOpacity(0.8),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Container(
                                                color: Colors.black12,
                                                child: const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                        color: Color(
                                                          0xFF00D856,
                                                        ),
                                                      ),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),

                            // Mission Statement
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: const Color(0xFF00D856).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Column(
                                children: [
                                  Icon(
                                    Icons.emoji_events,
                                    color: Color(0xFF00D856),
                                    size: 40,
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    'Our Mission',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF00D856),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'To revolutionize stadium management through innovative reporting and real-time insights.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      height: 1.4,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 60),

                            // Back to Sign In Button
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00D856),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 3,
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.arrow_back),
                                  SizedBox(width: 8),
                                  Text(
                                    'Back to Sign In',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Back button at top
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
