import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> openWA() async {
    final uri = Uri.parse("https://wa.me/6281225279432");
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Tidak dapat membuka WhatsApp";
    }
  }

  Future<void> openEmail() async {
    final uri = Uri.parse("mailto: mochamadzidanfaizal15@gmail.com");
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Tidak dapat membuka Email";
    }

  }  Future<void> openGit() async {
    final uri = Uri.parse("https://github.com/ZidanFaizal15");
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Tidak dapat membuka GitHub";
    }

  }  Future<void> openIG() async {
    final uri = Uri.parse("https://www.instagram.com/mochamad.zidan.faizal/?__pwa=1#");
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Tidak dapat membuka Instagram";
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// ===== AVATAR =====
              CircleAvatar(
                radius: 55,
                backgroundColor: Colors.grey.shade200,
                child: const Icon(
                  Icons.person,
                  size: 60,
                ),
              ),

              const SizedBox(height: 16),

              /// ===== NAMA =====
              const Text(
                "Mochamad Zidan Faizal",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                "Mahasiswa Semester 5",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 24),

              /// ===== CARD KONTAK =====
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.chat, color: Colors.green),
                      title: const Text("Hubungi via WhatsApp"),
                      subtitle: const Text("+62 812-2527-9432"),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: openWA,
                    ),
                    const Divider(height: 0),
                    ListTile(
                      leading: const Icon(Icons.email, color: Colors.red),
                      title: const Text("Kirim Email"),
                      subtitle: const Text("mochamadzidanfaizal15@gmail.com"),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: openEmail,
                    ),
                    const Divider(height: 0),
                    ListTile(
                      leading: const Icon(Icons.bug_report, color: Colors.black),
                      title: const Text("Kunjungi GitHub"),
                      subtitle: const Text("ZidanFaizal15"),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: openGit,
                    ),
                    const Divider(height: 0),
                    ListTile(
                      leading: const Icon(Icons.camera, color: Colors.pink),
                      title: const Text("Kunjungi Instagram"),
                      subtitle: const Text("@mochamad.zidan.faizal"),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: openIG,
                    ),
                  ],
                ),
              ),

              const Spacer(),

              /// ===== FOOTER =====
              const Text(
                "UAS Pemrograman Mobile • Flutter",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
