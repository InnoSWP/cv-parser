import 'package:cvparser/widgets/file_download.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import 'package:flutter/material.dart';

class InformationWidget extends StatelessWidget {
  const InformationWidget({
    Key? key,
    required this.jsonText,
    required this.jsonName,
  }) : super(key: key);

  final RxString jsonText;
  final RxString jsonName;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 4,
      // For Border Line
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(
              color: MainColors.secondColor,
              width: 3.0,
            ),
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildTextSpace(),
            buildDownloadButton(context),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Flexible buildDownloadButton(BuildContext context) {
    return Flexible(
      flex: 1,
      child: FittedBox(
        fit: BoxFit.fill,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: MainColors.secondPageButtonColor,
              fixedSize: const Size(453, 108),
              side: const BorderSide(color: MainColors.secondColor)),
          // Button 'Parse CVs' will send you to Main Page
          onPressed: () {
            if(jsonText.value == '') {
              showAlertDialog(context);
            }
            else{
              download(jsonText.value, downloadName: "${jsonName.value}.json");
            }
          },

          // 'Parse CVs' button with icon itself
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: const [
              SizedBox(
                width: 207,
                child: Text(
                  'Export as JSON',
                  style: TextStyle(
                      color: MainColors.secondColor,
                      fontFamily: 'Eczar',
                      fontSize: 32,
                      fontWeight: FontWeight.w100),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(
                width: 20,
              ),

              Icon(
                Icons.download_sharp,
                size: 80,
                color: MainColors.secondColor,
              ),
            ],
          ),
        ),
      )
    );
  }

  Flexible buildTextSpace() {
    return Flexible(
      flex: 5,
      child: ListView(
        primary: true,
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Obx(() => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                  jsonText.value,
                  style: const TextStyle(
                      color: MainColors.secondColor,
                      fontFamily: 'Merriweather',
                      fontSize: 18,
                      fontWeight: FontWeight.w100),
                ),
              )), // Json text
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {

    Widget closeButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: MainColors.secondColor),
      child: const Text(
        'Close',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Merriweather',
            fontSize: 16,
            fontWeight: FontWeight.w100),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Error",
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'Merriweather',
            fontWeight: FontWeight.w100),),
      content: const Text("You do not choose the file to export",
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'Merriweather',
            fontWeight: FontWeight.w100),),
      actions: [
        closeButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
