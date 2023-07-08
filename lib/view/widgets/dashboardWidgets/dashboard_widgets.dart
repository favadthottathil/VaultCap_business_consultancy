import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:taxverse/controller/providers/dashboard_provider.dart';
import 'package:taxverse/utils/constant/constants.dart';

Padding showgstInfoToClient(Size size, gstNumber, DashBoardProvider provider, gstdoc) {
  return Padding(
    padding: EdgeInsets.only(right: size.width * 0.08, bottom: size.height * 0.05),
    child: Container(
      height: size.height * 0.2,
      width: size.width,
      decoration: BoxDecoration(
        color: greyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          SizedBox(height: size.height * 0.025),
          Text(
            'Registration Completed!!!',
            style: AppStyle.poppinsBoldGreen20,
          ),
          SizedBox(height: size.height * 0.02),
          Text(
            'GST NO :$gstNumber',
            style: AppStyle.poppinsRegular15,
          ),
          SizedBox(height: size.height * 0.01),
          provider.progress != null
              ? const SpinKitCircle(color: blackColor)
              : provider.showSuccess == false
                  ? MaterialButton(
                      onPressed: () {
                        try {
                          FileDownloader.downloadFile(
                            url: '$gstdoc',
                            // name: 'gstdocument',
                            onDownloadError: (errorMessage) {},
                            onProgress: (fileName, progress) {
                              provider.setProgressValue(progress);
                            },
                            onDownloadCompleted: (path) {
                              provider.path = path;
                              provider.downloadedCompleted();
                            },
                          );
                        } catch (e) {
                          log('erro downlaod imae $e');
                        }
                      },
                      child: Text(
                        'Download GST Certificate',
                        style: AppStyle.poppinsRegular15,
                      ),
                    )
                  : MaterialButton(
                      onPressed: () {
                        log('presssed');
                        try {
                          OpenFile.open(provider.path);
                        } catch (e) {
                          log('$e');
                        }
                      },
                      child: Text(
                        'Open file',
                        style: AppStyle.poppinsBoldGreen12,
                      ),
                    )
        ],
      ),
    ),
  );
}
