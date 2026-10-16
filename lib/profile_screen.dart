import 'package:flutter/material.dart';

import 'book_review.dart';
import 'review_book_screen.dart';
import 'review_result_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _points = 7000;
  String _name = 'Jisoo Blackpink';
  String _className = '5A Multimedia';
  String _motto = 'push rank sampe imo';
  String _favoriteGenres = '#comedy #sliceoflife #romance';
  List<List<String>> _favoriteBooks = [
    ['Hujan', 'Tere Liye'],
    ['Resign', 'Almira Batsari'],
    ['Janji', 'Tere Liye'],
  ];
  bool _isEditingBiodata = false;
  bool _isEditingFavoriteBooks = false;
  late final TextEditingController _nameController = TextEditingController();
  late final TextEditingController _classController = TextEditingController();
  late final TextEditingController _mottoController = TextEditingController();
  late final TextEditingController _genresController = TextEditingController();
  List<TextEditingController> _favoriteBookControllers = [];
  BookReview? _janjiReview;
  BookReview? _pulangReview;
  final Map<String, BookReview> _savedReviews = {
    '10': const BookReview(
      rating: 9,
      text: 'Kisahnya terasa dekat dan membuatku penasaran sampai akhir.',
    ),
    '9': const BookReview(
      rating: 8,
      text: 'Ceritanya ringan, seru, dan penuh kejutan.',
    ),
    '8': const BookReview(
      rating: 9,
      text: 'Banyak pelajaran sederhana tentang kebiasaan baik.',
    ),
    '7': const BookReview(
      rating: 8,
      text: 'Ceritanya hangat dan nyaman dibaca.',
    ),
    '6': const BookReview(
      rating: 9,
      text: 'Perjalanan tokohnya menarik dan menyentuh.',
    ),
    '5': const BookReview(
      rating: 9,
      text: 'Kisahnya inspiratif dan bikin semangat belajar.',
    ),
    '4': const BookReview(
      rating: 8,
      text: 'Tokoh dan ceritanya unik serta menghibur.',
    ),
    '3': const BookReview(
      rating: 9,
      text: 'Cerita yang seru dengan karakter kuat.',
    ),
    '2': const BookReview(
      rating: 8,
      text: 'Alurnya menarik dan mudah dinikmati.',
    ),
    '1': const BookReview(
      rating: 9,
      text: 'Salah satu cerita yang berkesan dan menyenangkan.',
    ),
  };

  Future<void> _openBookReview({
    required String bookTitle,
    required String bookAuthor,
    required String coverAsset,
    required BookReview? savedReview,
    required ValueChanged<BookReview> onSave,
  }) async {
    final result = await Navigator.push<BookReview>(
      context,
      MaterialPageRoute(
        builder: (_) => savedReview == null
            ? ReviewBookScreen(
                bookTitle: bookTitle,
                bookAuthor: bookAuthor,
                coverAsset: coverAsset,
              )
            : ReviewResultScreen(
                review: savedReview,
                bookTitle: bookTitle,
                bookAuthor: bookAuthor,
                coverAsset: coverAsset,
              ),
      ),
    );

    if (result != null && mounted) {
      setState(() => onSave(result));
    }
  }

  Future<void> _showRedeemDialog() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (dialogContext) => Dialog(
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
              const Text(
                'Tukar Point kamu?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(dialogContext, false),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFFFC107)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                    ),
                    child: const Text(
                      'Tidak',
                      style: TextStyle(color: Color(0xFFFFC107), fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(dialogContext, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFC107),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                    ),
                    child: const Text(
                      'Ya',
                      style: TextStyle(
                        color: Color(0xFF2B3C73),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (confirmed == true && mounted) {
      await _showBarcodeDialog();
    }
  }

  Future<void> _showBarcodeDialog() async {
    final scanned = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: const Color(0xFF2B3C73),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Barcode',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    const SizedBox(height: 18),
                    GestureDetector(
                      onTap: () => Navigator.pop(dialogContext, true),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/barcode/barkode.png',
                          width: 180,
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'scan barcode kepada penjaga perpustakaan',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -12,
                right: -12,
                child: IconButton(
                  onPressed: () => Navigator.pop(dialogContext, false),
                  icon: const Icon(Icons.close, color: Colors.white, size: 32),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (scanned == true && mounted) {
      await _showSuccessDialog();
    }
  }

  Future<void> _showSuccessDialog() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: const Color(0xFF2B3C73),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 35),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Berhasil!!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 35),
                      const Text(
                        'Selamat Menikmati Snack-mu :)',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -12,
                right: -12,
                child: IconButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  icon: const Icon(Icons.close, color: Colors.white, size: 32),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (mounted) {
      setState(() {
        _points = _points >= 230 ? _points - 230 : 0;
      });
    }
  }

  void _startEditingBiodata() {
    _nameController.text = _name;
    _classController.text = _className;
    _mottoController.text = _motto;
    _genresController.text = _favoriteGenres;
    setState(() => _isEditingBiodata = true);
  }

  void _saveBiodata() {
    setState(() {
      _name = _nameController.text.trim();
      _className = _classController.text.trim();
      _motto = _mottoController.text.trim();
      _favoriteGenres = _genresController.text.trim();
      _isEditingBiodata = false;
    });
  }

  void _cancelBiodataEdit() {
    setState(() => _isEditingBiodata = false);
  }

  void _startEditingFavoriteBooks() {
    for (final controller in _favoriteBookControllers) {
      controller.dispose();
    }
    _favoriteBookControllers = [
      for (final book in _favoriteBooks) ...[
        TextEditingController(text: book[0]),
        TextEditingController(text: book[1]),
      ],
    ];
    setState(() => _isEditingFavoriteBooks = true);
  }

  void _saveFavoriteBooks() {
    setState(() {
      _favoriteBooks = [
        for (var index = 0; index < _favoriteBookControllers.length; index += 2)
          [
            _favoriteBookControllers[index].text.trim(),
            _favoriteBookControllers[index + 1].text.trim(),
          ],
      ];
      _isEditingFavoriteBooks = false;
    });
  }

  void _cancelFavoriteBooksEdit() {
    setState(() => _isEditingFavoriteBooks = false);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _classController.dispose();
    _mottoController.dispose();
    _genresController.dispose();
    for (final controller in _favoriteBookControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> riwayatBacaan = [
      {
        "no": "12",
        "judul": "Janji",
        "penulis": "Tere Liye",
        "status": _janjiReview == null ? "buat" : "lihat",
      },
      {
        "no": "11",
        "judul": "Pulang",
        "penulis": "Tere Liye",
        "status": _pulangReview == null ? "buat" : "lihat",
      },
      {
        "no": "10",
        "judul": "Tentang kamu",
        "penulis": "Tere Liye",
        "status": "lihat",
      },
      {
        "no": "9",
        "judul": "Resign",
        "penulis": "Almira Batsari",
        "status": "lihat",
      },
      {
        "no": "8",
        "judul": "Atomic Habit",
        "penulis": "James Clear",
        "status": "lihat",
      },
      {
        "no": "7",
        "judul": "In a blue moon",
        "penulis": "Ilana Tan",
        "status": "lihat",
      },
      {
        "no": "6",
        "judul": "The star and I",
        "penulis": "Ilana Tan",
        "status": "lihat",
      },
      {
        "no": "5",
        "judul": "Guru Aini",
        "penulis": "Andrea Hirata",
        "status": "lihat",
      },
      {
        "no": "4",
        "judul": "Sirkus Pohon",
        "penulis": "Andrea Hirata",
        "status": "lihat",
      },
      {
        "no": "3",
        "judul": "Sirkus Pohon",
        "penulis": "Andrea Hirata",
        "status": "lihat",
      },
      {
        "no": "2",
        "judul": "Sirkus Pohon",
        "penulis": "Andrea Hirata",
        "status": "lihat",
      },
      {
        "no": "1",
        "judul": "Sirkus Pohon",
        "penulis": "Andrea Hirata",
        "status": "lihat",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B3C73),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
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
                  ],
                ),
                Center(
                  child: Column(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/foto_profil/foto-adill.png',
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Text(
                        '@zoerogf',
                        style: TextStyle(
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
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: _inlineEditActions(
                          isEditing: _isEditingBiodata,
                          color: Colors.white,
                          onEdit: _startEditingBiodata,
                          onSave: _saveBiodata,
                          onCancel: _cancelBiodataEdit,
                        ),
                      ),
                      Table(
                        columnWidths: const {
                          0: IntrinsicColumnWidth(),
                          1: FixedColumnWidth(20),
                          2: FlexColumnWidth(),
                        },
                        children: [
                          _buildBioRow('Nama', _name, _nameController),
                          _buildBioRow('Kelas', _className, _classController),
                          _buildBioRow('Moto Hidup', _motto, _mottoController),
                          _buildBioRow(
                            'Genre Buku Favorit',
                            _favoriteGenres,
                            _genresController,
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Divider(color: Colors.white54, thickness: 1),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Poin: $_points',
                            style: TextStyle(
                              color: Color(0xFFFFC107),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: _showRedeemDialog,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFC107),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ),
                              minimumSize: const Size(0, 35),
                            ),
                            child: const Text(
                              'Tukarkan',
                              style: TextStyle(
                                color: Color(0xFF2B3C73),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Text(
                      '3 Buku Favorit',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2B3C73),
                      ),
                    ),
                    const SizedBox(width: 10),
                    _inlineEditActions(
                      isEditing: _isEditingFavoriteBooks,
                      color: const Color(0xFF2B3C73),
                      onEdit: _startEditingFavoriteBooks,
                      onSave: _saveFavoriteBooks,
                      onCancel: _cancelFavoriteBooksEdit,
                    ),
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
                        ...List.generate(
                          _favoriteBooks.length,
                          _buildFavoriteBookRow,
                        ),
                      ],
                    ),
                  ),
                ),
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: const Color(0xFFFDECB2),
                    child: Table(
                      border: TableBorder.all(color: Colors.black12, width: 1),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      columnWidths: const {
                        0: FixedColumnWidth(40),
                        1: FlexColumnWidth(1.2),
                        2: FlexColumnWidth(1.2),
                        3: IntrinsicColumnWidth(),
                      },
                      children: [
                        _buildTableHeader(['No', 'Judul', 'Penulis', 'Review']),
                        ...riwayatBacaan.map(
                          (data) => _buildRiwayatRow(context, data),
                        ),
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
          if (index == 1) return;
          const routes = ['/home', '/profile', '/leaderboard', '/collection'];
          Navigator.pushNamed(context, routes[index]);
        },
      ),
    );
  }

  TableRow _buildBioRow(
    String label,
    String value,
    TextEditingController controller,
  ) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Text(':', style: TextStyle(color: Colors.white, fontSize: 13)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: _isEditingBiodata
              ? TextField(
                  controller: controller,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 4),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFFC107)),
                    ),
                  ),
                )
              : Text(
                  value,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
        ),
      ],
    );
  }

  Widget _inlineEditActions({
    required bool isEditing,
    required Color color,
    required VoidCallback onEdit,
    required VoidCallback onSave,
    required VoidCallback onCancel,
  }) {
    if (!isEditing) {
      return IconButton(
        onPressed: onEdit,
        visualDensity: VisualDensity.compact,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints.tightFor(width: 32, height: 32),
        icon: Icon(Icons.edit_square, color: color, size: 24),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onCancel,
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints.tightFor(width: 32, height: 32),
          icon: Icon(Icons.close, color: color, size: 20),
        ),
        IconButton(
          onPressed: onSave,
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints.tightFor(width: 32, height: 32),
          icon: const Icon(Icons.check, color: Color(0xFFFFC107), size: 22),
        ),
      ],
    );
  }

  TableRow _buildFavoriteBookRow(int index) {
    final book = _favoriteBooks[index];
    final firstController = _isEditingFavoriteBooks
        ? _favoriteBookControllers[index * 2]
        : null;
    final secondController = _isEditingFavoriteBooks
        ? _favoriteBookControllers[index * 2 + 1]
        : null;

    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            '${index + 1}',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFF2B3C73)),
          ),
        ),
        _favoriteBookCell(book[0], firstController),
        _favoriteBookCell(book[1], secondController),
      ],
    );
  }

  Widget _favoriteBookCell(String value, TextEditingController? controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: _isEditingFavoriteBooks && controller != null
          ? TextField(
              controller: controller,
              style: const TextStyle(color: Color(0xFF2B3C73)),
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black26),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2B3C73)),
                ),
              ),
            )
          : Text(value, style: const TextStyle(color: Color(0xFF2B3C73))),
    );
  }

  TableRow _buildTableHeader(List<String> titles) {
    return TableRow(
      children: titles.map((title) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF2B3C73),
            ),
            textAlign: title == '#' || title == 'No' || title == 'Review'
                ? TextAlign.center
                : TextAlign.left,
          ),
        );
      }).toList(),
    );
  }

  TableRow _buildRiwayatRow(BuildContext context, Map<String, dynamic> data) {
    bool isLihat = data['status'] == 'lihat';
    final rowNumber = data['no'] as String;
    final savedReview = switch (rowNumber) {
      '12' => _janjiReview,
      '11' => _pulangReview,
      _ => _savedReviews[rowNumber],
    };
    final coverAsset = rowNumber == '11'
        ? 'assets/buku-review/buku-pulang.png'
        : 'assets/buku-review/buku-janji.png';

    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          child: Text(
            data['no'],
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFF2B3C73), fontSize: 12),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          child: Text(
            data['judul'],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF2B3C73),
              fontSize: 12,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          child: Text(
            data['penulis'],
            style: const TextStyle(color: Color(0xFF2B3C73), fontSize: 12),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                _openBookReview(
                  bookTitle: data['judul'] as String,
                  bookAuthor: data['penulis'] as String,
                  coverAsset: coverAsset,
                  savedReview: savedReview,
                  onSave: (review) {
                    if (rowNumber == '12') {
                      _janjiReview = review;
                    } else if (rowNumber == '11') {
                      _pulangReview = review;
                    } else {
                      _savedReviews[rowNumber] = review;
                    }
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isLihat
                    ? const Color(0xFFFFC107)
                    : const Color(0xFF2B3C73),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                minimumSize: const Size(80, 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
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
