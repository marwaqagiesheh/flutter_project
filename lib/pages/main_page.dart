import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical_care_project/pages/type_page.dart';
import 'package:provider/provider.dart';
import '../provider.dart';
import 'detailspage.dart';
import '../models/reminder.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: Provider.of<ReminderProvider>(context, listen: false).loadReminders(),
        builder: (context, provider) {

          return Consumer<ReminderProvider>(
              builder: ((context, provider, child) {

                List<Reminder> reminders = [];
                List<Reminder> completed = [];


                for (var i in provider.reminders) {
                  if (widget.title == "Today") {
                    if (i.reminderDate == DateFormat('yyyy-MM-dd').format(DateTime.now())) {
                      if (i.reminderCompleted == false) {
                        reminders.add(i);
                      } else {
                        completed.add(i);
                      }
                    }
                  } else if (widget.title != "Today") {
                    if (i.reminderCompleted == false) {
                      reminders.add(i);
                    } else {
                      completed.add(i);
                    }
                  }
                }
                //drower
                return Scaffold(
                  backgroundColor: Color.fromARGB(255, 200, 200, 200),
                  drawer: Drawer(
                    backgroundColor: Color.fromARGB(255, 100, 100, 100),
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: width,
                            height: 80,
                            child: DrawerHeader(
                              decoration: BoxDecoration(
                                color: Colors.teal,
                              ),
                              child: const Text('Welcome Patiant', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            height: height - 100,
                            child: Column(children: [
                              ListTile(
                                minVerticalPadding: 0,
                                title: Text("Today",
                                  style: TextStyle(color: Colors.white),
                                ),
                                leading: Icon(Icons.today),
                                iconColor: Colors.white,
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MyHomePage(title: "Today"),
                                    ),
                                  );
                                },
                              ),
                              ListTile(
                                title: Text("All Reminders",
                                  style: TextStyle(color: Colors.white),
                                ),
                                leading: Icon(Icons.today),
                                iconColor: Colors.white,
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MyHomePage(title: "All Reminders"),
                                    ),
                                  );
                                },
                              ),


                              //types in drower
                              Expanded(

                                child: ListView.builder(
                                    itemCount: provider.types.length,
                                    itemBuilder: ((context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0
                                        ),
                                        child: ListTile(
                                          title: Text(
                                            provider.types[index].typeName!, style: TextStyle(color: Colors.white),
                                          ),
                                          leading: Icon(provider.types[index].typeIcon),
                                          iconColor: Colors.lightGreenAccent,
                                          onTap: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => TypePage(typeId: index),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    })),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //how many reminders
                  appBar: AppBar(
                    backgroundColor: Colors.teal,
                    title: Text(widget.title),
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          color: Colors.black54,
                          height: 100 + (60 * reminders.length.toDouble() + 60 * completed.length.toDouble()),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Text("${reminders.length.toString()} reminders",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),


                              // reminder list and delete
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  width: width,
                                  height: 55 * reminders.length.toDouble(),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                            itemCount: reminders.length,
                                            itemBuilder:
                                                (BuildContext context, int index) {
                                              return Dismissible(
                                                key: Key(
                                                    reminders[index].id.toString()),
                                                onDismissed: (direction) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                      content: Text(
                                                          '${reminders[index].reminderName} reminder deleted')));
                                                  provider.deleteReminder(
                                                      reminders[index].id!);
                                                  setState(() {});
                                                },
                                                background: Container(
                                                  color: Colors.red,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: const [
                                                      Icon(Icons.delete_outline),
                                                      Icon(Icons.delete_outline),
                                                    ],
                                                  ),
                                                ),
                                                child: ListTile(
                                                    // onTap: () {
                                                    //   Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //       builder: (context) =>
                                                    //           DetailsScreen(
                                                    //             reminderId: reminders[index].id,
                                                    //           ),
                                                    //     ),
                                                    //   );
                                                    // },
                                                    trailing: IconButton(
                                                      icon: const Icon(
                                                        Icons.check_box_outline_blank,
                                                        color: Colors.white,
                                                      ),
                                                      onPressed: () {
                                                        provider.changereminderState(
                                                            reminders[index].id!,
                                                            reminders[index].reminderCompleted!);

                                                        setState(() {});
                                                      },
                                                    ),
                                                    title: Container(
                                                      height: 40,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(reminders[index].reminderName!,
                                                              style: const TextStyle(color: Colors.white, fontSize: 15)),
                                                          Text(reminders[index].reminderDate!,
                                                            style: const TextStyle(color: Colors.teal, fontSize: 15),)
                                                        ],
                                                      ),
                                                    )),
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),


                              // inside the completed reminders
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Text("Completed : ${completed.length.toString()} reminders ",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
                                    ),
                                  ],
                                ),
                              ),


                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  width: width,
                                  height: 55 * completed.length.toDouble(),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                            itemCount: completed.length,
                                            itemBuilder: (BuildContext context,
                                                int index) =>

                                            // for deleting completed reminders
                                            Container(
                                              child: Dismissible(
                                                key: Key(completed[index].id.toString()),
                                                onDismissed: (direction) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                      content: Text('${completed[index].reminderName} reminder deleted')));
                                                  provider.deleteReminder(completed[index].id!);
                                                  setState(() {});
                                                },
                                                background: Container(
                                                  color: Colors.red,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: const [
                                                      Icon(Icons.delete_outline),
                                                      Icon(Icons.delete_outline),
                                                    ],
                                                  ),
                                                ),


                                                // to enter on details screen for completed reminder
                                                child: ListTile(
                                                    // onTap: () {
                                                    //   Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //       builder: (context) =>
                                                    //           DetailsScreen(
                                                    //             reminderId: completed[index].id,
                                                    //           ),
                                                    //     ),
                                                    //   );
                                                    // },
                                                    trailing: IconButton(
                                                        icon: const Icon(Icons.check_box),
                                                        onPressed: () {
                                                          provider.changereminderState(
                                                              completed[index].id!,
                                                              completed[index].reminderCompleted!);
                                                          setState(() {});
                                                        },
                                                        color: const Color.fromARGB(255, 156, 168, 173)),
                                                    title: Container(
                                                      height: 40,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [

                                                          //changeing color when completed
                                                          Text(
                                                            completed[index].reminderName!,
                                                            style: const TextStyle(
                                                                color: Color.fromARGB(255, 156, 168, 173)),
                                                          ),
                                                          Text(
                                                            completed[index].reminderDate!,
                                                            style: const TextStyle(
                                                                color: Color.fromARGB(255, 156, 168, 173)),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),



                        //design the add  tial reminder
                        Container(
                          color: Color.fromARGB(255, 70, 83, 85),
                          height: 80,
                          width: width,
                          child: IconButton(
                              onPressed: () {
                                addReminder();
                              },
                              icon: const Icon(Icons.add_box, color: Colors.teal, size: 70,
                              )),
                        )
                      ],
                    ),
                  ),

                );
              }));
        });
  }



  //add and show dialog details for adding reminder
  Future addReminder() => showDialog(
      context: context,
      builder: (context) {
        String? reminderName = "";
        String? reminderType = "Medicine Reminders";
        String? reminderDate;
        return Consumer<ReminderProvider>(builder: ((context, provider, child) {
          return StatefulBuilder(builder: (context, setState) {
            reminderDate ??= DateFormat('yyyy-MM-dd').format(DateTime.now());
            return AlertDialog(
              backgroundColor: Color.fromARGB(255,100, 100, 100),
              title: const Text("Add new reminder",
                style: TextStyle(color: Colors.white),
              ),
              content: SizedBox(
                width: 250, height: 240,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 250,
                        child: TextField(
                          style: TextStyle(color: Colors.white), autofocus: true,
                          onChanged: (value) {
                            reminderName = value;
                          },
                          decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.white),
                              hintText: "reminder name",
                              fillColor: Colors.white,
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("reminder date", style: TextStyle(color: Colors.white),
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              reminderDate!, style: TextStyle(color: Colors.teal),
                            ),
                            IconButton(
                              onPressed: (() async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2100),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        dialogBackgroundColor: Colors.black,
                                        colorScheme: const ColorScheme.light(
                                          primary: Colors.teal,
                                          onPrimary: Colors.white,
                                          onSurface: Colors.white,
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.teal,
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );

                                setState(() {
                                  reminderDate = DateFormat('yyyy-MM-dd').format(pickedDate!);
                                });
                              }),
                              icon: const Icon(Icons.date_range, color: Colors.teal,),
                            ),
                          ],
                        ),

                      ],
                    ),

                    // type design
                    Container(
                      width: 250,
                      height: 100,
                      child: ListView.builder(
                        itemCount: provider.types.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              reminderType = provider.types[index].typeName;
                              setState(() {});
                            },
                            //change color of type
                            child: Row(
                              children: [
                                Text(provider.types[index].typeName!,
                                  style: TextStyle(color: provider.types[index].typeName == reminderType ? Colors.teal : Colors.white),
                                ),
                                Icon(provider.types[index].typeIcon, color: provider.types[index].typeName == reminderType ? Colors.teal : Colors.white,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),


              //buttons for Add and Cancel in dialog
              //add  reminders in list to appear in home page

              actions: [
                TextButton(
                    onPressed: (() {
                      List<Reminder> reminders = [];

                      Reminder reminder = Reminder(
                          reminderDate: reminderDate,
                          reminderCompleted: false,
                          remindertype: reminderType,
                          reminderName: reminderName == "" ? "unnamed reminder":jsonEncode(reminders)
                          );
                      provider.addreminder(reminder);

                      Navigator.of(context).pop();
                    }),

                    child: const Text("Add", style: TextStyle(color: Colors.teal, fontSize: 25),
                    )),


                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("cancel", style: TextStyle(color: Colors.red, fontSize: 25),
                    )),
              ],
            );
          });
        }));
      });
}
