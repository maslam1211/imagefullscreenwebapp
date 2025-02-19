import 'dart:js' as js;


class FullscreenService {
  static void toggleFullscreen() {
    js.context.callMethod('eval', [
      '''
      if (!document.fullscreenElement) {
        document.documentElement.requestFullscreen();
      } else {
        if (document.exitFullscreen) {
          document.exitFullscreen();
        }
      }
      '''
    ]);
  }

  static void enterFullscreen() {
    js.context.callMethod('eval', ['document.documentElement.requestFullscreen();']);
  }

  static void exitFullscreen() {
    js.context.callMethod('eval', ['document.exitFullscreen();']);
  }
}
