import 'dart:convert';
import 'dart:developer';
import 'package:dvmane/services/home_page_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../PoJos/response/report_response_class.dart';
import '../PoJos/response/report_status_response_class.dart';
import '../configuration/globals.dart';

class ReportScreen extends StatefulWidget {
  final String state;

  const ReportScreen({Key? key, required this.state}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Data>>(
        future: HomePageService().getReports(widget.state),
        builder: (ctx, AsyncSnapshot<List<Data>> snapshot) {
          log("ERROR:- ${snapshot.error}");
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (ctx, index) => Padding(
                      padding: EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                          top: index == 0 ? 10.0 : 0.0),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            elevation: 5.0,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                children: [
                                  const SizedBox(height: 10.0),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text: "Name: ",
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Theme.of(context)
                                                            .primaryColor)),
                                                TextSpan(
                                                    text: snapshot.data![index]
                                                        .client!.name,
                                                    style: TextStyle(
                                                        fontSize: 18.0,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ]),
                                            ),
                                            const SizedBox(height: 10.0),
                                            RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text: "Bank: ",
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Theme.of(context)
                                                            .primaryColor)),
                                                TextSpan(
                                                    text: snapshot.data![index]
                                                        .bank!.name,
                                                    style: TextStyle(
                                                        fontSize: 18.0,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ]),
                                            ),
                                            const SizedBox(height: 10.0),
                                            RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text: "Visiting Er.:",
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Theme.of(context)
                                                            .primaryColor)),
                                                TextSpan(
                                                    text: snapshot.data![index]
                                                        .visitor!.name,
                                                    style: TextStyle(
                                                        fontSize: 18.0,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: IconButton(
                                          onPressed: () {
                                            showBottomSheetForReports(
                                                snapshot.data![index]);
                                          },
                                          icon: Icon(
                                            Icons.open_in_new,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20.0),
                                  snapshot.data![index].status == "Pending"
                                      ? Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                    shape: MaterialStateProperty
                                                        .resolveWith((states) =>
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20.0)))),
                                                onPressed: () {
                                                  changeState(
                                                      snapshot.data![index],
                                                      "Approved");
                                                },
                                                child: const Text(
                                                  "Accept",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: OutlinedButton(
                                                style: ButtonStyle(
                                                    shape: MaterialStateProperty
                                                        .resolveWith((states) =>
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20.0)))),
                                                onPressed: () {
                                                  changeState(
                                                      snapshot.data![index],
                                                      "Rejected");
                                                },
                                                child: const Text(
                                                  "Reject",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      : Container(),
                                  const SizedBox(
                                    height: 10.0,
                                  )
                                ],
                              ),
                            ),
                          )),
                    ),
                  )
                : const Center(
                    child: Text("No reports found"),
                  );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
        },
      ),
    );
  }

  changeState(Data data, state) async {
    ReportsStatusResponseClass reportStatus = ReportsStatusResponseClass();
    reportStatus = await HomePageService().changeReportStatus(data, state);
    showSnackBar(reportStatus.status);
    setState(() {});
  }

  showBottomSheetForReports(Data dataObj) {
    showModalBottomSheet(
        context: context,
        elevation: 5.0,
        barrierColor: Colors.grey.withOpacity(0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height * .2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey[100]),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                const Text("Download following files"),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.resolveWith((states) =>
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(20.0)))),
                        onPressed: () {
                          openFile(dataObj,1);
                        },
                        child: const Text(
                          "Report File",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.resolveWith((states) =>
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(20.0)))),
                        onPressed: () {
                          openFile(dataObj,2);
                        },
                        child: const Text(
                          "Additional File",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.resolveWith((states) =>
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(20.0)))),
                        onPressed: () {
                          openFile(dataObj,3);
                        },
                        child: const Text(
                          "CheckList File",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  void openFile(Data data,c) async{
    String? fileName;
    switch(c){
      case 1:
        fileName = data.reportFile;
        break;
      case 2:
        fileName = data.noteFile;
        break;
      case 3:
        fileName = data.checklistFile;
        break;
    }
    if (!await launchUrl(
    Uri.parse("${Globals.apiUrl}/uploads/$fileName"),
    mode: LaunchMode.externalApplication,
    )) {
    throw 'Could not launch ${Globals.apiUrl}/uploads/$fileName';
    }
  }

  showSnackBar(status) {
    if (status != "Pending") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Order has been $status")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong, Please try again")));
    }
  }
} /* */
