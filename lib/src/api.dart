

class VideoJsPlayerApi {
  VideoJsPlayerApi();

  Future<void> initialize() async {}

  Future<void> create() async {}

  Future<void> dispose() async {}

  Future<void> setLooping() async {}

  Future<void> setVolume() async {}

  Future<void> setPlaybackSpeed() async {}

  Future<void> play() async {}

  Future<int> position() async {
    return 0;
  }

  Future<void> seekTo() async {}

  Future<void> pause() async {}

  Future<void> setMixWithOthers() async {}
}
