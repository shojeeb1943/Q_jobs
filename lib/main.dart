import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JobsApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WebApp(),
    );
  }
}

class WebApp extends StatefulWidget {
  const WebApp({Key? key}) : super(key: key);

  @override
  _WebAppState createState() => _WebAppState();
}

class _WebAppState extends State<WebApp> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Handle progress updates
          },
          onPageStarted: (String url) {
            // Handle page start
          },
          onPageFinished: (String url) {
            // Handle page finish
          },
          onWebResourceError: (WebResourceError error) {
            // Handle web resource error
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://qjobsbd.com'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JobsApp'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _controller.reload();
            },
          ),
        ],
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
