import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:video_js_themed/src/models/videojs_options.dart';
import 'package:video_js_themed/src/web/interop.dart';
import 'package:video_js_themed/src/web/video_js_scripts.dart';
import 'package:video_js_themed/src/web/video_results.dart';
import 'package:web/web.dart' as web; 
import 'dart:js_interop';
class VideoJsController {
  final String playerId;
  final VideoJsOptions? videoJsOptions;
  final bool qualitySelector;

  VideoJsController(
    this.playerId, {
    this.videoJsOptions,
    this.qualitySelector = false,
  });

  /// This function is for initial a video.js instance with options
  videoJs(Function(String) onReady, {VideoJsOptions? videoJsOptions}) {
    final web.Element scriptElement = web.document.createElement('script');
    scriptElement..id =
     "videojs"
      ..innerHTML =
          VideoJsScripts().videojsCode(playerId, videoJsOptions!.toJson()).toJS;
    web.Element? ele =web.document.querySelector("#videojs");
    if (web.document.querySelector("#videojs") != null) {
      ele!.remove();
    }
    web.document.querySelector('body')!.children.add(scriptElement);
    VideoJsResults().listenToValueFromJs(playerId, 'onReady', onReady);
  }

  /// to set video source by type
  /// [type] can be video/mp4, video/webm, application/x-mpegURL (for hls videos), ...
  setSRC(String src, {required String type}) {
    final web.Element scriptElement = web.document.createElement('script')
      ..id = "setSRC"
      ..innerHTML = VideoJsScripts().setSRCCode(playerId, src, type).toJS;
    web.Element? ele = web.document.querySelector("#setSRC");
    if (web.document.querySelector("#setSRC") != null) {
      ele!.remove();
    }
    web.document.querySelector('body')!.children.add(scriptElement);
  }

  /// To get volume of video
  getVolume(Function(String) onVolumeReceive) {
    final web.Element scriptElement = web.document.createElement('script')
      ..id = "getVolume"
      ..innerHTML = VideoJsScripts().getVolume(playerId).toJS;
    web.Element? ele = web.document.querySelector("#getVolume");
    if (web.document.querySelector("#getVolume") != null) {
      ele!.remove();
    }
    web.document.querySelector('body')!.children.add(scriptElement);
    VideoJsResults()
        .listenToValueFromJs(playerId, 'getVolume', onVolumeReceive);
  }

  /// set volume to video player
  setVolume(String volume) {
    final web.Element scriptElement = web.document.createElement('script')
      ..id = "setVolume"
      ..innerHTML = VideoJsScripts().setVolume(playerId, volume).toJS;
    web.Element? ele = web.document.querySelector("#setVolume");
    if (web.document.querySelector("#setVolume") != null) {
      ele!.remove();
    }
    web.document.querySelector('body')!.children.add(scriptElement);
  }

  /// toggle mute in video player. if player is mute, makes unmute and if is unmute makes mute
  toggleMute() {
    final web.Element scriptElement = web.document.createElement('script')
      ..id = "toggleMute"
      ..innerHTML = VideoJsScripts().toggleMute(playerId).toJS;
    web.Element? ele = web.document.querySelector("#toggleMute");
    if (web.document.querySelector("#toggleMute") != null) {
      ele!.remove();
    }
    web.document.querySelector('body')!.children.add(scriptElement);
  }

  /// this function is for check video player mute status
  isMute(Function(String) onMuteStatus) {
    final web.Element scriptElement = web.document.createElement('script')
      ..id = "isMute"
      ..innerHTML = VideoJsScripts().isMute(playerId).toJS;
    web.Element? ele = web.document.querySelector("#isMute");
    if (web.document.querySelector("#isMute") != null) {
      ele!.remove();
    }
    web.document.querySelector('body')!.children.add(scriptElement);
    VideoJsResults().listenToValueFromJs(playerId, 'isMute', onMuteStatus);
  }

  /// toggle full screen in video player. this function is different with requestFullScreen,
  /// this function just change type
  toggleFullScreen() {
    final web.Element scriptElement = web.document.createElement('script')
      ..id = "toggleFullScreen"
      ..innerHTML = VideoJsScripts().toggleFullScreenMode(playerId).toJS;
    web.Element? ele = web.document.querySelector("#toggleFullScreen");
    if (web.document.querySelector("#toggleFullScreen") != null) {
      ele!.remove();
    }
    web.document.querySelector('body')!.children.add(scriptElement);
  }

  /// this function is for check video player full screen status
  isFullScreen(Function(String) onFullScreenStatus) {
    final web.Element scriptElement = web.document.createElement('script')
      ..id = "isFullScreen"
      ..innerHTML = VideoJsScripts().isFullScreen(playerId).toJS;
    web.Element? ele = web.document.querySelector("#isFullScreen");
    if (web.document.querySelector("#isFullScreen") != null) {
      ele!.remove();
    }
    web.document.querySelector('body')!.children.add(scriptElement);
    VideoJsResults()
        .listenToValueFromJs(playerId, 'isFull', onFullScreenStatus);
  }

  /// To change player to full screen mode
  requestFullScreen() {
    final web.Element scriptElement = web.document.createElement('script')
      ..id = "requestFullScreen"
      ..innerHTML = VideoJsScripts().requestFullscreen(playerId).toJS;
    web.Element? ele = web.document.querySelector("#requestFullScreen");
    if (web.document.querySelector("#requestFullScreen") != null) {
      ele!.remove();
    }
    web.document.querySelector('body')!.children.add(scriptElement);
  }

  /// To exit from full screen mode
  exitFullScreen() {
    final web.Element scriptElement = web.document.createElement('script')
      ..id = "exitFullScreen"
      ..innerHTML = VideoJsScripts().exitFullscreen(playerId).toJS;
    web.Element? ele = web.document.querySelector("#exitFullScreen");
    if (web.document.querySelector("#exitFullScreen") != null) {
      ele!.remove();
    }
    web.document.querySelector('body')!.children.add(scriptElement);
  }

  /// play video
  play() {
    final web.Element scriptElement = web.document.createElement('script')
      ..id = "play"
      ..innerHTML = VideoJsScripts().play(playerId).toJS;
    web.Element? ele = web.document.querySelector("#play");
    if (web.document.querySelector("#play") != null) {
      ele!.remove();
    }
    web.document.querySelector('body')!.children.add(scriptElement);
  }

  /// pause video
  pause() {
    final web.Element scriptElement = web.document.createElement('script')
      ..id = "pause"
      ..innerHTML = VideoJsScripts().pause(playerId).toJS;
    web.Element? ele = web.document.querySelector("#pause");
    if (web.document.querySelector("#pause") != null) {
      ele!.remove();
    }
    web.document.querySelector('body')!.children.add(scriptElement);
  }

  /// To check video player pause status
  isPaused(Function(String) onPauseStatus) {
    final web.Element scriptElement = web.document.createElement('script')
      ..id = "isPaused"
      ..innerHTML = VideoJsScripts().isPause(playerId).toJS;
    web.Element? ele = web.document.querySelector("#isPaused");
    if (web.document.querySelector("#isPaused") != null) {
      ele!.remove();
    }
    web.document.querySelector('body')!.children.add(scriptElement);
    VideoJsResults().listenToValueFromJs(playerId, 'isPaused', onPauseStatus);
  }

  /// To get video's current playing time in seconds
  currentTime(Function(String) onCurrentTime) {
    final web.Element scriptElement = web.document.createElement('script')
      ..id = "currentTime"
      ..innerHTML = VideoJsScripts().getCurrentTime(playerId).toJS;
    web.Element? ele = web.document.querySelector("#currentTime");
    if (web.document.querySelector("#currentTime") != null) {
      ele!.remove();
    }
    web.document.querySelector('body')!.children.add(scriptElement);
    VideoJsResults().listenToValueFromJs(playerId, 'getCurrent', onCurrentTime);
  }

  /// Set video
  setCurrentTime(String currentTime) {
    final web.Element scriptElement = web.document.createElement('script')
      ..id = "setCurrentTime"
      ..innerHTML = VideoJsScripts().setCurrentTime(playerId, currentTime).toJS;
    web.Element? ele = web.document.querySelector("#setCurrentTime");
    if (web.document.querySelector("#setCurrentTime") != null) {
      ele!.remove();
    }
    web.document.querySelector('body')!.children.add(scriptElement);
  }

  /// Video whole time in seconds
  durationTime(Function(String) onDurationTime) {
    final web.Element scriptElement = web.document.createElement('script')
      ..id = "durationTime"
      ..innerHTML = VideoJsScripts().duration(playerId).toJS;
    web.Element? ele = web.document.querySelector("#durationTime");
    if (web.document.querySelector("#durationTime") != null) {
      ele!.remove();
    }
    web.document.querySelector('body')!.children.add(scriptElement);
    VideoJsResults()
        .listenToValueFromJs(playerId, 'getDuration', onDurationTime);
  }

  /// Video remain time in seconds
  remainTime(Function(String) onRemainTime) {
    final web.Element scriptElement = web.document.createElement('script')
      ..id = "onRemainTime"
      ..innerHTML = VideoJsScripts().remainingTime(playerId).toJS;
    web.Element? ele = web.document.querySelector("#onRemainTime");
    if (web.document.querySelector("#onRemainTime") != null) {
      ele!.remove();
    }
    web.document.querySelector('body')!.children.add(scriptElement);
    VideoJsResults()
        .listenToValueFromJs(playerId, 'getRemaining', onRemainTime);
  }

  /// Video buffered ( downloaded ) percent
  bufferPercent(Function(String) onBufferPercent) {
    final web.Element scriptElement = web.document.createElement('script')
      ..id = "bufferPercent"
      ..innerHTML = VideoJsScripts().bufferedPercent(playerId).toJS;
    web.Element? ele = web.document.querySelector("#bufferPercent");
    if (web.document.querySelector("#bufferPercent") != null) {
      ele!.remove();
    }
    web.document.querySelector('body')!.children.add(scriptElement);
    VideoJsResults()
        .listenToValueFromJs(playerId, 'getBuffered', onBufferPercent);
  }

  /// Set Video poster/thumbnail
  setPoster(String poster) {
    final web.Element scriptElement = web.document.createElement('script')
      ..id = "setPoster"
      ..innerHTML = VideoJsScripts().setPoster(playerId, poster).toJS;
    web.Element? ele = web.document.querySelector("#setPoster");
    if (web.document.querySelector("#setPoster") != null) {
      ele!.remove();
    }
    web.document.querySelector('body')!.children.add(scriptElement);
  }

  /// Get Video poster/thumbnail
  getPoster(Function(String) onPosterGet) {
    final web.Element scriptElement = web.document.createElement('script')
      ..id = "getPoster"
      ..innerHTML = VideoJsScripts().getPoster(playerId).toJS;
    web.Element? ele = web.document.querySelector("#getPoster");
    if (web.document.querySelector("#getPoster") != null) {
      ele!.remove();
    }
    web.document.querySelector('body')!.children.add(scriptElement);
    VideoJsResults().listenToValueFromJs(playerId, 'getPoster', onPosterGet);
  }

  /// Get Video poster/thumbnail
  onPlayerReady(Function(String) onReady) {
    final web.Element scriptElement = web.document.createElement('script')
      ..id = "onPlayerReady"
      ..innerHTML = VideoJsScripts().getPoster(playerId).toJS;
    web.Element? ele = web.document.querySelector("#onPlayerReady");
    if (web.document.querySelector("#onPlayerReady") != null) {
      ele!.remove();
    }
    web.document.querySelector('body')!.children.add(scriptElement);
    VideoJsResults().listenToValueFromJs(playerId, 'onReady', onReady);
  }

  /// Add callback to be triggered on playback start
  onPlay(Function(String) onPlay) {
    final web.Element scriptElement = web.document.createElement('script')
      ..id = "onPlay"
      ..innerHTML = VideoJsScripts().onPlay(playerId).toJS;
    web.Element? ele = web.document.querySelector("#onPlay");
    if (web.document.querySelector("#onPlay") != null) {
      ele!.remove();
    }
    web.document.querySelector('body')!.children.add(scriptElement);
    VideoJsResults().listenToValueFromJs(playerId, 'onPlay', onPlay);
  }

  /// Add callback to be triggered on playback end
  onEnd(Function(String) onEnd) {
    final web.Element scriptElement = web.document.createElement('script')
      ..id = "onEnd"
      ..innerHTML = VideoJsScripts().onEnd(playerId).toJS;
    web.Element? ele = web.document.querySelector("#onEnd");
    if (web.document.querySelector("#onEnd") != null) {
      ele!.remove();
    }
    web.document.querySelector('body')!.children.add(scriptElement);
    VideoJsResults().listenToValueFromJs(playerId, 'onEnd', onEnd);
  }

  /// This method is available on all Video.js players and components.
  /// It is the only supported method of removing a Video.js player from both the DOM and memory.
  dispose() {
    final web.Element scriptElement = web.document.createElement('script')
      ..id = "dispose"
      ..innerHTML = VideoJsScripts().dispose(playerId).toJS;
    web.Element? ele = web.document.querySelector("#dispose");
    if (web.document.querySelector("#dispose") != null) {
      ele!.remove();
    }
    web.document.querySelector('body')!.children.add(scriptElement);

    if (kDebugMode) {
      print('VideoJsController disposed');
    }
  }

  ///-------------v2----------------------------

  int totalDurationInSec() {
    final player = Videojs.getPlayer(playerId);
    double duration = (player?.duration() ?? 0);
    log('duration is $duration');

    return (duration.isNaN || duration.isInfinite) ? 0 : duration.toInt();
  }

  Future<int> currentPositionInSec() async {
    final player = Videojs.getPlayer(playerId);

    double? currentTime = player?.currentTime();

    int duration = (currentTime ?? 0).toInt();

    return duration.isNaN ? 0 : duration;
  }

  ///indicates the player is in full screen or not true -> fullScreen , false ->not in fullScreen
  Future<bool> isFullscreen() async {
    final player = Videojs.getPlayer(playerId);
    return player?.isFullscreen() ?? false;
  }

  Future<void> setTime(int timeInSec) async {
    final player = Videojs.getPlayer(playerId);

    player?.currentTime(timeInSec);
  }

  onEvent() {

    final player = Videojs.getPlayer(playerId);
    // player?.on('play',allowInterop((){

    // }));
  }
}
