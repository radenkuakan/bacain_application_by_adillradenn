import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> riwayatBacaan = [
      {"no": "12", "judul": "Janji", "penulis": "Tere Liye", "status": "buat"},
      {"no": "11", "judul": "Pulang", "penulis": "Tere Liye", "status": "buat"},
      {"no": "10", "judul": "Tentang kamu", "penulis": "Tere Liye", "status": "lihat"},
      {"no": "9", "judul": "Resign", "penulis": "Almira Batsari", "status": "lihat"},
      {"no": "8", "judul": "Atomic Habit", "penulis": "James clear", "status": "lihat"},
      {"no": "7", "judul": "In a blue moon", "penulis": "Ilana Tan", "status": "lihat"},
      {"no": "6", "judul": "The star and I", "penulis": "Ilana Tan", "status": "lihat"},
      {"no": "5", "judul": "Guru Aini", "penulis": "Andrea Hirata", "status": "lihat"},
      {"no": "4", "judul": "Sirkus Pohon", "penulis": "Andrea Hirata", "status": "lihat"},
      {"no": "3", "judul": "Sirkus Pohon", "penulis": "Andrea Hirata", "status": "lihat"},
      {"no": "2", "judul": "Sirkus Pohon", "penulis": "Andrea Hirata", "status": "lihat"},
      {"no": "1", "judul": "Sirkus Pohon", "penulis": "Andrea Hirata", "status": "lihat"},
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_circle_left_outlined, size: 45, color: Color(0xFF2B3C73)),
                ),
                Center(
                  child: Column(
                    children: [
                      const Icon(Icons.account_circle, size: 120, color: Color(0xFF2B3C73)),
                      const Text(
                        '@username',
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2B3C73),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 10, offset: const Offset(0, 5)),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Table(
                              columnWidths: const {
                                0: IntrinsicColumnWidth(),
                                1: FixedColumnWidth(20),
                                2: FlexColumnWidth(),
                              },
                              children: [
                                _buildBioRow('Nama', 'Jisoo Blackpink'),
                                _buildBioRow('Kelas', '5A Multimedia'),
                                _buildBioRow('Moto Hidup', 'push rank sampe imo'),
                                _buildBioRow('Genre Buku Favorit', '#comedy #sliceoflife #romance'),
                              ],
                            ),
                          ),
                          const Icon(Icons.edit_square, color: Colors.white, size: 24),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Divider(color: Colors.white54, thickness: 1),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Point : 1080',
                            style: TextStyle(color: Color(0xFFFFC107), fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFC107),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              minimumSize: const Size(0, 35),
                            ),
                            child: const Text('Tukarkan', style: TextStyle(color: Color(0xFF2B3C73), fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Text('3 Buku Favorit', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2B3C73))),
                    const SizedBox(width: 10),
                    const Icon(Icons.edit_square, color: Color(0xFF2B3C73), size: 26),
                  ],
                ),
                const SizedBox(height: 15),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: const Color(0xFFFDECB2), 
                    child: Table(
                      border: TableBorder.all(color: Colors.black12, width: 1),
                      columnWidths: const {
                        0: FixedColumnWidth(50),
                        1: FlexColumnWidth(),
                        2: FlexColumnWidth(),
                      },
                      children: [
                        _buildTableHeader(['#', 'Judul', 'Penulis']),
                        _buildTableRow(['1', 'Hujan', 'Tere Liye']),
                        _buildTableRow(['2', 'Resign', 'Almira Batsari']),
                        _buildTableRow(['3', 'Janji', 'Tere Liye']),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text('Riwayat Bacaan', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2B3C73))),
                const SizedBox(height: 15),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: const Color(0xFFFDECB2),
                    child: Table(
                      border: TableBorder.all(color: Colors.black12, width: 1),
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      columnWidths: const {
                        0: FixedColumnWidth(40),
                        1: FlexColumnWidth(1.2),
                        2: FlexColumnWidth(1.2),
                        3: IntrinsicColumnWidth(), 
                      },
                      children: [
                        _buildTableHeader(['No', 'Judul', 'Penulis', 'Review']),
                        ...riwayatBacaan.map((data) => _buildRiwayatRow(data)).toList(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF2B3C73),
        currentIndex: 1, // 1 = Profile
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''), // Solid
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

  TableRow _buildBioRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 13)),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Text(':', style: TextStyle(color: Colors.white, fontSize: 13)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(value, style: const TextStyle(color: Colors.white, fontSize: 13)),
        ),
      ],
    );
  }

  TableRow _buildTableHeader(List<String> titles) {
    return TableRow(
      children: titles.map((title) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2B3C73)),
            textAlign: title == '#' || title == 'No' || title == 'Review' ? TextAlign.center : TextAlign.left,
          ),
        );
      }).toList(),
    );
  }

  TableRow _buildTableRow(List<String> data) {
    return TableRow(
      children: data.map((text) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            text,
            style: const TextStyle(color: Color(0xFF2B3C73)),
            textAlign: data.indexOf(text) == 0 ? TextAlign.center : TextAlign.left,
          ),
        );
      }).toList(),
    );
  }

  TableRow _buildRiwayatRow(Map<String, dynamic> data) {
    bool isLihat = data['status'] == 'lihat';
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          child: Text(data['no'], textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFF2B3C73), fontSize: 12)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          child: Text(data['judul'], style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2B3C73), fontSize: 12)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          child: Text(data['penulis'], style: const TextStyle(color: Color(0xFF2B3C73), fontSize: 12)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: isLihat ? const Color(0xFFFFC107) : const Color(0xFF2B3C73),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                minimumSize: const Size(80, 25),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 0,
              ),
              child: Text(
                isLihat ? 'Lihat Review' : 'Buat Review',
                style: TextStyle(
                  color: isLihat ? const Color(0xFF2B3C73) : Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}