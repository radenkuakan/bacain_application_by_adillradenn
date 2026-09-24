import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5), 
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: const Color(0xFF2B3C73),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 24),
                    const Text('Yakin mau keluar?', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFFFC107)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      ),
                      child: const Text('Ya', style: TextStyle(color: Color(0xFFFFC107), fontSize: 16)),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFC107),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      ),
                      child: const Text('Tidak', style: TextStyle(color: Color(0xFF2B3C73), fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B3C73),
        title: Row(
          children: [
            Image.asset('assets/logo_aplikasi/logo-bacain.png', height: 40),
            const SizedBox(width: 10),
            const Text('Bacain', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white, size: 28),
            onPressed: () => _showLogoutDialog(context),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Cari',
                  suffixIcon: const Icon(Icons.search, color: Colors.black54),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                ),
              ),
              const SizedBox(height: 25),
              const Text('Selamat datang @username', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2B3C73))),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: const Color(0xFFF3E5AB), borderRadius: BorderRadius.circular(20)),
                child: const Text(
                  'Siap menjelajahi dunia baru lewat buku hari ini?\nTemukan buku yang menarik, baca, bagikan ceritamu, dan kumpulkan poin untuk mendapatkan reward!',
                  style: TextStyle(fontSize: 14, color: Color(0xFF2B3C73)),
                ),
              ),
              const SizedBox(height: 30),
              
              Center(
                child: Image.asset('assets/infografis_cara_pakai_aplikasi/infografis.png'),
              ),
              
              const SizedBox(height: 30),
              const Text('10 Buku Terpopuler', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2B3C73))),
              const SizedBox(height: 15),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.65,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/koleksi_buku/image-${index + 1}.png',
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                        ),
                      ),
                      Positioned(
                        top: -5,
                        left: -8,
                        child: Icon(Icons.star, color: const Color(0xFFFFC107), size: 38),
                      ),
                      Positioned(
                        top: 5,
                        left: 8,
                        child: Text('${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      )
                    ],
                  );
                },
              ),
              const SizedBox(height: 30),
              
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(Icons.bookmark_border, size: 50, color: Colors.black87), 
                  const SizedBox(width: 8), 
                  Expanded( 
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Koleksi Buku', 
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF2B3C73)), 
                          maxLines: 1, 
                        ), 
                        const SizedBox(height: 5),
                        ElevatedButton(
                          onPressed: () {
                             Navigator.pushReplacementNamed(context, '/collection');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFC107),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), 
                            minimumSize: const Size(0, 30), 
                          ),
                          child: const Text('Lihat Koleksi', style: TextStyle(color: Color(0xFF2B3C73), fontWeight: FontWeight.bold, fontSize: 11)), 
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  Image.asset('assets/logo_aplikasi/logo-bacain.png', height: 75), 
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF2B3C73),
        currentIndex: 0, // 0 = Home
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''), // Solid
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.star_border), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.book_outlined), label: ''),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/profile');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/leaderboard'); 
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/collection'); 
          }
        },
      ),
    );
  }
}