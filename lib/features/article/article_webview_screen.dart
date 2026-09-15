import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/utils/ui_helpers.dart';

/// Membuka artikel edukasi. Hanya tautan https yang boleh dimuat.
class ArticleWebViewScreen extends StatefulWidget {
  const ArticleWebViewScreen({super.key, required this.url});

  final String url;

  @override
  State<ArticleWebViewScreen> createState() => _ArticleWebViewScreenState();
}

class _ArticleWebViewScreenState extends State<ArticleWebViewScreen> {
  late final WebViewController _controller;
  int _progress = 0;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            if (mounted) setState(() => _progress = progress);
          },
          onNavigationRequest: (request) {
            if (request.url.startsWith('https://')) return NavigationDecision.navigate;
            showSnack(context, 'Tautan tidak aman diblokir');
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  Future<void> _onBackPressed(bool didPop, Object? result) async {
    if (didPop) return;
    final navigator = Navigator.of(context);
    if (await _controller.canGoBack()) {
      await _controller.goBack();
    } else {
      navigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope<Object?>(
      canPop: false,
      onPopInvokedWithResult: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(title: const Text('Edukasi')),
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_progress < 100) LinearProgressIndicator(value: _progress / 100),
          ],
        ),
      ),
    );
  }
}
