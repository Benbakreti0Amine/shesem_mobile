class ReportModel {
  final int id;
  final String title;
  final String description;
  final String severity;
  final String category;
  final String latitude;
  final String longitude;
  final String phone;
  final String image;
  final String video;

  ReportModel({
    required this.id,
    required this.title,
    required this.description,
    required this.severity,
    required this.category,
    required this.latitude,
    required this.longitude,
    required this.phone,
    required this.image,
    required this.video,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      severity: json['severity'] ?? '',
      category: json['category'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      phone: json['phone'] ?? '',
      image: json['image'] ?? '',
      video: json['video'] ?? '',
    );
  }
}
