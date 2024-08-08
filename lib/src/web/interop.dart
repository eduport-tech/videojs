
library videojs;
import 'package:js/js.dart' as js;
import 'dart:js_interop';

@js.JS()
@js.anonymous
class Options {
  // Must have an unnamed factory constructor with named arguments.
  external factory Options({List<double> playbackRates,Plugins plugins});
}

@js.JS()
@js.anonymous
class Plugins {
  // Must have an unnamed factory constructor with named arguments.
  external factory Plugins({Hotkeys hotkeys});
}

@js.JS()
@js.anonymous
class Hotkeys {
  // Must have an unnamed factory constructor with named arguments.
  external factory Hotkeys(
      {double volumeStep, int seekStep, bool enableModifiersForNumbers});
}

@js.JS('videojs')
class Videojs {
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

  external void playbackRates(List<double> rates);

  external double? currentTime([int? time]);

  external void on(String event, Function() callback);

  external void dispose();

  external void httpSourceSelector();

  external bool paused();

}

