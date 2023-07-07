import 'package:fitlife/core/models/video/video_model.dart';
import 'package:fitlife/injection.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../services/video_service.dart';

class VideoProvider extends ChangeNotifier {
  List<Video>? _videos;
  List<Video>? get videos => _videos;

  final videoService = locator<VideoService>();

  /// Property to check mounted before notify
  bool isDisposed = false;

  /// Event handling
  bool _onSearch = false;
  bool get onSearch => _onSearch;

  /// Instance provider
  static VideoProvider instance(BuildContext context) =>
      Provider.of(context, listen: false);

  Future<void> getVideos() async {
    await Future.delayed(const Duration(milliseconds: 100));
    setOnSearch(true);
    try {
      final result = await videoService.getVideos();

      _videos = result.data;
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
      _videos = [];
    }
    setOnSearch(false);
  }

  /// Search videos by keywords

  void clearVideos() {
    _videos = null;
    notifyListeners();
  }

  /// Set event search
  void setOnSearch(bool value) {
    _onSearch = value;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (!isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
