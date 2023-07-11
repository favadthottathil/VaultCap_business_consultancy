import 'package:flutter/material.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/view/chat/chat_ui.dart';

class ConnectWithUsPage extends StatelessWidget {
  ConnectWithUsPage({super.key});

  final list = [
    'Business Planning and Strategy: Our team of experts will work closely with you to develop a comprehensive business plan and strategy that aligns with your vision and goals.',
    'Financial Analysis and Forecasting: We provide in-depth financial analysis and forecasting to help you make informed decisions about funding, investment opportunities, and growth potential.',
    "Funding and Financing Options: We'll guide you through various funding and financing options available for startups, including venture capital, angel investors, loans, and grants.",
    "Legal and Regulatory Compliance: We'll ensure that your new business complies with all necessary legal and regulatory requirements, helping you avoid potential pitfalls and penalties.",
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.06),
                child: Text(
                  'Starting a New Business',
                  style: AppStyle.poppinsBold24,
                ),
              ),
              Container(
                margin: EdgeInsets.all(size.height * 0.02),
                padding: EdgeInsets.all(size.height * 0.01),
                // color: greyColor,
                height: size.height * 0.24,
                width: size.width,
                decoration: BoxDecoration(color: greyColor, borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: size.width * 0.02),
                    child: Text(
                      'Welcome to our financial consultancy application, where we specialize in assisting entrepreneurs like you in starting successful businesses. We offer a range of services tailored to meet your specific needs and help you navigate the complex world of finance.',
                      style: AppStyle.poppinsBold16,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.06),
                child: Text(
                  'Our Services',
                  style: AppStyle.poppinsBold18,
                ),
              ),
              const ListTileCustom(
                text: 'Business Planning and Strategy',
                subText: 'Our team of experts will work closely with you to develop a comprehensive business plan and strategy that aligns with your vision and goals.',
              ),
              const ListTileCustom(
                text: 'Financial Analysis and Forecasting',
                subText: 'We provide in-depth financial analysis and forecasting to help you make informed decisions about funding, investment opportunities, and growth potential.',
              ),
              const ListTileCustom(
                text: 'Funding and Financing Options',
                subText: "We'll guide you through various funding and financing options available for startups, including venture capital, angel investors, loans, and grants.",
              ),
              const ListTileCustom(
                text: 'Legal and Regulatory Compliance',
                subText: "We'll ensure that your new business complies with all necessary legal and regulatory requirements, helping you avoid potential pitfalls and penalties.",
              ),
              SizedBox(height: size.height * 0.02),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.06),
                child: Text(
                  'Contact Us',
                  style: AppStyle.poppinsBold18,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.047),
                child: Text(
                  "If you're ready to take the next step or have any questions, our team is here to assist you. Feel free to reach out to us via phone, email, or the chat feature below.",
                  style: AppStyle.poppinsBold14,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatRoom(),
                    ),
                  ),
                  icon: const Icon(Icons.support_agent),
                  label: Text(
                    'Chat With Us',
                    style: AppStyle.poppinsBoldWhite18,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blackColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.02, horizontal: size.width * 0.02),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}

class ListTileCustom extends StatelessWidget {
  const ListTileCustom({
    super.key,
    required this.text,
    required this.subText,
  });

  final String text;

  final String subText;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.02),
      child: ListTile(
        leading: const Icon(
          Icons.forward,
          color: Colors.red,
        ),
        title: Text(
          text,
          style: AppStyle.poppinsBold16,
        ),
        subtitle: Text(
          subText,
          style: AppStyle.poppinsBold12,
        ),
      ),
    );
  }
}
