import 'package:fc_fan_club/features/gallery/presentation/widgets/galleries_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GalleriesPage extends StatelessWidget {
  const GalleriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Galleries',
          style: GoogleFonts.roboto(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: const GalleriesWidget(),
    );
  }
}
