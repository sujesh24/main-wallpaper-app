import 'dart:convert';
import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:main_wallpaper_app/api/pexel_api.dart';
import 'package:main_wallpaper_app/models/model.dart';
import 'package:http/http.dart' as http;
import 'package:media_scanner/media_scanner.dart';

class Repository {
  final String apiKey = PexelAPi.pexelAPiKey;
  final String baseUrl = PexelAPi.baseUrl;
  // get curated images
  Future<List<Images>> getImagesList({int? pagenumber}) async {
    String url = '';

    if (pagenumber == null) {
      url = '${baseUrl}curated?per_page=80';
    } else {
      url = '${baseUrl}curated?page=$pagenumber&per_page=80';
    }
    List<Images> imagesList = [];
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': apiKey},
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final jsonData = jsonDecode(response.body);
        for (final json in jsonData['photos'] as Iterable) {
          final image = Images.fromJson(json);
          imagesList.add(image);
        }
      }
    } catch (_) {}
    return imagesList;
  }

  // image id
  Future<Images> getImageById({required int id}) async {
    final url = '${baseUrl}photos/$id';
    Images image = Images.emptyConstructor();
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': apiKey},
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final jsonData = jsonDecode(response.body);
        image = Images.fromJson(jsonData);
      }
    } catch (_) {}
    return image;
  }

  //search
  Future<List<Images>> searchImages({
    required String query,
    int? pagenumber,
  }) async {
    final url =
        '${baseUrl}search?query=$query&per_page=80${pagenumber != null ? '&page=$pagenumber' : ''}';
    List<Images> imagesList = [];
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': apiKey},
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final jsonData = jsonDecode(response.body);
        for (final json in jsonData['photos'] as Iterable) {
          final image = Images.fromJson(json);
          imagesList.add(image);
        }
      }
    } catch (_) {}
    return imagesList;
  }

  //download images
  Future<void> downloadImage({
    required String imageUrl,
    required int imageId,
    required BuildContext context,
  }) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final bytes = response.bodyBytes;
        final directory = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOAD,
        );
        final file = File("$directory/$imageId.jpg");
        await file.writeAsBytes(bytes);
        MediaScanner.loadMedia(path: file.path);

        if (context.mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green,
              content: Text(" File's been saved at ${file.path}"),
            ),
          );
        }
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download image with ID: $imageId')),
      );
    }
  }
}
