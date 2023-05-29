import 'dart:io';

import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/helpers/password_encrypt.dart';
import 'package:e_con/core/services/webview_service.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_loading.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final Map args;
  const WebViewPage({super.key, required this.args});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late Map<String, String> credential;
  late WebViewController controller;
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    credential = widget.args['credential'];
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
            Future.delayed(Duration(seconds: 2), () {
              if (progress < 100) {
                isLoading.value = false;
              }
            });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            if (!isLoading.value)
              Future.delayed(Duration(seconds: 2), () {
                final username = credential['username'];
                final password =
                    PasswordEncrypt.decrypt(credential['password'] ?? '');
                print(password);
                try {
                  controller.runJavaScript('''
                if(window.location.href==="https://sifa.unhas.ac.id/login"){
                  function setNativeValue(element, value) {
                    let lastValue = element.value;
                    element.value = value;
                    let event = new Event("input", { target: element, bubbles: true });
                    // React 15
                    event.simulated = true;
                    // React 16
                    let tracker = element._valueTracker;
                    if (tracker) {
                        tracker.setValue(lastValue);
                    }
                    element.dispatchEvent(event);
                  }

                  var input1 = document.getElementsByTagName('input')[0];
                  setNativeValue(input1, "$username");
                  var input2 = document.getElementsByTagName('input')[1];
                  setNativeValue(input2, "$password");

                  document.getElementsByTagName('button')[0].click();
                }
                
              ''');
                } catch (e) {
                  print('JavaScript Evaluation Error: $e');
                }
              });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint(error.description);
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(WebViewService.url),
      );
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
