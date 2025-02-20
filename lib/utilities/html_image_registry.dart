import 'dart:html' as html;
import 'dart:ui_web' as ui_web;


void registerImageElement() {
  ui_web.platformViewRegistry.registerViewFactory(
    'image-element',
    (int viewId) {
      final image = html.ImageElement()
        ..id = 'customImage'
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.objectFit = 'fill'
        ..style.display = 'block'
        ..style.margin = 'auto';
      return image;
    },
  );
}
