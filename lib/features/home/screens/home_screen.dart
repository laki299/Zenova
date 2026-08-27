import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/natural_sort.dart';
import '../../player/screens/player_screen.dart';
import '../../downloader/screens/downloader_screen.dart';
import '../../share/screens/share_screen.dart';
import '../../vault/screens/vault_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavIndex = 0;

  // ডেমো ভিডিও তালিকা
  final List<String> _rawVideoList = [
    'Tutorial Part 10 - Master Class.mp4',
    'Tutorial Part 1 - Introduction.mp4',
    'Tutorial Part 2 - Installation.mp4',
    'Tutorial Part 3 - Basic Setup.mp4',
    'My Family Tour 2026.mp4',
  ];

  late List<String> _sortedVideoList;

  @override
  void initState() {
    super.initState();
    _sortedVideoList = NaturalSort.sortFilenames(_rawVideoList);
  }

  void _openPlayer(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayerScreen(
          playlist: _sortedVideoList,
          initialIndex: index,
        ),
      ),
    );
  }

  // Videos ট্যাবের বডি
  Widget _buildVideosTab() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZENOVA Media'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.folder_open_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _sortedVideoList.length,
        itemBuilder: (context, index) {
          final videoName = _sortedVideoList[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.cardGrey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              leading: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: AppTheme.amoledBlack,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.play_circle_fill_rounded,
                  color: AppTheme.accentGreen,
                ),
              ),
              title: Text(
                videoName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, color: AppTheme.textWhite),
              ),
              subtitle: Text(
                'Part ${index + 1} • Local Storage',
                style: const TextStyle(fontSize: 12, color: AppTheme.textGrey),
              ),
              trailing: const Icon(Icons.more_vert_rounded, color: AppTheme.textGrey),
              onTap: () => _openPlayer(index),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildVideosTab(),
      const DownloaderScreen(),
      const ShareScreen(),
      const VaultScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedNavIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedNavIndex,
        onTap: (index) {
          setState(() {
            _selectedNavIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library_rounded),
            label: 'Videos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download_rounded),
            label: 'Downloader',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.share_rounded),
            label: 'Share',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock_rounded),
            label: 'Vault',
          ),
        ],
      ),
    );
  }
}
