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

 void druck() {

 }

  @override
  void initState() {
    super.initState();
    controller = WebViewController()..setNavigationDelegate(NavigationDelegate(
      onNavigationRequest: (navigationRequest) {
        
        final Uri url = Uri.parse(navigationRequest.url);
        if (count1 >= 0) {
            setState(() {
              start = url.toString().substring(url.toString().lastIndexOf('/') + 1);
            });
          }
          // WebView provides your app with a NavigationDelegate, which enables your app to track and control the page navigation of the WebView widget. When a navigation is initiated by the WebView, for example when a user clicks on a link, the NavigationDelegate is called. The NavigationDelegate callback can be used to control whether the WebView proceeds with the navigation.
          count1++;
          
          
          return NavigationDecision.navigate;
        },
    ))..loadRequest(
        Uri.parse('https://de.wikipedia.org/wiki/Special:Random'),
      );
      controller2 = WebViewController()..setNavigationDelegate(NavigationDelegate(
      onNavigationRequest: (navigationRequest) {
          final Uri url = Uri.parse(navigationRequest.url);
        if (count2 >= 0) {
            setState(() {
              goal = url.toString().substring(url.toString().lastIndexOf('/') + 1);
            });
          }
          // WebView provides your app with a NavigationDelegate, which enables your app to track and control the page navigation of the WebView widget. When a navigation is initiated by the WebView, for example when a user clicks on a link, the NavigationDelegate is called. The NavigationDelegate callback can be used to control whether the WebView proceeds with the navigation.
          count2++;
          return NavigationDecision.navigate;
        },
    ))..loadRequest(
        Uri.parse('https://de.wikipedia.org/wiki/Special:Random'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
          },
          
          child: Text('Goal: $goal')),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}