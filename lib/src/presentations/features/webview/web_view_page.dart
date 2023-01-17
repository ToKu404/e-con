import 'dart:convert';

import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/services/api_service.dart';
import 'package:e_con/core/services/webview_service.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_loading.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController controller;
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Palette.background)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress < 100) {
              isLoading.value = true;
            } else {
              isLoading.value = false;
            }
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(WebViewService.url));
      
    // final String basicAuth =
    //     "Basic ${base64.encode(utf8.encode('N011171052:N011171052'))}";

    // controller.loadRequest(
    //   Uri.parse('${ApiService.baseUrlCPL}/login'),
    //   method: LoadRequestMethod.post,
    //   headers: {
    //     "Authorization": basicAuth,
    //     'Content-Type': 'application/json',
    //     "Access-Control-Allow-Origin": "*",
    //   },
    // );
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (await controller.canGoBack()) {
      setState(() {
        controller.goBack();
      });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        body: SafeArea(
            child: ValueListenableBuilder(
                valueListenable: isLoading,
                builder: (context, state, _) {
                  return Stack(
                    children: [
                      WebViewWidget(controller: controller),
                      Positioned(
                        bottom: 8,
                        left: 16,
                        child: ElevatedButton.icon(
                          style: IconButton.styleFrom(
                            backgroundColor: Palette.onPrimary.withOpacity(.5),
                          ),
                          label: Text(
                            'Keluar',
                            style: TextStyle(color: Palette.background),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: Palette.background,
                          ),
                        ),
                      ),
                      if (state) EconLoading()
                    ],
                  );
                })),
      ),
    );
  }
}
