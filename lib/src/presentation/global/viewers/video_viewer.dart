import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoViewer extends StatefulWidget {
  final String path;
  final double? width;
  final double? height;
  final bool loop;

  const VideoViewer({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.loop = false,
  });

  @override
  State<VideoViewer> createState() => _VideoViewerState();
}

class _VideoViewerState extends State<VideoViewer> {
  late VideoPlayerController _controller;
  bool _initialized = false;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  @override
  void didUpdateWidget(covariant VideoViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.path != widget.path) {
      _disposeController();
      _initController();
    }
  }

  void _initController() {
    try {
      if (widget.path.startsWith('http')) {
        _controller = VideoPlayerController.networkUrl(Uri(path: widget.path));
      } else {
        _controller = VideoPlayerController.file(File(widget.path));
      }
      _controller.setLooping(widget.loop);
      _controller.initialize().then((_) {
        if (!mounted) return;

        if (_controller.value.duration.inSeconds > 10) {
          setState(() {
            _error = true;
            return;
          });
        }

        setState(() => _initialized = true);
        _controller.play();

        // Detener después de 10 segundos
        _controller.addListener(() {
          if (_controller.value.position.inSeconds >= 10) {
            _controller.pause();
            _controller.seekTo(const Duration(seconds: 0));
          }
        });
      }).catchError((_) {
        if (!mounted) return;
        setState(() => _error = true);
      });
    } catch (_) {
      _error = true;
    }
  }

  void _disposeController() {
    try {
      _controller.pause();
      _controller.dispose();
    } catch (_) {}
    _initialized = false;
    _error = false;
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return SizedBox(
        width: widget.width,
        height: widget.height ?? 200,
        child: const Center(child: Icon(Icons.broken_image, color: Colors.red, size: 36)),
      );
    }

    if (!_initialized) {
      return SizedBox(
        width: widget.width,
        height: widget.height ?? 200,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      width: widget.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(aspectRatio: _controller.value.aspectRatio, child: VideoPlayer(_controller)),
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: VideoProgressIndicator(_controller, allowScrubbing: true),
          ),
          GestureDetector(
            onTap: () => setState(() {
              _controller.value.isPlaying ? _controller.pause() : _controller.play();
            }),
            child: Icon(
              _controller.value.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
              color: Colors.white70,
              size: 56,
            ),
          ),
        ],
      ),
    );
  }
}
