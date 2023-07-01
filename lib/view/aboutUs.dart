import 'package:flutter/material.dart';
import 'package:taxverse/constants.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          'About Us',
          style: AppStyle.poppinsBold24,
        ),
        backgroundColor: whiteColor,
        elevation: 0,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: const [
              Text(
                'Welcome to Taxverse!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'At Taxverse, we are committed to simplifying your tax-related processes and providing comprehensive business consultancy services. Our application is designed to empower businesses like yours with efficient solutions, allowing you to focus on what truly matters – your growth and success.',
              ),
              SizedBox(height: 16.0),
              Text(
                'Our Services:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'GST Registration: We assist you in seamless GST registration, ensuring compliance with the latest regulations. Streamline your tax filing and reporting with our user-friendly tools.',
              ),
              SizedBox(height: 8.0),
              Text(
                'Tax Planning: Our team of experts will help you optimize your tax strategy, maximizing your savings while remaining fully compliant with the tax laws. Let us take care of the complexities while you enjoy the benefits.',
              ),
              SizedBox(height: 8.0),
              Text(
                'Financial Analysis: Gain valuable insights into your financial performance and make informed decisions. Our advanced analytics tools provide comprehensive reports and personalized recommendations tailored to your business.',
              ),
              SizedBox(height: 16.0),
              Text(
                'Why Choose Taxverse?',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Simplified Workflow: Our intuitive interface and step-by-step guidance make it easy to navigate through complex tax processes. Say goodbye to time-consuming paperwork and embrace a streamlined workflow.',
              ),
              SizedBox(height: 8.0),
              Text(
                'Data Security: We prioritize the security and confidentiality of your data. Rest assured that your information is protected with robust encryption and industry-standard security measures.',
              ),
              SizedBox(height: 8.0),
              Text(
                'Real-Time Updates: Stay up-to-date with the latest tax regulations, deadlines, and compliance requirements. We ensure that you are well-informed and prepared to meet your tax obligations.',
              ),
              SizedBox(height: 8.0),
              Text(
                'Personalized Assistance: Our team of experienced professionals is dedicated to providing personalized support and guidance. We are here to address your queries, offer expert advice, and help you achieve your financial goals.',
              ),
              SizedBox(height: 16.0),
              Text(
                'Join thousands of businesses who have entrusted their tax and consultancy needs to Taxverse. Our commitment to excellence and customer satisfaction sets us apart as a leading partner for businesses across industries.',
              ),
              SizedBox(height: 16.0),
              Text(
                'Contact Us:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'For any inquiries, support, or to learn more about our services, please feel free to reach out to us. You can contact us via email at favadfavad2@gmail.com or call us at +123456789. Follow us on social media for updates and industry insights.',
              ),
              SizedBox(height: 16.0),
              Text(
                'Start your journey towards simplified tax management and business success with Taxverse today!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
