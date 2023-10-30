// import 'dart:math';
import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:taxverse/api/financial_news.dart';
import 'package:taxverse/model/financial_news.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/view/mainscreens/news_screen/widget/breaking_news_card.dart';
import 'package:taxverse/view/mainscreens/news_screen/widget/news_list_tile.dart';
import 'package:taxverse/view/widgets/frosted_glass/frosted_glass.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  List<FinancialNews> news = [];

  final _scrollController = ScrollController();

  bool isLoadingMore = false;

  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _loadData();
  }

  void _scrollListener() {
    //  check if the user has scrolled to the end of the list
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadMoreData();
    }
  }


  void _loadData() async {
    try {
      List<FinancialNews> data = await FinancialNewsService().fetchFinancialNews(currentPage);
      setState(
        () {
          news.addAll(data);
          currentPage++;
        },
      );
    } catch (error) {
      log(error.toString());
    }
  }

  Future<void> _loadMoreData() async {
    setState(() {
      isLoadingMore = true;
    });

    try {
      List<FinancialNews> additionalData = await FinancialNewsService().fetchFinancialNews(currentPage);
      setState(() {
        news.addAll(additionalData);

        log(news.toString());

        currentPage++;
        isLoadingMore = false;
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            FutureBuilder(
              future: FinancialNewsService().fetchFinancialNews(currentPage),
              builder: (_, AsyncSnapshot<List<FinancialNews>> snapshot) {
                if (snapshot.hasData) {
                  log('financial news success');
                  

                  return SingleChildScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.all(size.height * 0.02),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('News', style: AppStyle.poppinsBold24),
                              const Icon(Icons.notifications)
                            ],
                          ),
                          SizedBox(height: size.height * 0.02),
                          Text(
                            'Breaking news',
                            style: AppStyle.poppinsBold27,
                          ),
                          SizedBox(height: size.height * 0.025),
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
                          SizedBox(height: size.height * 0.045),
                          Text(
                            'Recent News',
                            style: AppStyle.poppinsBold27,
                          ),
                          ListView.builder(
                            // controller: _scrollController,
                            shrinkWrap: true,
                            primary: false,
                            itemCount: isLoadingMore ? news.length + 1 : news.length, // Add 1 for Loading indicator
                            itemBuilder: (context, index) {
                              if (index < news.length) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                                  child: NewsListTile(news: news[index]),
                                );
                              }
                              return null;

                              // var id = news[index].id;
                            },
                          ),
                          SizedBox(height: size.height * 0.1)
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return SnackBar(
                    content: Text('error ${snapshot.error}'),
                  );
                } else {
                  return const SpinKitCircle(color: blackColor);
                }
              },
            ),
            if (isLoadingMore)
              FrostedGlass(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SpinKitCircle(
                      color: blackColor,
                    ),
                    Text('Loading More.....', style: AppStyle.poppinsBold14)
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
