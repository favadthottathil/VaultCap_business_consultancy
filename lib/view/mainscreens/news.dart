import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/view/widgets/breaking_news_card.dart';
import 'package:taxverse/view/widgets/news_list_tile.dart';

class News extends StatelessWidget {
  News({super.key});

  final newsData = FirebaseFirestore.instance
      .collection('news')
      .orderBy(
        'time',
        descending: true,
      )
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            'News',
            style: AppStyle.poppinsBold24,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: newsData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var news = snapshot.data?.docs ?? [];
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Breaking news',
                      style: AppStyle.poppinsBold27,
                    ),
                    const SizedBox(height: 20),
                    CarouselSlider.builder(
                      itemCount: news.length,
                      itemBuilder: (context, index, realIndex) => BreakingNewsCard(
                        news: news[index],
                      ),
                      options: CarouselOptions(
                        aspectRatio: 16 / 9,
                        enableInfiniteScroll: false,
                        enlargeCenterPage: true,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Recent News',
                      style: AppStyle.poppinsBold27,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: news.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: NewsListTile(news: news[index]),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return SnackBar(
              content: Text('error ${snapshot.error}'),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
