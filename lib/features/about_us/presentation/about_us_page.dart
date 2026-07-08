import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stadium_eye/constants/app_consts.dart';
import 'package:stadium_eye/core/widgets/glowing_logo/logo_splash.dart';
import 'package:stadium_eye/l10n/app_localizations.dart';
import 'package:stadium_eye/theme/app_colors.dart';
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

  // // Animation Controllers
  // late AnimationController _logoAnimationController;
  // late AnimationController _contentAnimationController;

  // // Animations
  // late Animation<double> _logoFadeAnimation;
  // late Animation<double> _contentFadeAnimation;

  late VideoPlayerController _videoController;
  late VideoPlayerController _initvideoController;

  // double _logoOpacity = 1.0;
  // double _videoOpacity = 0.0;

  // double _featuresOpacity = 0.0;
  // double _missionOpacity = 0.0;
  // double _buttonOpacity = 1.0;

  bool _isVideoInitialized = false;
  bool _isInitVideoInitialized = false;

  @override
  void initState() {
    super.initState();

    // // Logo animation
    // _logoAnimationController = AnimationController(
    //   duration: const Duration(milliseconds: 1200),
    //   vsync: this,
    // );

    // _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
    //   CurvedAnimation(parent: _logoAnimationController, curve: Curves.easeIn),
    // );

    // // Content animation
    // _contentAnimationController = AnimationController(
    //   duration: const Duration(milliseconds: 1000),
    //   vsync: this,
    // );

    // _contentFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
    //   CurvedAnimation(
    //     parent: _contentAnimationController,
    //     curve: Curves.easeIn,
    //   ),
    // );

    // Start animations in sequence
    // _startAnimations();

    // Initialize video
    //TODO: change this
    _videoController =
        VideoPlayerController.networkUrl(
            Uri.parse(
              'http://91.108.112.27:3030/uploads/motion/stadiumEye.mp4',
            ),
          )
          ..initialize()
              .then((_) {
                setState(() {
                  _isVideoInitialized = true;
                });
              })
              .onError((error, stackTrace) {
                debugPrint(
                  'Error initializing video:=============================================================================================== $error',
                );
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
    // final offset = _attachedController!.offset;

    setState(() {
      // _logoOpacity = (1 - (offset / 200)).clamp(0.0, 1.0);
      // _videoOpacity = ((offset - 100) / 200).clamp(0.0, 1.0);
      // _featuresOpacity = ((offset - 300) / 200).clamp(0.0, 1.0);
      // _missionOpacity = ((offset - 500) / 200).clamp(0.0, 1.0);
    });
  }

  // void _startAnimations() async {
  //   _logoAnimationController.forward();

  //   await Future.delayed(const Duration(milliseconds: 600));
  //   _contentAnimationController.forward();
  // }

  @override
  void dispose() {
    _attachedController?.removeListener(_onScroll);
    // _logoAnimationController.dispose();
    // _contentAnimationController.dispose();
    _scrollController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode
          ? AppColors.backgroundDark
          : AppColors.whiteColor,
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
                      color: isDarkMode
                          ? AppColors.backgroundDark
                          : Colors.grey[100],
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
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
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? AppColors.surfaceDark
                        : AppColors.whiteColor,
                    borderRadius: const BorderRadius.only(
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
                        // SizedBox(
                        //   height: 500,
                        //   child: Center(
                        //     child: AnimatedBuilder(
                        //       animation: _logoAnimationController,
                        //       builder: (context, child) {
                        //         return Opacity(
                        //           opacity:
                        //               _logoOpacity * _logoFadeAnimation.value,
                        //           child: Center(
                        //             child: LogoSplash(
                        //               textColor: isDarkMode
                        //                   ? AppColors.primaryLight
                        //                   : AppColors.primary,
                        //             ),
                        //           ),
                        //         );
                        //       },
                        //     ),
                        //   ),
                        // ),

                        // Content Section
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 20),

                              // Video Section - Fades in on scroll
                              Container(
                                decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? AppColors.cardDark
                                      : AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color: isDarkMode
                                          ? AppColors.shadowDark
                                          : const Color.fromRGBO(
                                              158,
                                              158,
                                              158,
                                              0.2,
                                            ),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
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
                                              color: isDarkMode
                                                  ? AppColors.primaryDark
                                                  : AppColors.primary,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: const Icon(
                                              Iconsax.play_circle_copy,
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
                                                  style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                    color: isDarkMode
                                                        ? AppColors.primaryLight
                                                        : AppColors.primary,
                                                  ),
                                                ),
                                                Text(
                                                  locale
                                                      .seeHowWeTransformStadiums,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: isDarkMode
                                                        ? AppColors
                                                              .textSecondaryDark
                                                        : Colors.grey[600],
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
                                                  ? VideoPlayer(
                                                      _videoController,
                                                    )
                                                  : Container(
                                                      color: isDarkMode
                                                          ? AppColors
                                                                .cardElevatedDark
                                                          : Colors.grey[100],
                                                      child: const Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                              color: AppColors
                                                                  .primary,
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
                                                        duration:
                                                            const Duration(
                                                              milliseconds: 300,
                                                            ),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                10,
                                                              ),
                                                          decoration: BoxDecoration(
                                                            color: isDarkMode
                                                                ? AppColors
                                                                      .primaryDark
                                                                : AppColors
                                                                      .primary,
                                                            shape:
                                                                BoxShape.circle,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: AppColors
                                                                    .primary
                                                                    .withAlpha(
                                                                      128,
                                                                    ),
                                                                blurRadius: 20,
                                                                spreadRadius: 5,
                                                              ),
                                                            ],
                                                          ),
                                                          child: const Icon(
                                                            Iconsax.play_copy,
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
                              const SizedBox(height: 40),

                              // Features Grid - Fades in on scroll
                              Row(
                                children: [
                                  Expanded(
                                    child: FeatureCard(
                                      icon: Iconsax.security_copy,
                                      title: locale.secure,
                                      subtitle: locale.topLevelSecurity,
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: FeatureCard(
                                      icon: Iconsax.speedometer_copy,
                                      title: locale.fast,
                                      subtitle: locale.realTimeReports,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),

                              Row(
                                children: [
                                  Expanded(
                                    child: FeatureCard(
                                      icon: Iconsax.verify_copy,
                                      title: locale.reliable,
                                      subtitle: locale.alwaysAvailable,
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: FeatureCard(
                                      icon: Iconsax.chart_1_copy,
                                      title: locale.smart,
                                      subtitle: locale.aiPoweredInsights,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 40),

                              // Mission Statement - Fades in on scroll
                              const MissionStatement(
                                missionOpacity: 1,
                              ), //_missionOpacity),
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
          ],
        ),
      ),
    );
  }
}
