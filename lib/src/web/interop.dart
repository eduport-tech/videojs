
library videojs;
import 'dart:js_interop' ;

@JS()
@staticInterop
class Options {
  // Must have an unnamed factory constructor with named arguments.
  external  factory Options(JSArray  playbackRates,Plugins  plugins);
}


@JS()
@staticInterop
class Plugins {
  // Must have an unnamed factory constructor with named arguments.
  external factory Plugins(Hotkeys hotkeys);
}

@JS()
@staticInterop
class Hotkeys {
  // Must have an unnamed factory constructor with named arguments.
  external factory Hotkeys(
      double volumeStep, int seekStep, bool enableModifiersForNumbers);
}




extension type Videojs._(JSObject _) implements JSObject {
     external factory Videojs(String id, Options options);
     external static Videojs? getPlayer(String id);
  external void src(
    String src,
    String type,
  );
  external void play();
  external void pause();

  external double duration();
  external bool isDisposed();
  external bool isFullscreen();

  external void playbackRates(JSArray rates);

  external double? currentTime([int? time]);

  external void on(JSString event, JSFunction callback);

  external void dispose();

  external void httpSourceSelector();

  external bool paused();
}


// @JS()
// class Videojs {
  // external factory Videojs(String id, Options options);

  // external static Videojs? getPlayer(String id);
  // external void src(
  //   String src,
  //   String type,
  // );
  // external void play();
  // external void pause();

  // external double duration();
  // external bool isDisposed();
  // external bool isFullscreen();

  // external void playbackRates(List<double> rates);

  // external double? currentTime([int? time]);

  // external void on(String event, Function() callback);

  // external void dispose();

  // external void httpSourceSelector();

  // external bool paused();

// }

