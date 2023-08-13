import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebViewScreen extends StatelessWidget {
   final String URL;
   var controller = WebViewController();
   WebViewScreen({super.key, required this.URL,
})
   {
     controller = WebViewController()

       ..loadRequest(Uri.parse(URL));
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:WebViewWidget(controller: controller,),
    );
  }
}
