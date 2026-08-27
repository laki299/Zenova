import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ShareScreen extends StatelessWidget {
  const ShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline Quick Share'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_tethering_rounded, size: 80, color: AppTheme.accentGreen),
              const SizedBox(height: 16),
              const Text(
                'ইন্টারনেট ছাড়াই হাই-স্পিড শেয়ার',
                style: TextStyle(color: AppTheme.textWhite, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'হটস্পট এবং QR কোড ব্যবহার করে পাশের ফোনে ভিডিও ও ফাইল পাঠাও',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppTheme.textGrey, fontSize: 13),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentGreen,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      icon: const Icon(Icons.send_rounded, color: Colors.black),
                      label: const Text('Send File', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.cardGrey,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      icon: const Icon(Icons.call_received_rounded, color: AppTheme.textWhite),
                      label: const Text('Receive', style: TextStyle(color: AppTheme.textWhite)),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
