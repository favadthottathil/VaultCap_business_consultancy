import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:vaultcap/model/financial_news.dart';
import 'package:vaultcap/utils/constant/constants.dart';
import 'package:vaultcap/utils/constant/sizedbox.dart';
import 'package:vaultcap/view/mainscreens/news_screen/widget/news_details.dart';


class NewsListTile extends StatelessWidget {
  const NewsListTile({
    super.key,
    required this.news,
    //  required this.id
  });

  final FinancialNews news;
  // final String id;

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
                    imageUrl: news.imageUrl,
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
                      news.title,
                      overflow: TextOverflow.clip,
                      style: AppStyle.poppinsBold16,
                    ),
                  ),
                  SizedBox(height: size.height * 0.001),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(showDate(timestamp: news.publishedAt), style: AppStyle.poppinsBold12),
                      Text(showDate(timestamp: news.publishedAt, time: true)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String showDate({required String timestamp, bool time = false}) {
    DateTime dateTime = DateTime.parse(timestamp).toLocal();

    String formattedDate = DateFormat('dd-MMM-yyyy').format(dateTime);
    String formattedTime = DateFormat('hh:mm a').format(dateTime);

    if (time) {
      return formattedTime;
    }

    return formattedDate;
  }
}
