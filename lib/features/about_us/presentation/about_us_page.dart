import 'package:flutter/material.dart';
import 'package:stadium_eye/constants/app_consts.dart';
import 'package:stadium_eye/core/widgets/glowing_logo/logo_splash.dart';
import 'package:stadium_eye/l10n/app_localizations.dart';
import 'package:video_player/video_player.dart';

import '../widgets/animated_arrow.dart';
import '../widgets/bottom_back_button.dart';
import '../widgets/feature_card.dart';
import '../widgets/mission_statement.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  ScrollController? _attachedController;

  // Animation Controllers
  late AnimationController _logoAnimationController;
  late AnimationController _contentAnimationController;

  // Animations
  late Animation<double> _logoFadeAnimation;
  // late Animation<double> _contentFadeAnimation;

  late VideoPlayerController _videoController;
  late VideoPlayerController _initvideoController;

  double _logoOpacity = 1.0;
  double _videoOpacity = 0.0;

  double _featuresOpacity = 0.0;
  double _missionOpacity = 0.0;
  // double _buttonOpacity = 1.0;

  bool _isVideoInitialized = false;
  bool _isInitVideoInitialized = false;

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

    // Initialize video
    //TODO: remove this in prodaction
    _videoController =
        "assets/videos/motion4.1.mp4".isNotEmpty
              ? VideoPlayerController.asset("assets/videos/motion4.1.mp4")
              : VideoPlayerController.networkUrl(
                  Uri.parse(
                    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
                  ),
                )
          ..initialize().then((_) {
            setState(() {
              _isVideoInitialized = true;
            });
          });

    _initvideoController = VideoPlayerController.asset(AppConsts.initVideo)
      ..initialize().then((_) {
        setState(() {
          _isInitVideoInitialized = true;
          _initvideoController.play();
          _initvideoController.setLooping(true);
          _initvideoController.setVolume(0);
        });
      });
  }

  void _onScroll() {
    final offset = _attachedController!.offset;

    setState(() {
      _logoOpacity = (1 - (offset / 200)).clamp(0.0, 1.0);
      _videoOpacity = ((offset - 100) / 200).clamp(0.0, 1.0);
      _featuresOpacity = ((offset - 300) / 200).clamp(0.0, 1.0);
      _missionOpacity = ((offset - 500) / 200).clamp(0.0, 1.0);
    });
  }

  void _startAnimations() async {
    _logoAnimationController.forward();

    await Future.delayed(const Duration(milliseconds: 600));
    _contentAnimationController.forward();
  }

  @override
  void dispose() {
    _attachedController?.removeListener(_onScroll);
    _logoAnimationController.dispose();
    _contentAnimationController.dispose();
    _scrollController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Background video
            Positioned.fill(
              child: _isInitVideoInitialized
                  ? FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _initvideoController.value.size.width,
                        height: _initvideoController.value.size.height,
                        child: VideoPlayer(_initvideoController),
                      ),
                    )
                  : Container(
                      color: Colors.grey[100],
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF00D856),
                          strokeWidth: 3,
                        ),
                      ),
                    ),
            ),

            // Main scrollable content
            DraggableScrollableSheet(
              initialChildSize: 0.16,
              minChildSize: 0.16,
              maxChildSize: 1,

              builder: (context, scrollController) {
                // Attach listener only once
                if (_attachedController != scrollController) {
                  _attachedController?.removeListener(_onScroll);
                  scrollController.addListener(_onScroll);
                  _attachedController = scrollController;
                }

                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const AnimatedUpArrows(),
                        SizedBox(
                          height: 500,
                          child: Center(
                            child: AnimatedBuilder(
                              animation: _logoAnimationController,
                              builder: (context, child) {
                                return Opacity(
                                  opacity:
                                      _logoOpacity * _logoFadeAnimation.value,
                                  child: const Center(
                                    child: LogoSplash(textColor: Colors.green),
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
                                        color: Color.fromRGBO(
                                          158,
                                          158,
                                          158,
                                          0.2,
                                        ),
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
                                                borderRadius:
                                                    BorderRadius.circular(15),
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
                                                  Text(
                                                    locale.watchOurStory,
                                                    style: const TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFF00D856),
                                                    ),
                                                  ),
                                                  Text(
                                                    locale
                                                        .seeHowWeTransformStadiums,
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
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              AspectRatio(
                                                aspectRatio: 16 / 9,
                                                child: _isVideoInitialized
                                                    ? VideoPlayer(
                                                        _videoController,
                                                      )
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
                                                        child: AnimatedOpacity(
                                                          opacity:
                                                              _videoController
                                                                  .value
                                                                  .isPlaying
                                                              ? 0.0
                                                              : 1.0,
                                                          duration:
                                                              const Duration(
                                                                milliseconds:
                                                                    300,
                                                              ),
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets.all(
                                                                  10,
                                                                ),
                                                            decoration: const BoxDecoration(
                                                              color: Color(
                                                                0xFF00D856,
                                                              ),
                                                              shape: BoxShape
                                                                  .circle,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color:
                                                                      Color.fromRGBO(
                                                                        0,
                                                                        216,
                                                                        86,
                                                                        0.5,
                                                                      ),
                                                                  blurRadius:
                                                                      20,
                                                                  spreadRadius:
                                                                      5,
                                                                ),
                                                              ],
                                                            ),
                                                            child: const Icon(
                                                              Icons.play_arrow,
                                                              size: 20,
                                                              color:
                                                                  Colors.white,
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
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: FeatureCard(
                                        icon: Icons.security,
                                        title: locale.secure,
                                        subtitle: locale.topLevelSecurity,
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: FeatureCard(
                                        icon: Icons.speed,
                                        title: locale.fast,
                                        subtitle: locale.realTimeReports,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),

                              Opacity(
                                opacity: _featuresOpacity,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: FeatureCard(
                                        icon: Icons.verified_user,
                                        title: locale.reliable,
                                        subtitle: 'Always available',
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: FeatureCard(
                                        icon: Icons.analytics,
                                        title: locale.smart,
                                        subtitle: locale.aiPoweredInsights,
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
                              const BottomBackButton(),
                              const SizedBox(height: 50),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            // // Back button at top
            // Positioned(
            //   top: 16,
            //   right: 16,
            //   child: AnimatedBuilder(
            //     animation: _logoAnimationController,
            //     builder: (context, child) {
            //       return FadeTransition(
            //         opacity: _logoFadeAnimation,
            //         child: Container(
            //           decoration: const BoxDecoration(
            //             color: Colors.white,
            //             shape: BoxShape.circle,
            //             boxShadow: [
            //               BoxShadow(
            //                 color: Color.fromRGBO(158, 158, 158, 0.3),
            //                 blurRadius: 10,
            //                 offset: Offset(0, 3),
            //               ),
            //             ],
            //           ),
            //           child: IconButton(
            //             icon: const Icon(
            //               Icons.arrow_forward_ios_rounded,
            //               color: Color(0xFF00D856),
            //               size: 26,
            //             ),
            //             onPressed: () {
            //               Navigator.pop(context);
            //             },
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
