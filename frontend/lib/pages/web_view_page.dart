import 'package:flutter/material.dart';
import 'package:tnp_scanner/manager/cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key, this.url});

  final String? url;

  static Route route({String? url}) => MaterialPageRoute<void>(
      builder: (_) => WebViewPage(
            url: url,
          ));

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _webViewController;
  final manager = WebViewCookieManager();

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController();
    _configureCookies();
  }

  void _configureCookies() async {
    await _webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    _loadUrl();
  }

  void _loadUrl() async {
    if (widget.url != null) {
      final String? cookie = CookieManager.getCookie();
      if (cookie != null) {
        final List<String> keys = cookie.split("=");
        await manager.setCookie(
          WebViewCookie(
            name: keys.first,
            value: keys.last,
            domain: 'tp.bitmesra.co.in',
          ),
        );
        await _webViewController.loadRequest(Uri.parse(widget.url!));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: WebViewWidget(controller: _webViewController),
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              _webViewController.reload();
            },
            icon: const Icon(
              Icons.replay,
              color: Colors.white,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              if (await _webViewController.canGoBack()) {
                await _webViewController.goBack();
              } else {
                messenger.showSnackBar(
                  const SnackBar(content: Text('No page to go back to.')),
                );
                return;
              }
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              if (await _webViewController.canGoForward()) {
                await _webViewController.goForward();
              } else {
                messenger.showSnackBar(
                  const SnackBar(content: Text('No forward history item')),
                );
                return;
              }
            },
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
