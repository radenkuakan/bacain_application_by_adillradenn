import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'book_detail_screen.dart';

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
          toolbarHeight: 80,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color(0xFF2B3C73),
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_circle_left_outlined,
              size: 40,
              color: Color(0xFF2B3C73),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          titleSpacing: 0,
          title: const Text(
            'Koleksi Buku',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 5),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari Buku',
                      hintStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.black38,
                      ),
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Colors.black87,
                        size: 28,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Color(0xFFDADADA)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Color(0xFF2B3C73)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black54,
                    indicatorColor: Colors.black,
                    indicatorWeight: 3,
                    labelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    tabs: [
                      Tab(text: 'Semua'),
                      Tab(text: 'Education'),
                      Tab(text: 'Novel'),
                      Tab(text: 'Komik'),
                    ],
                  ),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  _BookGrid(titles: _allBookTitles, suffix: ''),
                  _BookGrid(titles: _educationBookTitles, suffix: '-1'),
                  _BookGrid(titles: _novelBookTitles, suffix: '-2'),
                  _BookGrid(titles: _comicBookTitles, suffix: '-3'),
                ],
              ),
            ),
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
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: '',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.star_border), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: ''), // Solid
          ],
          onTap: (index) {
            if (index == 3) return;
            const routes = ['/home', '/profile', '/leaderboard', '/collection'];
            Navigator.pushNamed(context, routes[index]);
          },
        ),
      ),
    );
  }
}

class _BookGrid extends StatelessWidget {
  const _BookGrid({required this.titles, required this.suffix});

  final List<String> titles;
  final String suffix;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.58,
        ),
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.asset(
                      'assets/koleksi-buku-semua/image ${index + 30}$suffix.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      Text(
                        titles[index],
                        style: const TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: () {
                          final title = titles[index];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BookDetailScreen(
                                bookTitle: title,
                                coverAsset:
                                    'assets/koleksi-buku-semua/image ${index + 30}$suffix.png',
                                category: switch (suffix) {
                                  '-1' => 'Education',
                                  '-2' => 'Novel',
                                  '-3' => 'Komik',
                                  _ => 'Umum',
                                },
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFC107),
                          minimumSize: const Size(double.infinity, 25),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Lihat',
                          style: TextStyle(
                            color: Color(0xFF2B3C73),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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

const List<String> _allBookTitles = [
  'Laut Bercerita',
  'Pulang',
  'The Ghost Club',
  'The Let Them Theory',
  'Laskar Pelangi',
  'Si Juki: Harta Pulau Monyet',
  'Otodidak Jago Kuasai Bahasa Inggris dari Nol',
  'Hujan',
  'Pemrograman Python untuk Pemula',
  'Janji',
  'Banyak Takut',
  'Seporsi Mie Ayam Sebelum Mati',
  'Laut Bercerita',
  'The Computer Science Book',
  'Dunia Sophie',
  'Rethink Yourself',
];

const List<String> _educationBookTitles = [
  'Negara dan Kekuasaan Jawa',
  'Di Balik Tragedi 1965',
  'Modul Akuntansi Keuangan',
  'Akuntabilitas Kepala Sekolah',
  'Bahasa Indonesia untuk Perguruan Tinggi',
  'The Computer Science Book',
  'Ilmu Pengetahuan Sosial',
  'Scientific Experiments: Chemistry Biology',
  'Pemrograman Python untuk Pemula',
  'Learning C# by Programming Games',
  'Halaman Terakhir',
  'A Brief History of Time',
  'Rethink Yourself',
  'Gejolak Revolusi di Jakarta 1945-1949',
  'The Let Them Theory',
  'Atomic Habits',
];

const List<String> _novelBookTitles = [
  'Cantik Itu Luka',
  'The Secret Lake',
  'Janji',
  'Negeri Para Bedebah',
  'Dunia Sophie',
  'Hujan',
  'Negeri 5 Menara',
  'Resign',
  'Teka-Teki Rumah Aneh',
  'Dampu Ajaib Sepatu Biru',
  'Spring in London',
  'Laskar Pelangi',
  'Sang Juragan Teh',
  'Seporsi Mie Ayam Sebelum Mati',
  'Pasta Kacang Merah',
  'Bumi Cinta',
];

const List<String> _comicBookTitles = [
  '5 Jam Jadi Ibu',
  'Detective Conan',
  'Komik Jepang',
  'Adikku Ada Tiga',
  'Si Juki: Harta Pulau Monyet',
  'Komik Palsu',
  'Detective Conan',
  'Banyak Takut',
  'Detektif Conan',
  'Timun Mas',
  'Detective Conan',
  'Putput Si Raja Kodok',
  'The Ghost Club',
  'Mainan Surprise',
  'Aku Juga Bisa Berkarya',
  'Powerpuff Girls',
];
