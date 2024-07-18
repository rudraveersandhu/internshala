import 'package:http/http.dart' as http;
import '../models/internship_model.dart';


class InternshipService {
  static const String url = 'https://internshala.com/flutter_hiring/search';

  static Future<List<Internship>> fetchInternships() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return parseInternships(response.body);
    } else {
      throw Exception('Failed to load internships');
    }
  }
}
