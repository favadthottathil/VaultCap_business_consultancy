import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:taxverse/constants.dart';
import 'package:taxverse/view/news_details.dart';

class NewsListTile extends StatelessWidget {
  const NewsListTile({super.key, required this.news});

  final DocumentSnapshot news;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(news: news),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        height: 130,
        decoration: BoxDecoration(
          color: blackColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(26),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 3,
              child: Container(
                height: 100,
                width: 100,
                child: CachedNetworkImage(
                  imageUrl: news['image'],
                  placeholder: (context, url) => const Center(
                    child: SpinKitThreeBounce(
                      color: blackColor,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error, size: 40),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 2,
                    child: Text(
                      news['newsHeading'],
                      style: AppStyle.poppinsBold16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Flexible(
                    child: Text(
                      news['description'],
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.poppinsBold12,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
