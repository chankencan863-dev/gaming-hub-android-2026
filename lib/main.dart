import 'package:flutter/material.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:battery_plus/battery_plus.dart';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  static Future<void> init() async {
    // Meminta izin notifikasi (Penting untuk Android 13+)
    NotificationSettings settings = await _fcm.requestPermission();
    
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Mendapatkan token unik perangkat untuk pengiriman target
      String? token = await _fcm.getToken();
      print("Device Token: $token"); // Simpan ini di server Anda untuk kirim info diskon
    }

    // Menangani pesan saat aplikasi berjalan di foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Notifikasi Diskon: ${message.notification?.title}");
      // Tampilkan sebagai dialog atau snackbar di dalam Hub
    });
  }
}


void main() => runApp(GamingHubPro());

class GamingHubPro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.deepPurpleAccent,
        scaffoldBackgroundColor: Color(0xFF0F0F1E), // Warna futuristik
      ),
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _batteryLevel = 0;
  final Battery _battery = Battery();

  @override
  void initState() {
    super.initState();
    _getBatteryStatus();
  }

  void _getBatteryStatus() async {
    final level = await _battery.batteryLevel;
    setState(() => _batteryLevel = level);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildPerformanceBar(),
            Expanded(child: _buildGameGrid()),
          ],
        ),
      ),
    );
  }

  // Header dengan profil dan info status
  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Halo, Gamer!", style: TextStyle(color: Colors.grey)),
              Text("DASHBOARD PRO", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2)),
            ],
          ),
          CircleAvatar(backgroundColor: Colors.deepPurpleAccent, child: Icon(Icons.person, color: Colors.white)),
        ],
      ),
    );
  }

  // Bar performa (Baterai, RAM, Suhu - Simulasi)
  Widget _buildPerformanceBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xFF1E1E30),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statusItem(Icons.battery_charging_full, "$_batteryLevel%", "Battery"),
          _statusItem(Icons.speed, "45 FPS", "Avg. Performance"),
          _statusItem(Icons.thermostat, "38°C", "Temp"),
        ],
      ),
    );
  }

  Widget _statusItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.cyanAccent, size: 20),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }

  // Grid Game dengan Animasi
  Widget _buildGameGrid() {
    return FutureBuilder(
      future: InstalledApps.getInstalledApps(true, true),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

        return GridView.builder(
          padding: EdgeInsets.all(20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 0.8,
          ),
          itemCount: snapshot.data.length > 6 ? 6 : snapshot.data.length, // Limit contoh
          itemBuilder: (context, index) {
            var app = snapshot.data[index];
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xFF2A2A45), Color(0xFF1E1E30)]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.memory(app.icon, width: 70),
                  ),
                  SizedBox(height: 10),
                  Text(app.name, style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.cyanAccent, foregroundColor: Colors.black),
                    onPressed: () => InstalledApps.startApp(app.packageName),
                    child: Text("LAUNCH"),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
