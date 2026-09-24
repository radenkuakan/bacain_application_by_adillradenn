import 'package:flutter/material.dart';

class SectionScreen extends StatelessWidget {
  const SectionScreen({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;

  static const navy = Color(0xFF2B3C73);
  static const cream = Color(0xFFF8F5EF);
  static const yellow = Color(0xFFFFD447);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        backgroundColor: navy,
        foregroundColor: Colors.white,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: navy, size: 76),
              const SizedBox(height: 22),
              Text(title, style: const TextStyle(color: navy, fontSize: 28, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              const Text('Halaman ini siap dikembangkan ke fitur berikutnya.', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.black54)),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                icon: const Icon(Icons.home_outlined),
                label: const Text('Kembali ke Beranda'),
                style: ElevatedButton.styleFrom(backgroundColor: yellow, foregroundColor: navy, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
