import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stadium_eye/core/widgets/loading/lottie_loading.dart';
import 'package:stadium_eye/features/auth/presentation/bloc/auth_bloc.dart';

import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00c951), Color(0xFF00bd7e)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.remove_red_eye,
                          color: Color(0xFF02c952),
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        state is! HomeLoaded
                            ? 'unknown'
                            : "Welcome back,\n${state.homeData.user.fullName}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          height: 1.3,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () =>
                        context.read<AuthBloc>().add(const LogoutEvent()),
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: state is AuthLoading
                              ? const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: SizedBox(
                                    height: 28,
                                    width: 28,
                                    child: LottieLoader(),
                                  ),
                                )
                              : const Icon(
                                  Iconsax.logout_1_copy,
                                  color: Colors.white,
                                  size: 32,
                                ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: StatCard(
                      title: "Reports",
                      value: state is! HomeLoaded
                          ? '-1'
                          : "${state.homeData.totalTickets}",
                      icon: Iconsax.document_copy,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: StatCard(
                      title: "Active",
                      value: state is! HomeLoaded
                          ? '-1'
                          : "${state.homeData.totalActiveUsers}",
                      icon: Iconsax.activity_copy,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: StatCard(
                      title: "Teams",
                      value: state is! HomeLoaded
                          ? '-1'
                          : "${state.homeData.totalTeams}",
                      icon: Iconsax.people_copy,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class StatCard extends StatefulWidget {
  final String title;
  final String value;
  final IconData icon;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<double> _scale;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 450),
      vsync: this,
    );

    _fade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _scale = Tween<double>(
      begin: 0.9,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _controller.forward();
    });
  }

  void _onTapDown(TapDownDetails d) => _controller.reverse();
  void _onTapUp(TapUpDetails d) => _controller.forward();

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: ScaleTransition(
          scale: _scale,
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            child: Container(
              // width: 130,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Icon(widget.icon, color: Colors.white, size: 26),
                  const SizedBox(height: 8),
                  Text(
                    widget.title,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  Text(
                    widget.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
