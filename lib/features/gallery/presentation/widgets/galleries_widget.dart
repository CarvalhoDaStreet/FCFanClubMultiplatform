import 'package:fc_fan_club/features/gallery/domain/entities/gallery.dart';
import 'package:fc_fan_club/features/gallery/presentation/bloc/galleries_bloc.dart';
import 'package:fc_fan_club/features/gallery/presentation/bloc/galleries_state.dart';
import 'package:fc_fan_club/features/gallery/presentation/pages/full_image_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class GalleriesWidget extends StatelessWidget {
  const GalleriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleriesBloc, GalleriesState>(
      builder: (context, state) {
        if (state is GalleriesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GalleriesLoaded) {
          return _buildGalleriesList(context, state.galleries);
        } else if (state is GalleriesError) {
          return Center(child: Text(state.message));
        } else {
          return _buildPlaceholder();
        }
      },
    );
  }

  Widget _buildGalleriesList(BuildContext context, List<Gallery> galleries) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: galleries.length,
      separatorBuilder: (context, index) => const Divider(height: 40, thickness: 1),
      itemBuilder: (context, index) {
        return _buildGalleryItem(context, galleries[index]);
      },
    );
  }

  Widget _buildGalleryItem(BuildContext context, Gallery gallery) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          gallery.title,
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 300, // Adjust this value to change the overall height of the image container
          child: Center(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: gallery.photos.length > 4 ? 4 : gallery.photos.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 0 : 4,
                    right: 4,
                    top: index.isEven ? 0 : 20, // Add top padding to odd-indexed items
                    bottom: index.isEven ? 20 : 0, // Add bottom padding to even-indexed items
                  ),
                  child: _buildPhotoItem(context, gallery, index),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildPhotoItem(BuildContext context, Gallery gallery, int index) {
    return GestureDetector(
      onTap: () => _openFullGallery(context, gallery, index),
      child: SizedBox(
        width: 80, // Adjust this value to change the width of the images
        height: 260, // Adjust this value to change the height of the images
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                gallery.photos[index].url,
                fit: BoxFit.cover,
              ),
              if (index == 3 && gallery.photos.length > 4)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Text(
                      '+${gallery.photos.length - 4}',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _openFullGallery(BuildContext context, Gallery gallery, int initialIndex) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => FullGalleryPage(gallery: gallery, initialIndex: initialIndex),
    ));
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.photo_library, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No galleries available',
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Check back later for new photo galleries',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
