import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taxverse/model/financial_news.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/utils/constant/sizedbox.dart';
import 'package:taxverse/view/mainscreens/news_screen/widget/news_details.dart';

class BreakingNewsCard extends StatefulWidget {
  const BreakingNewsCard({super.key, required this.news});

  final FinancialNews news;

  @override
  State<BreakingNewsCard> createState() => _BreakingNewsCardState();
}

class _BreakingNewsCardState extends State<BreakingNewsCard> {

  @override
  void initState() {
    
    super.initState();

    
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(news: widget.news),
            ));
      },
      child: Container(
        height: size.height * 0.08,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            
            image: NetworkImage(widget.news.imageUrl ?? errorImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(colors: [
              Colors.transparent,
              blackColor
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          padding: EdgeInsets.all(size.height * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.news.title,
                maxLines: 6,
                style: AppStyle.poppinsBoldWhite12,
              ),
              const SizedBox(height: 8),
              Text(
                widget.news.author,
                style: AppStyle.poppinsRegulargrey14,
              )
            ],
          ),
        ),
      ),
    );
  }
}
