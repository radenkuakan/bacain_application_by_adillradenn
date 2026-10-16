import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'book_review.dart';
import 'review_result_screen.dart';

class LeaderboardProfileScreen extends StatelessWidget {
  const LeaderboardProfileScreen({
    super.key,
    required this.username,
    required this.avatarAsset,
    required this.points,
  });

  final String username;
  final String avatarAsset;
  final int points;

  static const List<_HistoryEntry> _history = [
    _HistoryEntry('12', 'Janji', 'Tere Liye', null),
    _HistoryEntry('11', 'Pulang', 'Tere Liye', null),
    _HistoryEntry(
      '10',
      'Tentang kamu',
      'Tere Liye',
      BookReview(
        rating: 9,
        text: 'Kisahnya terasa dekat dan membuatku penasaran sampai akhir.',
      ),
    ),
    _HistoryEntry(
      '9',
      'Resign',
      'Almira Batsari',
      BookReview(rating: 8, text: 'Ceritanya ringan, seru, dan penuh kejutan.'),
    ),
    _HistoryEntry(
      '8',
      'Atomic Habit',
      'James Clear',
      BookReview(
        rating: 9,
        text: 'Banyak pelajaran sederhana tentang kebiasaan baik.',
      ),
    ),
    _HistoryEntry(
      '7',
      'In a blue moon',
      'Ilana Tan',
      BookReview(rating: 8, text: 'Ceritanya hangat dan nyaman dibaca.'),
    ),
    _HistoryEntry(
      '6',
      'The star and I',
      'Ilana Tan',
      BookReview(
        rating: 9,
        text: 'Perjalanan tokohnya menarik dan menyentuh.',
      ),
    ),
    _HistoryEntry(
      '5',
      'Guru Aini',
      'Andrea Hirata',
      BookReview(
        rating: 9,
        text: 'Kisahnya inspiratif dan bikin semangat belajar.',
      ),
    ),
    _HistoryEntry(
      '4',
      'Sirkus Pohon',
      'Andrea Hirata',
      BookReview(rating: 8, text: 'Tokoh dan ceritanya unik serta menghibur.'),
    ),
    _HistoryEntry(
      '3',
      'Sirkus Pohon',
      'Andrea Hirata',
      BookReview(rating: 9, text: 'Cerita yang seru dengan karakter kuat.'),
    ),
    _HistoryEntry(
      '2',
      'Sirkus Pohon',
      'Andrea Hirata',
      BookReview(rating: 8, text: 'Alurnya menarik dan mudah dinikmati.'),
    ),
    _HistoryEntry(
      '1',
      'Sirkus Pohon',
      'Andrea Hirata',
      BookReview(
        rating: 9,
        text: 'Salah satu cerita yang berkesan dan menyenangkan.',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(
                    Icons.arrow_circle_left_outlined,
                    size: 40,
                    color: Color(0xFF2B3C73),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        avatarAsset,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      '@$username',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
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
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _bioRow('Nama', username),
                    _bioRow('Kelas', '5A Multimedia'),
                    _bioRow('Moto Hidup', 'push rank sampe imo'),
                    _bioRow(
                      'Genre Buku Favorit',
                      '#comedy #sliceoflife #romance',
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Divider(color: Colors.white54, thickness: 1),
                    ),
                    Text(
                      'Poin: $points',
                      style: const TextStyle(
                        color: Color(0xFFFFC107),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                '3 Buku Favorit',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2B3C73),
                ),
              ),
              const SizedBox(height: 15),
              _favoritesTable(),
              const SizedBox(height: 30),
              const Text(
                'Riwayat Bacaan',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2B3C73),
                ),
              ),
              const SizedBox(height: 15),
              _historyTable(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF2B3C73),
        currentIndex: 1,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.star_border), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.book_outlined), label: ''),
        ],
        onTap: (index) {
          if (index == 1) return;
          const routes = ['/home', '/profile', '/leaderboard', '/collection'];
          Navigator.pushNamed(context, routes[index]);
        },
      ),
    );
  }

  Widget _bioRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
          const Text(': ', style: TextStyle(color: Colors.white, fontSize: 13)),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _favoritesTable() {
    return ClipRRect(
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
          children: const [
            TableRow(
              children: [
                _TableCell('#', isHeader: true),
                _TableCell('Judul', isHeader: true),
                _TableCell('Penulis', isHeader: true),
              ],
            ),
            TableRow(
              children: [
                _TableCell('1'),
                _TableCell('Hujan'),
                _TableCell('Tere Liye'),
              ],
            ),
            TableRow(
              children: [
                _TableCell('2'),
                _TableCell('Resign'),
                _TableCell('Almira Batsari'),
              ],
            ),
            TableRow(
              children: [
                _TableCell('3'),
                _TableCell('Janji'),
                _TableCell('Tere Liye'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _historyTable(BuildContext context) {
    return ClipRRect(
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
            const TableRow(
              children: [
                _TableCell('No', isHeader: true),
                _TableCell('Judul', isHeader: true),
                _TableCell('Penulis', isHeader: true),
                _TableCell('Review', isHeader: true),
              ],
            ),
            ..._history.map((entry) => _historyRow(context, entry)),
          ],
        ),
      ),
    );
  }

  TableRow _historyRow(BuildContext context, _HistoryEntry entry) {
    return TableRow(
      children: [
        _TableCell(entry.number, centered: true),
        _TableCell(entry.title, isBold: true),
        _TableCell(entry.author),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          child: Center(
            child: ElevatedButton(
              onPressed: entry.review == null
                  ? null
                  : () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReviewResultScreen(
                          review: entry.review!,
                          bookTitle: entry.title,
                          bookAuthor: entry.author,
                          coverAsset: 'assets/buku-review/buku-janji.png',
                          readOnly: true,
                        ),
                      ),
                    ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFC107),
                disabledBackgroundColor: Colors.grey.shade400,
                foregroundColor: const Color(0xFF2B3C73),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                minimumSize: const Size(80, 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 0,
              ),
              child: Text(
                entry.review == null ? 'Tidak ada' : 'Lihat Review',
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HistoryEntry {
  const _HistoryEntry(this.number, this.title, this.author, this.review);

  final String number;
  final String title;
  final String author;
  final BookReview? review;
}

class _TableCell extends StatelessWidget {
  const _TableCell(
    this.text, {
    this.isHeader = false,
    this.isBold = false,
    this.centered = false,
  });

  final String text;
  final bool isHeader;
  final bool isBold;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: centered || isHeader && text == 'No'
            ? TextAlign.center
            : TextAlign.left,
        style: TextStyle(
          color: const Color(0xFF2B3C73),
          fontWeight: isHeader || isBold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
