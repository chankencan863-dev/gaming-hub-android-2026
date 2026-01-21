import 'dart:convert';
import 'package:http/http.dart' as http;

class GameService {
  static const String apiKey = "YOUR_API_KEY_HERE"; // Ganti dengan API Key Anda

  static Future<List<dynamic>> getTrendingGames() async {
    final response = await http.get(Uri.parse(
        "https://api.rawg.io"));
    
    if (response.statusCode == 200) {
      return json.decode(response.body)['results'];
    } else {
      throw Exception("Gagal memuat berita game");
    }
  }
}
