import 'package:pailmail/core/helpers/api_helpers/api_response.dart';
import 'package:pailmail/providers/mails_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestEmails extends StatefulWidget {
  const TestEmails({Key? key}) : super(key: key);

  @override
  State<TestEmails> createState() => _TestEmailsState();
}

class _TestEmailsState extends State<TestEmails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Consumer<MailProvider>(
          //   builder: (context, mailProvider, child) {
          //     if (mailProvider.mails.status == ApiStatus.LOADING) {
          //       {
          //         return const CircularProgressIndicator();
          //       }
          //     } else if (mailProvider.mails.status == ApiStatus.COMPLETED) {
          //       {
          //         return Expanded(
          //           child: ListView.builder(
          //             shrinkWrap: true,
          //             itemBuilder: (context, index) {
          //               final mail = mailProvider.mails.data![index].subject;
          //               return Row(
          //                 children: [
          //                   Container(
          //                     child: Text(mail.toString()),
          //                   ),
          //                 ],
          //               );
          //             },
          //             itemCount: mailProvider.mails.data!.length,
          //           ),
          //         );
          //       }
          //     } else {
          //       return Text(mailProvider.mails.message.toString());
          //     }
          //   },
          // ),
          const Divider(),

          Consumer<MailProvider>(
            builder: (context, mailProvider, child) {
              if (mailProvider.singleMail.status == ApiStatus.LOADING) {
                {
                  return const CircularProgressIndicator();
                }
              } else if (mailProvider.singleMail.status ==
                  ApiStatus.COMPLETED) {
                {
                  final mail = mailProvider.singleMail.data;
                  return mailProvider.singleMail.data!.isEmpty
                      ? const SizedBox.shrink()
                      : Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Provider.of<MailProvider>(context, listen: false)
                                  .fetchAllMails();
                            },
                            child: Row(
                              children: [
                                Text(mail.toString()),
                              ],
                            ),
                          ),
                        );
                }
              } else {
                return Text(mailProvider.mails.message.toString());
              }
            },
          ),
          // ElevatedButton(
          //   onPressed: () async {},
          //   child: Consumer<MailProvider>(
          //     builder: (context, mailProvider, child) {
          //       if (mailProvider.mails.status == ApiStatus.LOADING) {
          //         {
          //           return const CircularProgressIndicator();
          //         }
          //       } else if (mailProvider.mails.status == ApiStatus.COMPLETED) {
          //         {
          //           final mail = mailProvider.mails.data![0].id;
          //           return Center(
          //             child: Row(
          //               children: [
          //                 Container(
          //                   child: Text(mail.toString()),
          //                 ),
          //               ],
          //             ),
          //           );
          //         }
          //       } else {
          //         return Text(mailProvider.singleMail.message.toString());
          //       }
          //     },
          //   ),
          // ),
          // Consumer<MailProvider>(
          //   builder: (context, mailProvider, child) {
          //     final mail = mailProvider.createdMail.data?.id;
          //     if (mailProvider.createdMail.status == ApiStatus.LOADING) {
          //       {
          //         return const CircularProgressIndicator();
          //       }
          //     } else if (mailProvider.createdMail.status ==
          //         ApiStatus.COMPLETED) {
          //       {
          //         return Center(
          //           child: Row(
          //             children: [
          //               Container(
          //                 child: Text(mail.toString()),
          //               ),
          //             ],
          //           ),
          //         );
          //       }
          //     } else {
          //       return Text(mailProvider.createdMail.message.toString());
          //     }
          //   },
          // ),

          ///update
          // Consumer<MailProvider>(
          //   builder: (context, mailProvider, child) {
          //     final mail = mailProvider.singleMail;
          //     if (mailProvider.singleMail.status == ApiStatus.LOADING) {
          //       {
          //         return const CircularProgressIndicator();
          //       }
          //     } else if (mailProvider.singleMail.status ==
          //         ApiStatus.COMPLETED) {
          //       {

          //         return Center(
          //           child: Row(
          //             children: [
          //               Container(
          //                 child: Text(mail.toString()),
          //               ),
          //             ],
          //           ),
          //         );
          //       }
          //     } else {
          //       return Text(mailProvider.mails.message.toString());
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}
