import 'package:flutter/services.dart';
import 'package:spritewidget/spritewidget.dart';

const _pathFireworkParticle = 'assets/firework-particle.png';

class GameAssets {

  SpriteTexture get textureFirework => _textureFirework;
  SpriteTexture _textureFirework;

  ImageMap _images;

  Future<void> load() async {
    // Load a font and setup the points builder
    ByteData fontData = await rootBundle.load('assets/Roboto-Black.ttf');

    // Load all image assets
    _images = ImageMap(rootBundle);
    await _images.load([
      _pathFireworkParticle,
    ]);

    _textureFirework = SpriteTexture(_images[_pathFireworkParticle]);
  }
}