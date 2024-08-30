import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const WebViewApp(),
    ),
  );
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;
  late final WebViewController controller2;
  String start = "";
  String goal = "";
  int count1 = -1;
  int count2 = -1;

  // Initialize controllers in initState
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (navigationRequest) {
          final Uri url = Uri.parse(navigationRequest.url);
          if (count1 >= 0) {
            setState(() {
              start = url.toString().substring(url.toString().lastIndexOf('/') + 1);
            });
          }
          count1++;
          return NavigationDecision.navigate;
        },
      ));

    controller2 = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (navigationRequest) {
          final Uri url = Uri.parse(navigationRequest.url);
          if (count2 >= 0) {
            setState(() {
              goal = url.toString().substring(url.toString().lastIndexOf('/') + 1);
            });
          }
          count2++;
          return NavigationDecision.navigate;
        },
      ));

    // Load initial pages
    loadNewPages();
  }

  // Function to load new random pages
  void loadNewPages() {
    controller.loadRequest(Uri.parse('https://de.wikipedia.org/wiki/Special:Random'));
    controller2.loadRequest(Uri.parse('https://de.wikipedia.org/wiki/Special:Random'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () {
              controller.reload();
              controller2.reload();
              loadNewPages();
            },
            child: Text("New game"),
          ),
        ],
        title: GestureDetector(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('$goal', style: TextStyle(fontSize: 15),),
            ],
          ),

        ),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
