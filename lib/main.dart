import 'package:flutter/material.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:installed_apps/app_info.dart';

void main() => runApp(GamingHubApp());

class GamingHubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(), // Tema Gaming gelap
      home: GameListScreen(),
    );
  }
}

class GameListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GAMING HUB 2026")),
      body: FutureBuilder<List<AppInfo>>(
        future: InstalledApps.getInstalledApps(true, true), // Ambil app yang bisa dibuka
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          // Tips 2026: Filter aplikasi yang kategorinya 'Game' jika tersedia
          List<AppInfo> games = snapshot.data!; 

          return GridView.builder(
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: games.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => InstalledApps.startApp(games[index].packageName),
                child: Column(
                  children: [
                    // Menampilkan ikon aplikasi
                    Image.memory(games[index].icon!, width: 60, height: 60),
                    Text(games[index].name, overflow: TextOverflow.ellipsis),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
