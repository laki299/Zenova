import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class PlayerScreen extends StatefulWidget {
  final List<String> playlist;
  final int initialIndex;

  const PlayerScreen({
    super.key,
    required this.playlist,
    this.initialIndex = 0,
  });

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late int _currentIndex;
  bool _isPlaying = true;
  bool _showControls = true;
  bool _isLocked = false;
  bool _isRecordingClip = false;

  double _playbackSpeed = 1.0;
  double _savedSpeedBeforeLongPress = 1.0;
  bool _isLongPressBoosted = false;

  double _currentPosition = 15.0;
  final double _totalDuration = 180.0;

  double? _dragSeekOffset;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _playNext() {
    if (_currentIndex < widget.playlist.length - 1) {
      setState(() {
        _currentIndex++;
        _currentPosition = 0;
      });
    } else {
      _showToast('No next video in playlist');
    }
  }

  void _playPrevious() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _currentPosition = 0;
      });
    } else {
      _showToast('Already at the first video');
    }
  }

  void _takeScreenshot() {
    _showToast('📸 Screenshot saved to Gallery!');
  }

  void _toggleClipRecord() {
    setState(() {
      _isRecordingClip = !_isRecordingClip;
    });
    if (_isRecordingClip) {
      _showToast('✂️ Clip recording started...');
    } else {
      _showToast('✅ Clip saved to Videos folder!');
    }
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: AppTheme.textWhite)),
        backgroundColor: AppTheme.cardGrey,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleDoubleTap(TapDownDetails details, BoxConstraints constraints) {
    final double dx = details.localPosition.dx;
    final double screenWidth = constraints.maxWidth;

    setState(() {
      if (dx > screenWidth / 2) {
        _currentPosition = (_currentPosition + 10).clamp(0, _totalDuration);
        _showToast('⏩ +10s');
      } else {
        _currentPosition = (_currentPosition - 10).clamp(0, _totalDuration);
        _showToast('⏪ -10s');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentVideoTitle = widget.playlist[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _showControls = !_showControls;
                });
              },
              onDoubleTapDown: (details) => _handleDoubleTap(details, constraints),
              onLongPressStart: (_) {
                setState(() {
                  _isLongPressBoosted = true;
                  _savedSpeedBeforeLongPress = _playbackSpeed;
                  _playbackSpeed = 2.0;
                });
              },
              onLongPressEnd: (_) {
                setState(() {
                  _isLongPressBoosted = false;
                  _playbackSpeed = _savedSpeedBeforeLongPress;
                });
              },
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _dragSeekOffset = (_dragSeekOffset ?? 0) + (details.primaryDelta! / 2);
                });
              },
              onHorizontalDragEnd: (_) {
                if (_dragSeekOffset != null) {
                  setState(() {
                    _currentPosition = (_currentPosition + _dragSeekOffset!).clamp(0, _totalDuration);
                    _dragSeekOffset = null;
                  });
                }
              },
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _isPlaying ? Icons.movie_outlined : Icons.pause_circle_outline_rounded,
                            size: 90,
                            color: AppTheme.accentGreen.withOpacity(0.4),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            currentVideoTitle,
                            style: const TextStyle(color: AppTheme.textGrey, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_isLongPressBoosted)
                    Positioned(
                      top: 60,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppTheme.accentGreen.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.fast_forward_rounded, color: Colors.black, size: 18),
                              SizedBox(width: 6),
                              Text(
                                '2X Fast Forwarding...',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (_dragSeekOffset != null)
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppTheme.cardGrey.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Seek: \( {_dragSeekOffset! > 0 ? "+" : ""} \){_dragSeekOffset!.toInt()}s',
                          style: const TextStyle(
                            color: AppTheme.accentGreen,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  if (_showControls) ...[
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.black54,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_rounded, color: AppTheme.textWhite),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Expanded(
                              child: Text(
                                currentVideoTitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: AppTheme.textWhite, fontSize: 14),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.camera_alt_outlined, color: AppTheme.textWhite),
                              onPressed: _takeScreenshot,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.content_cut_rounded,
                                color: _isRecordingClip ? Colors.red : AppTheme.textWhite,
                              ),
                              onPressed: _toggleClipRecord,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (!_isLocked)
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: 42,
                              icon: Icon(
                                Icons.skip_previous_rounded,
                                color: _currentIndex > 0 ? AppTheme.textWhite : AppTheme.textGrey.withOpacity(0.3),
                              ),
                              onPressed: _currentIndex > 0 ? _playPrevious : null,
                            ),
                            const SizedBox(width: 24),
                            CircleAvatar(
                              radius: 32,
                              backgroundColor: AppTheme.accentGreen,
                              child: IconButton(
                                iconSize: 36,
                                icon: Icon(
                                  _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                  color: Colors.black,
                                ),
                                onPressed: _togglePlayPause,
                              ),
                            ),
                            const SizedBox(width: 24),
                            IconButton(
                              iconSize: 42,
                              icon: Icon(
                                Icons.skip_next_rounded,
                                color: _currentIndex < widget.playlist.length - 1
                                    ? AppTheme.textWhite
                                    : AppTheme.textGrey.withOpacity(0.3),
                              ),
                              onPressed: _currentIndex < widget.playlist.length - 1 ? _playNext : null,
                            ),
                          ],
                        ),
                      ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.black87,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!_isLocked) ...[
                              Row(
                                children: [
                                  Text(
                                    '\( {(_currentPosition \~/ 60).toString().padLeft(2, '0')}: \){(_currentPosition.toInt() % 60).toString().padLeft(2, '0')}',
                                    style: const TextStyle(color: AppTheme.textGrey, fontSize: 11),
                                  ),
                                  Expanded(
                                    child: Slider(
                                      value: _currentPosition.clamp(0, _totalDuration),
                                      min: 0,
                                      max: _totalDuration,
                                      activeColor: AppTheme.accentGreen,
                                      inactiveColor: Colors.white24,
                                      onChanged: (val) {
                                        setState(() {
                                          _currentPosition = val;
                                        });
                                      },
                                    ),
                                  ),
                                  Text(
                                    '\( {(_totalDuration \~/ 60).toString().padLeft(2, '0')}: \){(_totalDuration.toInt() % 60).toString().padLeft(2, '0')}',
                                    style: const TextStyle(color: AppTheme.textGrey, fontSize: 11),
                                  ),
                                ],
                              ),
                            ],
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    _isLocked ? Icons.lock_rounded : Icons.lock_open_rounded,
                                    color: _isLocked ? AppTheme.accentGreen : AppTheme.textWhite,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isLocked = !_isLocked;
                                    });
                                  },
                                ),
                                if (!_isLocked)
                                  Text(
                                    'Speed: ${_playbackSpeed}x',
                                    style: const TextStyle(color: AppTheme.textGrey, fontSize: 12),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
