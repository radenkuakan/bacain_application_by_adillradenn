import 'package:flutter/material.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, 
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF6F4EB), 
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_circle_left_outlined, size: 40, color: Color(0xFF2B3C73)),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Koleksi Buku',
            style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(130), 
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari Buku',
                      suffixIcon: const Icon(Icons.search, color: Colors.black54),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30), 
                        borderSide: const BorderSide(color: Colors.black12)
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const TabBar(
                    isScrollable: true,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black54,
                    indicatorColor: Colors.black,
                    indicatorWeight: 3,
                    labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    tabs: [
                      Tab(text: 'Semua'),
                      Tab(text: 'Education'),
                      Tab(text: 'Novel'),
                      Tab(text: 'Komik'),
                    ],
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            _BookGrid(),
            _BookGrid(),
            _BookGrid(),
            _BookGrid(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF2B3C73),
          currentIndex: 3, // 3 = Collection
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 30,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.star_border), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: ''), // Solid
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
      ),
    );
  }
}

class _BookGrid extends StatelessWidget {
  const _BookGrid();

  @override
  Widget build(BuildContext context) {
    final List<String> judulBuku = [
      'Cantik Itu Luka', 'The Secret Lake', 'The Ghost Club', 'Let Them Teori',
      'Laskar Pelangi', 'Naruto Shippuden', 'Jago Inggris', 'Hujan',
      'Belajar Python', 'Bumi Manusia'
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, 
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 0.55, 
        ),
        itemCount: 20, 
        itemBuilder: (context, index) {
          int actualIndex = index % 10; 
          
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 3)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                    child: Image.asset(
                      'assets/koleksi_buku/image-${actualIndex + 1}.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      Text(
                        judulBuku[actualIndex],
                        style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFC107),
                          minimumSize: const Size(double.infinity, 25), 
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('Lihat', style: TextStyle(color: Color(0xFF2B3C73), fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}