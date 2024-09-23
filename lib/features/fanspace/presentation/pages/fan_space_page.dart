import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fc_fan_club/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fc_fan_club/features/auth/presentation/pages/auth_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FanSpacePage extends StatelessWidget {
  const FanSpacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return _buildAuthenticatedContent(context, state);
        } else {
          return const AuthPage();
        }
      },
    );
  }

  Widget _buildAuthenticatedContent(BuildContext context, Authenticated state) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fan Space',
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              context.read<AuthBloc>().add(SignOutRequested());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, ${state.user.name ?? 'Fan'}!',
                style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildFanSpaceSection(
                title: 'My Profile',
                icon: FontAwesomeIcons.userCircle,
                onTap: () {
                  // Navigate to profile page
                },
              ),
              _buildFanSpaceSection(
                title: 'My Tickets',
                icon: FontAwesomeIcons.ticket,
                onTap: () {
                  // Navigate to tickets page
                },
              ),
              _buildFanSpaceSection(
                title: 'Fan Forum',
                icon: FontAwesomeIcons.comments,
                onTap: () {
                  // Navigate to fan forum page
                },
              ),
              _buildFanSpaceSection(
                title: 'Match Predictions',
                icon: FontAwesomeIcons.chartLine,
                onTap: () {
                  // Navigate to match predictions page
                },
              ),
              _buildFanSpaceSection(
                title: 'Fan Rewards',
                icon: FontAwesomeIcons.gift,
                onTap: () {
                  // Navigate to fan rewards page
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFanSpaceSection({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: FaIcon(icon, color: Colors.blue),
          title: Text(
            title,
            style: GoogleFonts.roboto(fontWeight: FontWeight.w500),
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
      ),
    );
  }
}
