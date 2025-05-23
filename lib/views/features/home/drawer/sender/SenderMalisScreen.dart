import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pailmail/repositories/sender_repository.dart';
import 'package:pailmail/views/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../../../models/senders/sender.dart';
import '../../../../../models/senders/senderMails.dart';
import '../../../../widgets/custom_mail_container.dart';
import '../../../../widgets/not_found_result.dart';
import '../../../inbox_mails/inbox_screen.dart';

class SenderMailsScreen extends StatefulWidget {
   SenderMailsScreen({super.key, this.mailsList, required this.sender});

  final dynamic mailsList;
   var sender;

  @override
  State<SenderMailsScreen> createState() => _SenderMailsScreenState();
}

class _SenderMailsScreenState extends State<SenderMailsScreen> {
  Color hexToColor(String hexString, {String alphaChannel = 'ff'}) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }

  SenderRepository _senderRepository = SenderRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CustomAppBar(widgetName: "Mails of Sender", bottomPadding: 40),
                widget.mailsList==null|| widget.mailsList.isEmpty ? NotFoundResult():ListView.builder(

                  padding: EdgeInsets.only(bottom: 8.h),

                  itemBuilder: (context, index) {
                    return CustomMailContainer(
                      onTap: () {
                        navigateToMailDetails(widget.mailsList[index],widget.sender);
                      },
                      organizationName:
                          widget.mailsList[index].sender!.name ?? "",
                      color:
                          hexToColor(widget.mailsList[index].status!.color ?? ''),
                      date: widget.mailsList[index].archiveDate ?? "",
                      description: widget.mailsList[index].description ?? "",
                      images: [],
                      tags: [],
                      subject: widget.mailsList[index].subject ?? "",
                      endMargin: 8,
                    );
                  },
                  itemCount: widget.mailsList.length,
                  shrinkWrap: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  navigateToMailDetails(Mails mail,Sender sender) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return InboxScreen(
            isDetails: true,
            mails: mail,
            IsSender: true,
            sender: sender,
          );
        },
      ),
    );
  }
}
