import 'package:flutter/material.dart';
import 'package:medical_care_project/models/reminder.dart';
import '/data_base_helper.dart';
import '../models/types.dart';

class ReminderProvider with ChangeNotifier {
  List<Reminder> reminders = [];
  List<ReminderType> types = [
    ReminderType(
        id: 1,
        typeName: "Medicine Reminders",
        typeIcon: Icons.medication_liquid_sharp,
        reminderCount: 0),

    ReminderType(
        id: 2,
        typeName: "Examination Reminders",
        typeIcon: Icons.checklist_sharp,
        reminderCount: 0),
    ReminderType(
        id: 3,
        typeName: "Physical Activities",
        typeIcon: Icons.sports_gymnastics_sharp,
        reminderCount: 0),

    // ReminderType(
    //     id: 4,
    //     typeName: "Reading Reminder",
    //     n: Icons.receipt_long,
    //     reminderCount: 0),
  ];

  Future addreminder(Reminder reminder) async {
    await DBManager.addReminder({
      'Reminder_Name': reminder.reminderName!,
      'Reminder_Date': reminder.reminderDate!,
      'Reminder_Completed': reminder.reminderCompleted == false ? 0 : 1,
      'Reminder_Type': reminder.remindertype!,
     // 'Simi_Reminders': reminder.simiReminders!
    });

    notifyListeners();
  }

  Future<void> loadReminders() async {
    final dataList = await DBManager.loadReminders();

    reminders = dataList
        .map((data) => Reminder(
        id: data['id'],
        reminderName: data['Reminder_Name'],
        reminderDate: data['Reminder_Date'],
        reminderCompleted: data['Reminder_Completed'] == 0 ? false : true,
        remindertype: data['Reminder_Type'],
        //simiReminders: data['Simi_Reminders']
    ))
        .toList();

    notifyListeners();
  }

  Future<void> changereminderState(id, bool reminderCompleted) async {
    reminderCompleted = !reminderCompleted;
    final data = await DBManager.database();

    await data.update(
      DBManager.tableName,
      {'Reminder_Completed': reminderCompleted == false ? 0 : 1},
      where: "id = ?",
      whereArgs: [id],
    );

    notifyListeners();
  }
  //
  // Future<void> updatesimiReminder(id, String simireminders) async {
  //   final data = await DBManager.database();
  //   print(simireminders);
  //   await data.update
  //     (DBManager.tableName,
  //     {'Simi_Reminders': simireminders},
  //
  //   );
  //
  //   notifyListeners();
  // }

  deleteReminder(int id) {
    DBManager.deleteReminder(DBManager.tableName, id);
    notifyListeners();
  }
}
