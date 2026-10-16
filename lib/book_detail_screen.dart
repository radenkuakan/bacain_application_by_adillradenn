import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'book_review.dart';
import 'borrow_book_screen.dart';
import 'review_result_screen.dart';

class BookDetailScreen extends StatelessWidget {
  const BookDetailScreen({
    super.key,
    required this.bookTitle,
    required this.coverAsset,
    required this.category,
  });

  final String bookTitle;
  final String coverAsset;
  final String category;

  bool get _isAvailable => bookTitle == 'Pulang';

  String get _author =>
      const {
        'Laut Bercerita': 'Leila S. Chudori',
        'Pulang': 'Tere Liye',
        'Laskar Pelangi': 'Andrea Hirata',
        'Hujan': 'Tere Liye',
        'Janji': 'Tere Liye',
        'The Let Them Theory': 'Mel Robbins',
        'Atomic Habits': 'James Clear',
        'The Secret Lake': 'Karen Inglis',
        'Cantik Itu Luka': 'Eka Kurniawan',
        'Resign': 'Almira Batsari',
        'A Brief History of Time': 'Stephen Hawking',
        'Bumi Cinta': 'Habiburrahman El Shirazy',
      }[bookTitle] ??
      'Penulis buku';

  String get _availableDate {
    final date = DateTime.now().add(const Duration(days: 7));
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/${date.year % 100}';
  }

  static const List<_RelatedReview> _reviews = [
    _RelatedReview(
      'kimpulpremium',
      8,
      'Ceritanya menyentuh dan mudah diikuti.',
    ),
    _RelatedReview(
      'mahasigma',
      9,
      'Banyak bagian yang bikin ikut terbawa suasana.',
    ),
    _RelatedReview('myp_sebenarnya', 10, 'Salah satu novel terbaik Tere Liye.'),
    _RelatedReview('klarakliri', 9, 'Alurnya bagus dan karakternya kuat.'),
    _RelatedReview(
      'mingyu54_',
      9,
      'Ceritanya membuat ingin membaca sampai selesai.',
    ),
    _RelatedReview('jennieruby', 9, 'Buku yang berkesan dan penuh makna.'),
    _RelatedReview(
      'dilan_cibiru',
      10,
      'Sangat suka dengan cerita dan pesannya.',
    ),
    _RelatedReview('3mamah_', 9, 'Ceritanya seru, sedih, dan menyentuh.'),
    _RelatedReview('yattaa', 9, 'Rekomendasi untuk pencinta novel.'),
  ];

  @override
  Widget build(BuildContext context) {
    final coverWidth = MediaQuery.sizeOf(context).width * 0.34;

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
              _pageHeading(context, 'Detail Buku'),
              const SizedBox(height: 28),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      coverAsset,
                      width: coverWidth,
                      height: coverWidth * 1.55,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFCF9F0),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 8,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _detailRow('Judul', bookTitle),
                          _detailRow('Penulis', _author),
                          _detailRow('Tahun Terbit', '2019'),
                          _detailRow(
                            'Genre',
                            _isAvailable ? 'Action, Life' : category,
                          ),
                          _detailRow('Banyak Buku', '4 (empat)'),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: _isAvailable
                                ? () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const BorrowBookScreen(),
                                    ),
                                  )
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isAvailable
                                  ? const Color(0xFFFFC107)
                                  : Colors.grey.shade300,
                              foregroundColor: _isAvailable
                                  ? const Color(0xFF2B3C73)
                                  : Colors.grey.shade700,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            child: const Text(
                              'Pinjam Buku',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          if (!_isAvailable) ...[
                            const SizedBox(height: 8),
                            Text(
                              'Buku sedang dipinjam. Akan tersedia kembali pada tanggal $_availableDate',
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'Review Terkait',
                style: TextStyle(
                  color: Color(0xFF2B3C73),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              _reviewTable(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  Widget _pageHeading(BuildContext context, String title) {
    return Row(
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
        Text(
          title,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 82,
            child: Text(
              label,
              style: const TextStyle(color: Colors.black54, fontSize: 13),
            ),
          ),
          const Text(': ', style: TextStyle(color: Colors.black87)),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF2B3C73),
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _reviewTable(BuildContext context) {
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
            2: FlexColumnWidth(0.7),
            3: IntrinsicColumnWidth(),
          },
          children: [
            const TableRow(
              children: [
                _ReviewCell('No', isHeader: true),
                _ReviewCell('Username', isHeader: true),
                _ReviewCell('Rating', isHeader: true),
                _ReviewCell('Review', isHeader: true),
              ],
            ),
            ..._reviews.indexed.map(
              (item) => _reviewRow(context, item.$1 + 1, item.$2),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _reviewRow(BuildContext context, int number, _RelatedReview review) {
    return TableRow(
      children: [
        _ReviewCell('$number'),
        _ReviewCell(review.username),
        _ReviewCell('${review.rating}/10', centered: true),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
          child: ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ReviewResultScreen(
                  review: BookReview(rating: review.rating, text: review.text),
                  bookTitle: bookTitle,
                  bookAuthor: _author,
                  coverAsset: coverAsset,
                  readOnly: true,
                ),
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2B3C73),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
              minimumSize: const Size(76, 28),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: const Text('Lihat Review', style: TextStyle(fontSize: 9)),
          ),
        ),
      ],
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

class _RelatedReview {
  const _RelatedReview(this.username, this.rating, this.text);

  final String username;
  final int rating;
  final String text;
}

class _ReviewCell extends StatelessWidget {
  const _ReviewCell(this.text, {this.isHeader = false, this.centered = false});

  final String text;
  final bool isHeader;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9),
      child: Text(
        text,
        textAlign: centered || isHeader ? TextAlign.center : TextAlign.left,
        style: TextStyle(
          color: const Color(0xFF2B3C73),
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: 12,
        ),
      ),
    );
  }
}
