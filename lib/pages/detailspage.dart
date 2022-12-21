
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import '../models/reminder.dart';
// import '../provider.dart';
//
//
// class DetailsScreen extends StatefulWidget {
//   DetailsScreen({super.key, this.reminderId});
//   int? reminderId;
//   @override
//   State<DetailsScreen> createState() => _DetailsScreenState();
// }
//
// class _DetailsScreenState extends State<DetailsScreen> {
//   String? simiReminderName = "";
//   String? simiReminderDate;
//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController _controller = TextEditingController();
//     return FutureBuilder(
//         future: Provider.of<ReminderProvider>(context, listen: false).loadReminders(),
//         builder: (context, snapshot) {
//
//
//           return Consumer<ReminderProvider>(
//               builder: ((context, provider, child) {
//
//             simiReminderDate ??= DateFormat('yyyy-MM-dd').format(DateTime.now());
//             List<SimiReminder> simireminders = [];
//             simireminders = List<SimiReminder>.from(
//                 jsonDecode(reminder.simiReminders!)
//                     .map((i) => SimiReminder.fromJson(i)));
//
//             return Scaffold(
//               backgroundColor: Colors.white70,
//               appBar: AppBar(
//                 title: Wrap(
//                   children: [
//                     Text(
//                       reminder.reminderName!,
//                       style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//                     )
//                   ],
//                 ),
//               ),
//               body: Container(
//                 child: Column(
//                   children: [
//                     Container(
//                       color: Colors.black54,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 15),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//
//                             Row(
//                               children: [
//                                 Text(simiReminderDate!, style: TextStyle(color: Colors.teal),
//                                 ),
//
//                               ],
//                             ),
//
//                           ],
//                         ),
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//             );
//           }));
//         });
//   }
// }
