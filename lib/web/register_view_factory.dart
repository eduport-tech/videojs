import 'dart:developer';
import 'dart:js_interop';
import 'dart:ui' as ui;
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:web/web.dart' as html;
import 'package:video_js_themed/src/view_factory_plugin.dart';
import 'package:video_js_themed/src/web/video_js_scripts.dart';

class ViewFactoryWeb extends ViewFactoryPlugin {
  static final ViewFactoryWeb platform = ViewFactoryWeb._();

  static void registerWith(Registrar registrar) {
    ViewFactoryPlugin.platform = platform;
  }

  ViewFactoryWeb._();

  @override
  void registerViewFactory({
    required String elementId,
    required String playerId,
    required String theme,
    required double width,
    required double height,
    required bool qualitySelector,
    required Map<String, dynamic> videoJsOptions,
  }) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(elementId, (int id) {
      log('8989 player id $playerId');
      final html.Element htmlElement = html.HTMLDivElement()
        ..id = 'div$elementId'
        ..style.width = '100%'
        ..style.height = '100%';

      htmlElement.appendChild(html.HTMLVideoElement()
        ..id = playerId
        // ..style.minHeight = '100%'
        // ..style.minHeight = '100%'
        // ..style.width = '100%'
        // ..style.height = 'auto'
        ..className = 'video-js $theme'
        ..width = width.toInt()
        ..height = height.toInt());

      htmlElement.appendChild(html.HTMLScriptElement()
        ..innerHTML = VideoJsScripts().videojsCode(
          playerId,
          videoJsOptions,
          qualitySelector: qualitySelector,
        ));
      return htmlElement;
    });
  }
}
