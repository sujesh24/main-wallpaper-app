import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:main_wallpaper_app/repo/repository.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key, required this.imageUrl, required this.imageId});
  final String imageUrl;
  final int imageId;

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  @override
  Widget build(BuildContext context) {
    Repository repo = Repository();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text('Image Preview', style: TextStyle(fontFamily: 'Poppins')),
        centerTitle: true,
      ),
      body: CachedNetworkImage(
        imageUrl: widget.imageUrl,
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) {
          return Icon(Icons.error, color: Colors.red);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          repo.downloadImage(
            imageUrl: widget.imageUrl,
            imageId: widget.imageId,
            context: context,
          );
        },
        backgroundColor: Colors.blue.withAlpha(350),
        foregroundColor: Colors.white,
        tooltip: 'Download Image',
        shape: CircleBorder(),

        child: Icon(Icons.download),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
