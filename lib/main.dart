import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  // Preserve the splash screen until initialization is complete.
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Q Jobs',
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
    initialization();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Optionally handle loading progress updates here
          },
          onPageStarted: (String url) {
            // Optionally handle when a page starts loading
          },
          onPageFinished: (String url) {
            // Optionally handle when a page finishes loading
          },
          onWebResourceError: (WebResourceError error) {
            // Handle errors while loading resources
          },
          onNavigationRequest: (NavigationRequest request) {
            // Restrict navigation to your domain only
            if (!request.url.startsWith('https://qjobsbd.com')) {
              return NavigationDecision.prevent; // Block external URLs
            }
            return NavigationDecision.navigate; // Allow navigation within qjobsbd.com
          },
        ),
      )
      ..loadRequest(Uri.parse('https://qjobsbd.com')); // Load your website
  }

  // Initialization logic while showing the splash screen
  void initialization() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulated delay for initialization
    FlutterNativeSplash.remove(); // Remove splash screen after initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Q Jobs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _controller.reload(); // Reload the WebView
            },
          ),
        ],
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
