import 'package:fc_fan_club/config/constants/config.dart';
import 'package:flutter/material.dart';
import 'package:fc_fan_club/features/news/domain/entities/news.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsItemWidget extends StatelessWidget {
  final News news;
  const NewsItemWidget({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showNewsDetailModal(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    style: GoogleFonts.roboto(fontSize: 16.0, fontWeight: FontWeight.w800),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    DateFormat('dd MMM yyyy • HH:mm').format(DateTime.parse(news.publishingDate)),
                    style: GoogleFonts.roboto(fontSize: 12.0, fontWeight: FontWeight.w400, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                "${AppConfig.strapiBaseUrl}${news.thumbUrl}",
                width: 150,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNewsDetailModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow the modal to take up more space
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.85, // Set the height to 80% of the screen height
            decoration: const BoxDecoration(
              color: Colors.white, // Specify the background color for the container
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0), // Top left corner radius
                topRight: Radius.circular(10.0), // Top right corner radius
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start, // Aligns content to the start
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black, // Set background color to black
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  width: double.infinity, // Make the container span full width
                  child: Row(
                    children: [
                      IconButton(
                        padding: const EdgeInsets.all(15.0),
                        constraints: const BoxConstraints(),
                        icon: const Icon(Icons.close_sharp, color: Colors.white, size: 35), // Set icon color to white
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: SingleChildScrollView(
                      // Add SingleChildScrollView here
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Aligns content to the start
                        children: <Widget>[
                          // Your modal content here
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(news.title, style: GoogleFonts.roboto(fontSize: 24.0, fontWeight: FontWeight.w800)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(news.description, style: GoogleFonts.roboto(fontSize: 15.0, fontWeight: FontWeight.w400, color: Colors.grey[400])),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                "${AppConfig.strapiBaseUrl}${news.thumbUrl}", // Use the strapiBaseUrl constant
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Written by ${news.authorCredits}',
                              style: GoogleFonts.roboto(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black),
                            ),
                          ),
                          Center(
                            child: Text(
                              DateFormat('dd MMM yyyy • HH:mm').format(DateTime.parse(news.publishingDate)),
                              style: GoogleFonts.roboto(fontSize: 12.0, fontWeight: FontWeight.w300, color: Colors.grey[600]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Divider(thickness: 0.3, color: Colors.grey[700]),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: MarkdownBody(
                              data: news.newsBody,
                              softLineBreak: true,
                              onTapLink: (String text, String? href, String title) async {
                                if (href != null) {
                                  final Uri url = Uri.parse(href);
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url);
                                  } else {
                                    throw 'Could not launch $href';
                                  }
                                }
                              },
                              imageBuilder: (Uri uri, String? title, String? alt) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0), // Set the corner radius here
                                  child: Image.network(uri.toString()),
                                );
                              },
                              styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                                p: GoogleFonts.roboto(fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.black),
                                blockquote: GoogleFonts.roboto(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey[100],
                                ),
                                blockquotePadding: const EdgeInsets.all(8.0),
                                blockquoteDecoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      color: Colors.grey[300]!,
                                      width: 3.0,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(3.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
