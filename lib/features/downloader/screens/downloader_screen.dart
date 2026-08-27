import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class DownloaderScreen extends StatefulWidget {
  const DownloaderScreen({super.key});

  @override
  State<DownloaderScreen> createState() => _DownloaderScreenState();
}

class _DownloaderScreenState extends State<DownloaderScreen> {
  final TextEditingController _urlController = TextEditingController();
  bool _isDownloading = false;

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  void _startDownload() {
    if (_urlController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('অনুগ্রহ করে ভিডিও লিঙ্ক পেস্ট করুন')),
      );
      return;
    }

    setState(() {
      _isDownloading = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ ভিডিও সফলভাবে ডাউনলোড হয়েছে!'),
            backgroundColor: AppTheme.accentGreen,
          ),
        );
        _urlController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Downloader'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.cardGrey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _urlController,
                      style: const TextStyle(color: AppTheme.textWhite),
                      decoration: const InputDecoration(
                        hintText: 'ভিডিও লিঙ্ক পেস্ট করুন (FB, Insta, Web...)',
                        hintStyle: TextStyle(color: AppTheme.textGrey, fontSize: 13),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.paste_rounded, color: AppTheme.accentGreen),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentGreen,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: _isDownloading ? null : _startDownload,
                child: _isDownloading
                    ? const CircularProgressIndicator(color: Colors.black)
                    : const Text(
                        'ডাউনলোড শুরু করুন',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                      ),
              ),
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.accentGreen,
                side: const BorderSide(color: AppTheme.accentGreen),
              ),
              icon: const Icon(Icons.security_rounded),
              label: const Text('Manual Captcha Bypass Browser'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
