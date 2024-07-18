import 'dart:convert';

class Internship {
  final int id;
  final String title;
  final String companyName;
  final String location;
  final String stipend;
  final String duration;

  Internship({
    required this.id,
    required this.title,
    required this.companyName,
    required this.location,
    required this.stipend,
    required this.duration,
  });

  factory Internship.fromJson(Map<String, dynamic> json) {
    return Internship(
      id: json['id'],
      title: json['title'],
      companyName: json['company_name'],
      location: json['location_names'].join(', '),
      stipend: json['stipend']['salary'],
      duration: json['duration'],
    );
  }
}

List<Internship> parseInternships(String responseBody) {
  final parsed = jsonDecode(responseBody)['internships_meta'].values.toList();
  return parsed.map<Internship>((json) => Internship.fromJson(json)).toList();
}
