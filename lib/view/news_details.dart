import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:taxverse/utils/constant/constants.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.news});

  final DocumentSnapshot news;

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
                news['newsHeading'],
                style: AppStyle.poppinsBold27,
              ),
              const SizedBox(height: 8),
              Text(
                news['auther'],
                style: AppStyle.poppinsBold12,
              ),
              SizedBox(height: size.height * 0.03),
              // Image.network(
              //   news['image'],
              //   fit: BoxFit.cover,
              // ),
              CachedNetworkImage(
                imageUrl: news['image'],
                placeholder: (context, url) => const Center(
                  child: SpinKitCircle(
                    color: blackColor,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error, size: 40),
              ),
              SizedBox(height: size.height * 0.04),
              Text(
                news['description'],
                style: AppStyle.poppinsBold16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
