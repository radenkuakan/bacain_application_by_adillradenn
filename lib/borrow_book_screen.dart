import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'borrow_code_screen.dart';

class BorrowBookScreen extends StatefulWidget {
  const BorrowBookScreen({super.key});

  @override
  State<BorrowBookScreen> createState() => _BorrowBookScreenState();
}

class _BorrowBookScreenState extends State<BorrowBookScreen> {
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _borrowDateController = TextEditingController();
  final TextEditingController _returnDateController = TextEditingController();
  DateTime? _borrowDate;

  DateTime? get _returnDate => _borrowDate?.add(const Duration(days: 7));

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Future<void> _pickBorrowDate() async {
    final now = DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _borrowDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
    );

    if (selectedDate != null) {
      setState(() {
        _borrowDate = selectedDate;
        _borrowDateController.text = _formatDate(selectedDate);
        _returnDateController.text = _formatDate(_returnDate);
      });
    }
  }

  void _submitRequest() {
    if (_nimController.text.trim().isEmpty || _borrowDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Isi NIM dan tanggal pinjam terlebih dahulu.'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BorrowCodeScreen(
          nim: _nimController.text.trim(),
          borrowDate: _borrowDate!,
          returnDate: _returnDate!,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nimController.dispose();
    _borrowDateController.dispose();
    _returnDateController.dispose();
    super.dispose();
  }

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
              _heading(context),
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
              const SizedBox(height: 28),
              const Text('Isi NIM', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              _outlinedField(
                child: TextField(
                  controller: _nimController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Text('Tanggal Pinjam', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              _outlinedField(
                child: TextField(
                  readOnly: true,
                  controller: _borrowDateController,
                  onTap: _pickBorrowDate,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    suffixIcon: Icon(
                      Icons.calendar_month,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Row(
                children: [
                  Text('Tanggal Kembali', style: TextStyle(fontSize: 16)),
                  SizedBox(width: 6),
                  Text(
                    'Terisi Otomatis',
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _outlinedField(
                child: TextField(
                  readOnly: true,
                  controller: _returnDateController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: _submitRequest,
                  style: _buttonStyle(),
                  child: const Text(
                    'Ajukan',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  Widget _heading(BuildContext context) {
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
        const Text(
          'Pinjam Buku',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _outlinedField({required Widget child}) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFF2B3C73), width: 1.5),
        borderRadius: BorderRadius.circular(25),
      ),
      child: child,
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFFFC107),
      foregroundColor: const Color(0xFF2B3C73),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
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
