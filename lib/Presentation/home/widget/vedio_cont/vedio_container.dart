import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

class LoopingVideoWidget extends StatelessWidget {
  final String videoPath;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadius borderRadius;

  const LoopingVideoWidget({
    super.key,
    required this.videoPath,
    this.width = 55,
    this.height = 50,
    this.fit = BoxFit.cover,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(
        width: width,
        height: height,
        child: _LoopingVideoPlayer(
          videoPath: videoPath,
          fit: fit,
          width: width,
          height: height,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}

class _LoopingVideoPlayer extends StatefulWidget {
  final String videoPath;
  final BoxFit fit;
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const _LoopingVideoPlayer({
    required this.videoPath,
    required this.fit,
    required this.width,
    required this.height,
    required this.borderRadius,
  });

  @override
  State<_LoopingVideoPlayer> createState() => _LoopingVideoPlayerState();
}

class _LoopingVideoPlayerState extends State<_LoopingVideoPlayer>
    with AutomaticKeepAliveClientMixin {
  late final VideoPlayerController _controller;
  late final Future<void> _initializeVideo;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.videoPath.startsWith('http')
            ? VideoPlayerController.network(widget.videoPath)
            : VideoPlayerController.asset(widget.videoPath);

    _initializeVideo = _controller.initialize().then((_) {
      _controller
        ..setLooping(true)
        ..setVolume(0)
        ..play();
      if (mounted) setState(() {}); // refresh to show video
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: _initializeVideo,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            _controller.value.isInitialized) {
          final size = _controller.value.size;
          return FittedBox(
            fit: widget.fit,
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: VideoPlayer(_controller),
            ),
          );
        }
        // Shimmer placeholder while loading
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: widget.borderRadius,
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
