import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class WebViewNews extends StatefulWidget {
  const WebViewNews({super.key, required this.websiteUrl});

  final String websiteUrl;

  @override
  State<WebViewNews> createState() => _WebViewNewsState();
}

class _WebViewNewsState extends State<WebViewNews> {
  @override
  void initState() {
    super.initState();

    isLoading = true;

    Future.delayed(
      const Duration(seconds: 1),
      () => webview(),
    );
  }

  void webview() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadRequest(Uri.parse(widget.websiteUrl));

    setState(() {
      isLoading = false;
    });
  }

  var controller = WebViewController();
  bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: controller),
            Visibility(
              visible: isLoading!,
              child: const Center(child: SpinKitCircle(color: blackColor)),
            ),
          ],
        ),
      ),
    );
  }
}
