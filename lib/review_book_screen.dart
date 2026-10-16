import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'book_review.dart';
import 'review_result_screen.dart';

class ReviewBookScreen extends StatefulWidget {
  const ReviewBookScreen({
    super.key,
    required this.bookTitle,
    required this.bookAuthor,
    required this.coverAsset,
  });

  final String bookTitle;
  final String bookAuthor;
  final String coverAsset;

  @override
  State<ReviewBookScreen> createState() => _ReviewBookScreenState();
}

class _ReviewBookScreenState extends State<ReviewBookScreen> {
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  Future<void> _finishReview() async {
    final rating = int.tryParse(_ratingController.text);
    if (rating == null || rating < 1 || rating > 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan rating dari 1 sampai 10.')),
      );
      return;
    }

    final result = await Navigator.push<BookReview>(
      context,
      MaterialPageRoute(
        builder: (_) => ReviewResultScreen(
          review: BookReview(
            rating: rating,
            text: _reviewController.text.trim(),
          ),
          bookTitle: widget.bookTitle,
          bookAuthor: widget.bookAuthor,
          coverAsset: widget.coverAsset,
        ),
      ),
    );

    if (result != null && mounted) {
      Navigator.pop(context, result);
    }
  }

  @override
  void dispose() {
    _ratingController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final coverWidth = MediaQuery.sizeOf(context).width * 0.4;

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
                    onPressed: () => Navigator.pop(context),
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
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    widget.coverAsset,
                    width: coverWidth,
                    height: coverWidth * 1.5,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 38),
              Row(
                children: [
                  const Text(
                    'Beri Rating',
                    style: TextStyle(
                      color: Color(0xFF2B3C73),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 48,
                    height: 44,
                    child: TextField(
                      controller: _ratingController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 2,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          if (newValue.text.isEmpty) return newValue;
                          final rating = int.tryParse(newValue.text);
                          return rating != null && rating >= 1 && rating <= 10
                              ? newValue
                              : oldValue;
                        }),
                      ],
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.zero,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF2B3C73),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF2B3C73),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    '/10',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 110,
                    child: Text(
                      'Beri Review',
                      style: TextStyle(
                        color: Color(0xFF2B3C73),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 320,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFF2B3C73)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 4, right: 8),
                            child: Icon(
                              Icons.mic_none,
                              color: Colors.black87,
                              size: 22,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _reviewController,
                              expands: true,
                              minLines: null,
                              maxLines: null,
                              textAlignVertical: TextAlignVertical.top,
                              decoration: const InputDecoration(
                                hintText: 'Tulis review...',
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: _finishReview,
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
                  child: const Text(
                    'Selesai',
                    style: TextStyle(fontWeight: FontWeight.bold),
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
}
