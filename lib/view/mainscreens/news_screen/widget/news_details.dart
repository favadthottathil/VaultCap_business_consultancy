import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:taxverse/model/financial_news.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/utils/constant/sizedbox.dart';
import 'package:taxverse/view/mainscreens/news_screen/webview_screen.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.news});

  final FinancialNews news;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: blackColor,
        ),
        leading: MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebViewNews(websiteUrl: news.url),
                    ));
              },
              icon: const Icon(Icons.public))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(size.height * 0.02),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                news.title,
                style: AppStyle.poppinsBold27,
              ),
              const SizedBox(height: 8),
              // Text(
              //   news.content,
              //   style: AppStyle.poppinsBold12,
              // ),
              SizedBox(height: size.height * 0.03),
              // Image.network(
              //   news['image'],
              //   fit: BoxFit.cover,
              // ),
              CachedNetworkImage(
                imageUrl: news.imageUrl,
                placeholder: (context, url) => const Center(
                  child: SpinKitCircle(
                    color: blackColor,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error, size: 40),
              ),
              SizedBox(height: size.height * 0.04),
              Text(
                news.content,
                style: AppStyle.poppinsBold16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
