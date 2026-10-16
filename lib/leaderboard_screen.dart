import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'leaderboard_profile_screen.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  static const List<_LeaderboardEntry> _entries = [
    _LeaderboardEntry(1, '3mamah', '7070'),
    _LeaderboardEntry(2, 'zoerogf', '7000'),
    _LeaderboardEntry(3, 'alya_margaasih', '6000'),
    _LeaderboardEntry(4, 'myp_sebenarnya', '5000'),
    _LeaderboardEntry(5, 'kopomacett', '4000'),
    _LeaderboardEntry(6, 'when_yh', '3000'),
    _LeaderboardEntry(7, 'yarreu525', '2068'),
    _LeaderboardEntry(8, 'pacarjimin', '2030'),
    _LeaderboardEntry(9, 'starboyy__', '2011'),
    _LeaderboardEntry(10, 'nyawit_02', '80'),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform.translate(
              offset: const Offset(-25, -9),
              child: Row(
                children: [
                  SizedBox(
                    width: 56,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_circle_left_outlined,
                        size: 40,
                        color: Color(0xFF2B3C73),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const Text(
                    'Leaderboard',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari',
                hintStyle: const TextStyle(fontSize: 18, color: Colors.black38),
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
            const SizedBox(height: 18),
            LayoutBuilder(
              builder: (context, constraints) =>
                  _buildPodium(constraints.maxWidth),
            ),
            const SizedBox(height: 18),
            ..._entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _buildRankingRow(context, entry),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF2B3C73),
        currentIndex: 2,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.book_outlined), label: ''),
        ],
        onTap: (index) {
          if (index == 2) return;
          const routes = ['/home', '/profile', '/leaderboard', '/collection'];
          Navigator.pushNamed(context, routes[index]);
        },
      ),
    );
  }

  Widget _buildPodium(double width) {
    final podiumHeight = width * 0.57;
    const profileHeadroom = 32.0;
    final height = podiumHeight + profileHeadroom;

    return SizedBox(
      height: height,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/gambar-grafis-juara-leaderboard/graafis-juara.png',
              width: width,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            top: 0,
            left: width * 0.35,
            child: _buildPodiumUser(_entries[0], width * 0.20, width * 0.30),
          ),
          Positioned(
            top: podiumHeight * 0.12 + profileHeadroom - 8,
            left: width * 0.10,
            child: _buildPodiumUser(_entries[1], width * 0.17, width * 0.24),
          ),
          Positioned(
            top: podiumHeight * 0.22 + profileHeadroom - 8,
            left: width * 0.68,
            child: _buildPodiumUser(_entries[2], width * 0.17, width * 0.24),
          ),
        ],
      ),
    );
  }

  Widget _buildPodiumUser(
    _LeaderboardEntry entry,
    double avatarSize,
    double labelWidth,
  ) {
    return SizedBox(
      width: labelWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipOval(
            child: Image.asset(
              entry.avatarPath,
              width: avatarSize,
              height: avatarSize,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: labelWidth,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFF2B3C73),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(
                  entry.username,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${entry.points} Point',
                  style: const TextStyle(color: Colors.white, fontSize: 6),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRankingRow(BuildContext context, _LeaderboardEntry entry) {
    final isCurrentUser = entry.rank == 2;
    final foregroundColor = isCurrentUser
        ? const Color(0xFFFFE99B)
        : const Color(0xFF2B3C73);

    return GestureDetector(
      onTap: () {
        if (isCurrentUser) {
          Navigator.pushNamed(context, '/profile');
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LeaderboardProfileScreen(
                username: entry.username,
                avatarAsset: entry.avatarPath,
                points: int.parse(entry.points),
              ),
            ),
          );
        }
      },
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isCurrentUser
              ? const Color(0xFF2B3C73)
              : const Color(0xFFF9E8A0),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.22),
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 22,
              child: Text(
                '${entry.rank}',
                style: TextStyle(color: foregroundColor, fontSize: 13),
              ),
            ),
            ClipOval(
              child: Image.asset(
                entry.avatarPath,
                width: 38,
                height: 38,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                isCurrentUser ? '${entry.username} (You)' : entry.username,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: foregroundColor,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 92,
              child: Text(
                '${entry.points} Point',
                maxLines: 1,
                style: TextStyle(color: foregroundColor, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LeaderboardEntry {
  const _LeaderboardEntry(this.rank, this.username, this.points)
    : avatarPath = 'assets/foto-profil-leaderboard/$rank.png';

  final int rank;
  final String username;
  final String points;
  final String avatarPath;
}
