import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'borrow_success_screen.dart';

class BorrowCodeScreen extends StatelessWidget {
  const BorrowCodeScreen({
    super.key,
    required this.nim,
    required this.borrowDate,
    required this.returnDate,
  });

  final String nim;
  final DateTime borrowDate;
  final DateTime returnDate;

  @override
  Widget build(BuildContext context) {
    final coverWidth = MediaQuery.sizeOf(context).width * 0.42;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F3EC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B3C73),
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFF2B3C73),
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.arrow_circle_left_outlined,
                      size: 40,
                      color: Color(0xFF2B3C73),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Pinjam Buku',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/koleksi-buku-semua/image 31.png',
                    width: coverWidth,
                    height: coverWidth * 1.55,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 44),
              const Center(
                child: Text(
                  'Kode Pinjam',
                  style: TextStyle(
                    color: Color(0xFF2B3C73),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const BorrowSuccessScreen(),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDECB2),
                    border: Border.all(color: const Color(0xFF2B3C73)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        '887512',
                        style: TextStyle(color: Colors.black, fontSize: 42),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Tunjukkan kode pinjam kepada penjaga perpustakaan',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF2B3C73),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '*Ambil buku dalam waktu 15 menit sebelum kode pinjam hangus',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFF2B3C73),
      currentIndex: 3,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: 30,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.star_border), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: ''),
      ],
      onTap: (index) {
        if (index == 3) return;
        const routes = ['/home', '/profile', '/leaderboard', '/collection'];
        Navigator.pushNamed(context, routes[index]);
      },
    );
  }
}
