import 'package:pailmail/models/statuses/status.dart';
import 'package:flutter/material.dart';

class StautsMails extends StatefulWidget {
  const StautsMails({Key? key, required this.mails}) : super(key: key);
  final Status? mails;
  @override
  State<StautsMails> createState() => _StatusMailsState();
}

class _StatusMailsState extends State<StautsMails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'All Mails',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(children: [
            // Consumer<CategoriesProvider>(builder: (BuildContext context,
            //     CategoriesProvider value, Widget? child) {
            //   var data = value.mailsCategory[widget.index].data;
            //
            //   return Expanded(
            //     child: ListView.builder(
            //       padding: EdgeInsets.zero,
            //       itemBuilder: (context, index) {
            //         return CustomMailContainer(
            //           onTap: () {},
            //           organizationName: data![index].sender!.name ?? "",
            //           color: kYellowColor,
            //           date: data![index].archiveDate ?? "",
            //           description: data![index].description ?? "",
            //           images: [],
            //           tags: data![index].tags ?? [],
            //           subject: data![index].subject ?? "",
            //           endMargin: 8,
            //         );
            //       },
            //       itemCount: data!.length,
            //       shrinkWrap: true,
            //     ),
            //   );
            // }),
          ]),
        ),
      ),
    );
  }
}
