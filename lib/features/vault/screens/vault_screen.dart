import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class VaultScreen extends StatefulWidget {
  const VaultScreen({super.key});

  @override
  State<VaultScreen> createState() => _VaultScreenState();
}

class _VaultScreenState extends State<VaultScreen> {
  bool _isUnlocked = false;
  final TextEditingController _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _unlockVault() {
    if (_pinController.text == '1234') {
      setState(() {
        _isUnlocked = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ভুল পিন নম্বর! (ডিফল্ট পিন: 1234)')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Private Vault'),
      ),
      body: _isUnlocked
          ? const Center(
              child: Text(
                '🔒 ভল্ট খালি। নতুন ফাইল হাইড করতে প্লাস বাটনে চাপুন।',
                style: TextStyle(color: AppTheme.textGrey),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock_rounded, size: 70, color: AppTheme.accentGreen),
                  const SizedBox(height: 16),
                  const Text(
                    'প্রাইভেট ফোল্ডার আনলক করুন',
                    style: TextStyle(color: AppTheme.textWhite, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _pinController,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppTheme.textWhite, fontSize: 20, letterSpacing: 8),
                    decoration: InputDecoration(
                      hintText: 'PIN (1234)',
                      hintStyle: const TextStyle(color: AppTheme.textGrey, fontSize: 14, letterSpacing: 0),
                      filled: true,
                      fillColor: AppTheme.cardGrey,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accentGreen,
                      minimumSize: const Size(double.infinity, 45),
                    ),
                    onPressed: _unlockVault,
                    child: const Text('Unlock', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
    );
  }
}
