import 'dart:async';
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
    final web.HTMLScriptElement scriptElement = web.HTMLScriptElement();
    scriptElement..id =
     "videojs"
      ..text =
          VideoJsScripts().videojsCode(playerId, videoJsOptions);
    web.Element? ele =web.document.querySelector("#videojs");
    if (web.document.querySelector("#videojs") != null) {
      ele!.remove();
    }
    web.document.querySelector('body')!.appendChild(scriptElement);
    VideoJsResults().listenToValueFromJs(playerId, 'onReady', onReady);
  }

  /// to set video source by type
  /// [type] can be video/mp4, video/webm, application/x-mpegURL (for hls videos), ...
  setSRC(String src, {required String type}) {
    final web.HTMLScriptElement scriptElement = web.HTMLScriptElement()
      ..id = "setSRC"
      ..text = VideoJsScripts().setSRCCode(playerId, src, type);
    web.Element? ele = web.document.querySelector("#setSRC");
    if (web.document.querySelector("#setSRC") != null) {
      ele!.remove();
    }
    web.document.querySelector('body')!.appendChild(scriptElement);
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
    web.document.querySelector('body')!.appendChild(scriptElement);
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
    web.document.querySelector('body')!.appendChild(scriptElement);
  }

  /// toggle mute in video player. if player is mute, makes unmute and if is unmute makes mute
  toggleMute() {
    final web.HTMLScriptElement scriptElement = web.HTMLScriptElement()
      ..id = "toggleMute"
      ..text = VideoJsScripts().toggleMute(playerId);
    web.Element? ele = web.document.querySelector("#toggleMute");
    if (web.document.querySelector("#toggleMute") != null) {
      ele!.remove();
    }
    web.document.querySelector('body')!.append(scriptElement);
  }

  /// this function is for check video player mute status
  Future<bool> isMute() {
    final Completer<bool> completer = Completer<bool>();
    final web.HTMLScriptElement scriptElement = web.HTMLScriptElement()
      ..id = "isMute"
      ..text = VideoJsScripts().isMute(playerId);
    web.Element? ele = web.document.querySelector("#isMute");
    if (web.document.querySelector("#isMute") != null) {
      ele!.remove();
    }
    web.document.querySelector('body')!.appendChild(scriptElement);
    VideoJsResults().listenToValueFromJs(playerId, 'isMute', (String result) {
      if (!completer.isCompleted) {
        completer.complete(result == 'true');
      }
    });
    return completer.future;
  }

  /// toggle full screen in video player. this function is different with requestFullScreen,
  /// this function just change type
  toggleFullScreen() {
    final web.HTMLScriptElement scriptElement = web.HTMLScriptElement()
      ..id = "toggleFullScreen"
      ..text = VideoJsScripts().toggleFullScreenMode(playerId);
    web.Element? ele = web.document.querySelector("#toggleFullScreen");
    if (ele != null) {
      ele.remove();
    }
    web.document.querySelector('body')!.appendChild(scriptElement);
  }

  /// this function is for check video player full screen status
  isFullScreen(Function(String) onFullScreenStatus) {
    final web.HTMLScriptElement scriptElement = web.HTMLScriptElement()
      ..id = "isFullScreen"
      ..text = VideoJsScripts().isFullScreen(playerId);
    web.Element? ele = web.document.querySelector("#isFullScreen");
    if (ele != null) {
      ele.remove();
    }
    web.document.querySelector('body')!.appendChild(scriptElement);
    VideoJsResults()
        .listenToValueFromJs(playerId, 'isFull', onFullScreenStatus);
  }

  /// To change player to full screen mode
  requestFullScreen() {
    final web.HTMLScriptElement scriptElement = web.HTMLScriptElement()
      ..id = "requestFullScreen"
      ..text = VideoJsScripts().requestFullscreen(playerId);
    web.Element? ele = web.document.querySelector("#requestFullScreen");
    if (ele != null) {
      ele.remove();
    }
    web.document.querySelector('body')!.appendChild(scriptElement);
  }

  /// To exit from full screen mode
  exitFullScreen() {
    final web.HTMLScriptElement scriptElement = web.HTMLScriptElement()
      ..id = "exitFullScreen"
      ..text = VideoJsScripts().exitFullscreen(playerId);
    web.Element? ele = web.document.querySelector("#exitFullScreen");
    if (ele != null) {
      ele.remove();
    }
    web.document.querySelector('body')!.appendChild(scriptElement);
  }

  /// play video
 play() {
  final web.HTMLScriptElement scriptElement = web.HTMLScriptElement()
    ..id = "play"
    ..text = VideoJsScripts().play(playerId);

  
  web.Element? ele = web.document.querySelector("#play");
  if (ele != null) {
    ele.remove();
  }
  
  web.document.querySelector('body')!.appendChild(scriptElement);
}

  /// pause video
  pause() {
    final web.HTMLScriptElement scriptElement =  web.HTMLScriptElement()
      ..id = "pause"
      ..text = VideoJsScripts().pause(playerId);
    web.Element? ele = web.document.querySelector("#pause");
    if (ele != null) {
      ele.remove();
    }
    web.document.querySelector('body')!.appendChild(scriptElement);
  }


  Future<String> isPaused() {
  final Completer<String> completer = Completer<String>();
  
  final web.HTMLScriptElement scriptElement = web.HTMLScriptElement()
    ..id = "isPaused"
    ..text = VideoJsScripts().isPause(playerId);
  
  web.Element? ele = web.document.querySelector("#isPaused");
  if (ele != null) {
    ele.remove();
  }
  
  web.document.querySelector('body')!.appendChild(scriptElement);
  
  VideoJsResults().listenToValueFromJs(playerId, 'isPaused', (String result) {
    if (!completer.isCompleted) {
      completer.complete(result);
    }
  });
  
  return completer.future;
}

  /// To get video's current playing time in seconds
 Future<int> currentTime() {
       final Completer<int> completer = Completer<int>();
    final web.HTMLScriptElement scriptElement = web.HTMLScriptElement()
      ..id = "currentTime"
      ..text = VideoJsScripts().getCurrentTime(playerId);
    web.Element? ele = web.document.querySelector("#currentTime");
    if (ele != null) {
      ele.remove();
    }
    web.document.querySelector('body')!.appendChild(scriptElement);
    VideoJsResults().listenToValueFromJs(playerId, 'getCurrent', (String result) {
      if (!completer.isCompleted) {
        completer.complete((double.tryParse(result)??0).toInt());
      }
    });
    return completer.future;
  }

  /// Set video
  setCurrentTime(String currentTime) {
    final web.HTMLScriptElement scriptElement = web.HTMLScriptElement()
      ..id = "setCurrentTime"
      ..text = VideoJsScripts().setCurrentTime(playerId, currentTime);
    web.Element? ele = web.document.querySelector("#setCurrentTime");
    if (ele != null) {
      ele.remove();
    }
    web.document.querySelector('body')!.appendChild(scriptElement);
  }

  /// Video whole time in seconds
  Future<int> durationTime() {
    final Completer<int> completer = Completer<int>();
    final web.HTMLScriptElement scriptElement = web.HTMLScriptElement()
      ..id = "durationTime"
      ..text = VideoJsScripts().duration(playerId);
    web.Element? ele = web.document.querySelector("#durationTime");
    if (ele != null) {
      ele.remove();
    }
    web.document.querySelector('body')!.appendChild(scriptElement);
    VideoJsResults()
        .listenToValueFromJs(playerId, 'getDuration', (String result) {
          if (!completer.isCompleted) {
            completer.complete((double.tryParse(result)??0).toInt());
          }
        });
    return completer.future;
  }

  /// Video remain time in seconds
  Future<int> remainTime() {
    final Completer<int> completer = Completer<int>();
    final web.HTMLScriptElement scriptElement = web.HTMLScriptElement()
      ..id = "onRemainTime"
      ..text = VideoJsScripts().remainingTime(playerId);
    web.Element? ele = web.document.querySelector("#onRemainTime");
    if (ele != null) {
      ele.remove();
    }
    web.document.querySelector('body')!.appendChild(scriptElement);
    VideoJsResults()
        .listenToValueFromJs(playerId, 'getRemaining', (String result) {
          if (!completer.isCompleted) {
            completer.complete((double.tryParse(result)??0).toInt());
          }
        });
    return completer.future;
  }

  /// Video buffered ( downloaded ) percent
  Future<double> bufferPercent() {
    final Completer<double> completer = Completer<double>();
    final web.HTMLScriptElement scriptElement = web.HTMLScriptElement()
      ..id = "bufferPercent"
      ..text = VideoJsScripts().bufferedPercent(playerId);
    web.Element? ele = web.document.querySelector("#bufferPercent");
    if (ele != null) {
      ele.remove();
    }
    web.document.querySelector('body')!.appendChild(scriptElement);
    VideoJsResults()
        .listenToValueFromJs(playerId, 'getBuffered', (String result) {
          if (!completer.isCompleted) {
            completer.complete((double.tryParse(result)??0));
          }
        });
    return completer.future;
  }

  /// Set Video poster/thumbnail
  setPoster(String poster) {
    final web.HTMLScriptElement scriptElement = web.HTMLScriptElement()
      ..id = "setPoster"
      ..text = VideoJsScripts().setPoster(playerId, poster);
    web.Element? ele = web.document.querySelector("#setPoster");
    if (ele != null) {
      ele.remove();
    }
    web.document.querySelector('body')!.appendChild(scriptElement);
  }

  /// Get Video poster/thumbnail
  getPoster(Function(String) onPosterGet) {
    final web.HTMLScriptElement scriptElement = web.HTMLScriptElement()
      ..id = "getPoster"
      ..text = VideoJsScripts().getPoster(playerId);
    web.Element? ele = web.document.querySelector("#getPoster");
    if (ele != null) {
      ele.remove();
    }
    web.document.querySelector('body')!.appendChild(scriptElement);
    VideoJsResults().listenToValueFromJs(playerId, 'getPoster', onPosterGet);
  }

  /// Get Video poster/thumbnail
  onPlayerReady(Function(String) onReady) {
    final web.HTMLScriptElement scriptElement = web.HTMLScriptElement()
      ..id = "onPlayerReady"
      ..text = VideoJsScripts().getPoster(playerId);
    web.Element? ele = web.document.querySelector("#onPlayerReady");
    if (ele != null) {
      ele.remove();
    }
    web.document.querySelector('body')!.appendChild(scriptElement);
    VideoJsResults().listenToValueFromJs(playerId, 'onReady', onReady);
  }

  /// Add callback to be triggered on playback start
  onPlay(Function(String) onPlay) {
    final web.HTMLScriptElement scriptElement = web.HTMLScriptElement()
      ..id = "onPlay"
      ..text = VideoJsScripts().onPlay(playerId);
    web.Element? ele = web.document.querySelector("#onPlay");
    if (ele != null) {
      ele.remove();
    }
    web.document.querySelector('body')!.appendChild(scriptElement);
    VideoJsResults().listenToValueFromJs(playerId, 'onPlay', onPlay);
  }

  /// Add callback to be triggered on playback end
  onEnd(Function(String) onEnd) {
    final web.HTMLScriptElement scriptElement = web.HTMLScriptElement()
      ..id = "onEnd"
      ..text = VideoJsScripts().onEnd(playerId);
    web.Element? ele = web.document.querySelector("#onEnd");
    if (ele != null) {
      ele.remove();
    }
    web.document.querySelector('body')!.appendChild(scriptElement);
    VideoJsResults().listenToValueFromJs(playerId, 'onEnd', onEnd);
  }

  /// This method is available on all Video.js players and components.
  /// It is the only supported method of removing a Video.js player from both the DOM and memory.
  dispose() {
    final web.HTMLScriptElement scriptElement = web.HTMLScriptElement()
      ..id = "dispose"
      ..text = VideoJsScripts().dispose(playerId);
    web.Element? ele = web.document.querySelector("#dispose");
    if (ele != null) {
      ele.remove();
    }
    web.document.querySelector('body')!.appendChild(scriptElement);

    if (kDebugMode) {
      print('VideoJsController disposed');
    }
  }



 

}
