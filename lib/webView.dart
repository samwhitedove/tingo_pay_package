import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InAppWebPageViewer extends StatefulWidget {
  late String url;
  InAppWebPageViewer({required this.url, super.key});

  @override
  InAppWebPageViewerState createState() => InAppWebPageViewerState();
}

class InAppWebPageViewerState extends State<InAppWebPageViewer> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  RxBool isLoading = true.obs;
  RxDouble percentage = 0.0.obs;

  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Obx(
              () => Visibility(
                visible: isLoading.value,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(color: Colors.orange),
                      SizedBox(
                        height: Get.height * .05,
                      ),
                      Text("${percentage.value.toStringAsFixed(0)}% Loading...")
                    ],
                  ),
                ),
              ),
            ),
            RefreshIndicator(
              onRefresh: () => _controller.reload(),
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              child: Stack(
                children: [
                  WebView(
                    // initialUrl: Get.parameters['url'],
                    javascriptMode: JavascriptMode.unrestricted,
                    onPageFinished: (String url) {
                      debugPrint('Page finished loading: ');
                      isLoading.value = false;
                    },
                    onProgress: (progress) {
                      isLoading.value = true;
                      percentage.value = progress / 100;
                      // Functions.logs('progress: $progress -----------------');
                      if (percentage.value == 1.0) {
                        isLoading.value = false;
                      }
                    },
                    onWebViewCreated: (WebViewController controller) {
                      _controller = controller;
                      _controller.loadRequest(WebViewRequest(
                        uri: Uri.parse(widget.url),
                        method: WebViewRequestMethod.get,
                        // headers: Get.arguments['headers'],
                      ));
                    },
                    gestureNavigationEnabled: true,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Icon(Icons.arrow_back),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
