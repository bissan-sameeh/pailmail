// // To parse this JSON data, do
// //
// //     final mailsOfCategory = mailsOfCategoryFromJson(jsonString);
//
// import 'dart:convert';
//
// import 'package:pailmail/models/senders/sender.dart';
// import '../mails/mail.dart';
//
// MailsOfCategory mailsOfCategoryFromJson(String str) =>
//     MailsOfCategory.fromJson(json.decode(str));
//
// // String mailsOfCategoryToJson(MailsOfCategory data) =>
// //     json.encode(data.toJson());
//
// class MailsOfCategory {
//   List<Mail>? mails;
//
//   MailsOfCategory({
//     this.mails,
//   });
//
//
//
//   factory MailsOfCategory.fromJson(Map<String, dynamic> json) {
//   final category = json['category'] as Map<String, dynamic>?;
//
//   if (category == null || category['senders'] == null) {
//   return MailsOfCategory(mails: []);
//   }
//
//   final senders = category['senders'] as List<dynamic>;
//   final allMails = <Mail>[];
//
//   for (final sender in senders) {
//   final senderMails = sender['mails'] as List<dynamic>? ?? [];
//   allMails.addAll(senderMails.map((m) => Mail.fromJson(m)));
//   }
//
//   return MailsOfCategory(mails: allMails);
//   }
//   }
//
