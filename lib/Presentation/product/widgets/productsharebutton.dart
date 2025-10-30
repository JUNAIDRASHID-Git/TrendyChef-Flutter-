import 'dart:io' show Platform, File;
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_html/html.dart' as html;
import 'package:universal_html/js_util.dart' as js_util;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class ProductShareButton extends StatelessWidget {
  final String title;
  final String productUrl;
  final String imageUrl;
  final double price;
  final double weight;

  const ProductShareButton({
    super.key,
    required this.title,
    required this.productUrl,
    required this.imageUrl,
    required this.price,
    required this.weight,
  });

  String get shareText => '''
$title (${weight}kg)
Price: \$${price.toStringAsFixed(2)}

Check it out 👉 $productUrl
''';

  Future<void> _shareWeb() async {
    final nav = html.window.navigator;

    final shareData = js_util.newObject();
    js_util.setProperty(shareData, 'title', title);
    js_util.setProperty(shareData, 'text', shareText);
    js_util.setProperty(shareData, 'url', productUrl);

    try {
      final resp = await http.get(Uri.parse(imageUrl));
      if (resp.statusCode == 200) {
        final blob = html.Blob([resp.bodyBytes], 'image/jpeg');
        final file = html.File([blob], 'product.jpg', {'type': 'image/jpeg'});
        final files = [file];

        final canShareData = js_util.newObject();
        js_util.setProperty(canShareData, 'files', files);

        final canShare =
            js_util.callMethod(nav, 'canShare', [canShareData]) == true;

        if (canShare) {
          js_util.setProperty(shareData, 'files', files);
        }
      }
    } catch (_) {
      // Ignore image attach issues
    }

    try {
      await js_util.promiseToFuture(
        js_util.callMethod(nav, 'share', [shareData]),
      );
    } catch (e) {
      html.window.open(
        'https://api.whatsapp.com/send?text=${Uri.encodeComponent(shareText)}',
        '_blank',
      );
    }
  }

  Future<void> _shareMobile() async {
    try {
      final resp = await http.get(Uri.parse(imageUrl));
      if (resp.statusCode == 200) {
        final Uint8List bytes = resp.bodyBytes;
        final dir = await getTemporaryDirectory();
        final filePath = path.join(dir.path, 'product.jpg');
        final file = await File(filePath).writeAsBytes(bytes);

        await Share.shareXFiles([XFile(file.path)], text: shareText);
        return;
      }
    } catch (_) {
      // fallback to just text
    }

    await Share.share(shareText);
  }

  Future<void> _shareProduct() async {
    if (kIsWeb) {
      await _shareWeb();
    } else if (Platform.isAndroid || Platform.isIOS) {
      await _shareMobile();
    } else {
      // fallback
      await Share.share(shareText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _shareProduct,
      icon: const Icon(Icons.share),
      label: const Text("Share Product"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
    );
  }
}
