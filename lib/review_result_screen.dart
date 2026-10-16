import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'book_review.dart';

class ReviewResultScreen extends StatefulWidget {
  const ReviewResultScreen({
    super.key,
    required this.review,
    required this.bookTitle,
    required this.bookAuthor,
    required this.coverAsset,
    this.readOnly = false,
  });

  final BookReview review;
  final String bookTitle;
  final String bookAuthor;
  final String coverAsset;
  final bool readOnly;

  @override
  State<ReviewResultScreen> createState() => _ReviewResultScreenState();
}

class _ReviewResultScreenState extends State<ReviewResultScreen> {
  late final TextEditingController _reviewController = TextEditingController(
    text: widget.review.text,
  );
  late BookReview _review = widget.review;
  bool _isEditing = false;

  Future<void> _saveReview() async {
    final saveChanges = await showDialog<bool>(
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
                'Simpan Perubahan?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  const SizedBox(width: 20),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (!mounted || saveChanges == null) return;

    setState(() {
      if (saveChanges) {
        _review = BookReview(
          rating: _review.rating,
          text: _reviewController.text.trim(),
        );
      } else {
        _reviewController.text = _review.text;
      }
      _isEditing = false;
    });
  }

  void _returnToProfile() {
    if (widget.readOnly) {
      Navigator.pop(context);
      return;
    }
    Navigator.pop(context, _review);
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final coverWidth = MediaQuery.sizeOf(context).width * 0.32;

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
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 24),
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
                    onPressed: _returnToProfile,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Review Buku',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      widget.coverAsset,
                      width: coverWidth,
                      height: coverWidth * 1.5,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
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
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _bookDetail('Judul', widget.bookTitle),
                          _bookDetail('Penulis', widget.bookAuthor),
                          _bookDetail('Rating', '${_review.rating}/10'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 34),
              const Center(
                child: Text(
                  'Review',
                  style: TextStyle(
                    color: Color(0xFF2B3C73),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 300,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFF2B3C73)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: _isEditing
                          ? TextField(
                              controller: _reviewController,
                              expands: true,
                              minLines: null,
                              maxLines: null,
                              textAlignVertical: TextAlignVertical.top,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                            )
                          : SingleChildScrollView(
                              padding: EdgeInsets.only(
                                top: widget.readOnly ? 0 : 32,
                              ),
                              child: Text(
                                _review.text,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                    ),
                    if (!_isEditing && !widget.readOnly)
                      Positioned(
                        top: -10,
                        right: -10,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _reviewController.text = _review.text;
                              _isEditing = true;
                            });
                          },
                          icon: const Icon(
                            Icons.edit_square,
                            color: Colors.black38,
                            size: 28,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: _isEditing ? _saveReview : _returnToProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107),
                    foregroundColor: const Color(0xFF2B3C73),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    _isEditing ? 'Simpan' : 'Kembali',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
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

  Widget _bookDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(
            width: 74,
            child: Text(
              label,
              style: const TextStyle(color: Color(0xFF2B3C73), fontSize: 14),
            ),
          ),
          const Text(': ', style: TextStyle(color: Color(0xFF2B3C73))),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF2B3C73),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
