import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> leaderboardData = [
      {"no": "1", "username": "3mamah", "point": "7070"},
      {"no": "2", "username": "zoerogf", "point": "7069"},
      {"no": "3", "username": "alya_margaasih", "point": "7068"},
      {"no": "4", "username": "salsa.tasik", "point": "7058"},
      {"no": "5", "username": "kimpul premium", "point": "7050"},
      {"no": "6", "username": "nopalkoepo", "point": "7041"},
      {"no": "7", "username": "anan.uber", "point": "7038"},
      {"no": "8", "username": "whenyh_2026", "point": "7034"},
      {"no": "9", "username": "demi_kemuliaan", "point": "7030"},
      {"no": "10", "username": "tinkerbell", "point": "6070"},
      {"no": "11", "username": "silvermist", "point": "6069"},
      {"no": "12", "username": "hayang.jajan", "point": "6068"},
      {"no": "13", "username": "bandrek_balap", "point": "6058"},
      {"no": "14", "username": "belum.mandi", "point": "6050"},
      {"no": "15", "username": "dila.sukabumi", "point": "6041"},
      {"no": "16", "username": "doa_geprek10", "point": "6038"},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B3C73),
        elevation: 0,
        toolbarHeight: 0, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.leaderboard, size: 45, color: Color(0xFFFFC107)),
                const SizedBox(width: 15),
                const Text(
                  'Leaderboard',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari',
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
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFDECB2),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 3)),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SingleChildScrollView(
                    child: Table(
                      border: TableBorder.symmetric(inside: const BorderSide(color: Colors.black12, width: 1)),
                      columnWidths: const {
                        0: FixedColumnWidth(60),
                        1: FlexColumnWidth(),
                        2: FlexColumnWidth(),
                      },
                      children: [
                        const TableRow(
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
                          ),
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text('No', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2B3C73))),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                              child: Text('Username', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2B3C73))),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text('Point', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2B3C73))),
                            ),
                          ],
                        ),
                        ...leaderboardData.map((data) => TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Text(data['no']!, textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFF2B3C73))),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                              child: Text(data['username']!, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2B3C73))),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Text(data['point']!, textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFF2B3C73))),
                            ),
                          ],
                        )).toList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF2B3C73),
        currentIndex: 2, // 2 = Leaderboard
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: ''), // Solid
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