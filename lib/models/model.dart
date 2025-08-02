class Images {
  final int imageId;
  final String imageAlt;
  final String imagePortraitPath;

  Images({
    required this.imageId,
    required this.imageAlt,
    required this.imagePortraitPath,
  });

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      imageId: json['id'] as int? ?? 0,
      imageAlt: json['alt'] as String? ?? '',
      imagePortraitPath: json['src']['portrait'] as String? ?? '',
    );
  }
  Images.emptyConstructor({
    this.imageId = 0,
    this.imageAlt = '',
    this.imagePortraitPath = '',
  });
}
