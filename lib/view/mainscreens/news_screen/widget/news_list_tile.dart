import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/view/mainscreens/news_screen/widget/news_details.dart';

class NewsListTile extends StatelessWidget {
  const NewsListTile({super.key, required this.news, required this.id});

  final DocumentSnapshot news;
  final String id;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
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
        height: size.height * 0.15,
        decoration: BoxDecoration(
          color: blackColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(26),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 3,
              child: SizedBox(
                height: size.height * 0.15,
                width: size.height * 0.15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
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
            ),
            const SizedBox(width: 10),
            Flexible(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Text(
                      news['newsHeading'],
                      overflow: TextOverflow.clip,
                      style: AppStyle.poppinsBold16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Flexible(
                    child: Text(
                      news['description'],
                      overflow: TextOverflow.fade,
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
