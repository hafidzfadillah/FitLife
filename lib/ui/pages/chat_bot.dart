import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:fitlife/core/viewmodels/chat/chat_provider.dart';
import 'package:fitlife/core/viewmodels/connection/connection.dart';
import 'package:fitlife/core/viewmodels/user/user_provider.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:fitlife/ui/widgets/CustomAppBar.dart';
import 'package:fitlife/ui/widgets/button.dart';
import 'package:fitlife/ui/widgets/chat_bubble.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: neutral20,
        appBar: CustomAppBar(
          title: 'Pandan AI',
          backgroundColor: lightModeBgColor,
          elevation: 0,
          actions: [ 
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: Image.asset(
                      'assets/images/bamboo.png',
                      width: 24,
                      height: 24,
                    ),
                    onPressed: () {},
                    color: Color(0xff333333),
                  ),
                  Text(
                    50.toString(),
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff00C680)),
                  )
                ],
              ),
            ),
          ],
          leading: CustomBackButton(onClick: () {
            Navigator.pop(context);
          }),
        ),
        body: ChangeNotifierProvider(
          create: (context) => ChatProvider(),
          child: ChatBotBody(),
        ));
  }
}

class ChatBotBody extends StatefulWidget {
  const ChatBotBody({
    super.key,
  });

  @override
  State<ChatBotBody> createState() => _ChatBotBodyState();
}

class _ChatBotBodyState extends State<ChatBotBody> {
  TextEditingController messageController = TextEditingController(text: "");
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> refreshHome(BuildContext context) async {
    final chatProv = Provider.of<ChatProvider>(context, listen: false);
    chatProv.sendMessage("Tes");
    ConnectionProvider.instance(context).setConnection(true);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<ConnectionProvider, ChatProvider, UserProvider>(
        builder: (context, connectionProv, chatProv, userProv, _) {
      print(chatProv.messages);
      if (connectionProv.internetConnected == false) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Tidak Ada Koneksi Internet"),
              ElevatedButton(
                onPressed: () => refreshHome(context),
                child: const Text("Refresh"),
              )
            ],
          ),
        );
      }

      if (chatProv.messages?.length == 0) {
        return SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: Container(
                      color: Color(0xFFF9F9F9),
                      child: ListView(
                        children: [
                       

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal:  40, vertical: 24 ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),                              decoration: BoxDecoration(
                                  border: Border.all(color: neutral60),
                                  borderRadius: BorderRadius.circular(20)),
                              child: AnimatedTextKit(
                                  isRepeatingAnimation: false,
                                  pause: Duration(seconds: 2000),
                                  animatedTexts: [
                                    TypewriterAnimatedText(
                                        "Halo , kamu bisa tanya aku apapun seputar kesehatan tubuh",
                                        textStyle: GoogleFonts.poppins())
                                  ]),
                            ),
                          ),
                          Center(
                            child:  Image.asset('assets/images/pandai4x.png', width: 200, height: 200,  ),
                          ) ,

                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text("Contoh Pertanyaan", style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: const Color(0xff333333),
                                      fontWeight: FontWeight.w600
                                  )),
                          ), 

                              
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      chatProv.sendMessage(
                                          "Bagaimana gerakan push up yang benar ?");
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 12),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 16),
                                      decoration: BoxDecoration(
                                        color:  Color(0xffF5F5F5),
                                        
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(
                                        "Bagaimana gerakan push up yang benar ",
                                        style: normalText.copyWith(
                                            fontSize: 14, color: blackColor , fontWeight: FontWeight.w500), 
                                      ),
                                    ),
                                  ),
                                 
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      chatProv.sendMessage(
                                          "Bagaimana gerakan push up yang benar ?");
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 12),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(
                                        color:  Color(0xffF5F5F5),
                                        
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(
                                        "Berikan saya jadwal makan untuk bulking ?",
                                        style: normalText.copyWith(
                                            fontSize: 14, color: blackColor , fontWeight: FontWeight.w500), 
                                      ),
                                    ),
                                  ),
                                 
                                ],
                              )),
                        ],
                      ))),
              MessageBar(
                messageBarColor: Colors.white,
                sendButtonColor: primaryColor,
                onSend: ((p0) async {
                  if (p0.isNotEmpty) {
                    if (p0.toLowerCase().contains("remind") ||
                        p0.toLowerCase().contains("pengingat")) {
                      await _showReminderDialog();
                      chatProv.setReminderDone(p0);
                      messageController.clear();
                    }
                    //  else if (p0.toLowerCase().contains("rekap") ||
                    //     p0.toLowerCase().contains("progres") ||
                    //     p0.toLowerCase().contains("report")) {
                    // }
                    else if (p0.toLowerCase().contains("meal plan") ||
                        p0.toLowerCase().contains("rekomendasi resep")) {
                      chatProv.showMealPlan(p0);
                      messageController.clear();
                    } else {
                      chatProv.sendMessage(p0);
                      messageController.clear();
                    }
                  }
                }),
              ),
            ],
          ),
        );
      }

      return SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Container(
              color: Color(0xFFF9F9F9),
              child: ListView.builder(
                  itemCount: chatProv.messages?.length ?? 0,
                  itemBuilder: (c, i) {
                    return CustomChatBubble(
                        text: chatProv.messages?[i].message ?? '',
                        date: '',
                        background: i % 2 == 0 ? neutral30 : primaryLightColor,
                        isSender: chatProv.messages?[i].role == 'user'
                            ? true
                            : false);
                  }),
            )),
            MessageBar(
              messageBarColor: Colors.white,
              sendButtonColor: primaryColor,
              onSend: ((p0) async {
                print('$p0');
                if (p0.isNotEmpty) {
                  if (p0.toLowerCase().contains("remind") ||
                      p0.toLowerCase().contains("pengingat")) {
                    await _showReminderDialog();
                    chatProv.setReminderDone(messageController.text);
                    messageController.clear();
                  } else if (p0.toLowerCase().contains("meal plan") ||
                      p0.toLowerCase().contains("rekomendasi resep")) {
                    chatProv.showMealPlan(p0);
                    messageController.clear();
                  } else {
                    chatProv.sendMessage(p0);
                    messageController.clear();
                  }
                }
              }),
            ),
          ],
        ),
      );
    });
  }

  // Schedule a notification based on the picked datetime
  Future<void> _scheduleNotification(DateTime scheduledTime, String msg) async {
    messageController.text =
        "Set reminder: ${scheduledTime.day} ${scheduledTime.month} ${scheduledTime.year}, ${scheduledTime.hour}:${scheduledTime.minute}";
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        icon: "@mipmap/ic_launcher");

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    var timeZone = await FlutterNativeTimezone.getLocalTimezone();
    var location = tz.getLocation(timeZone);
    var tzDateTime = tz.TZDateTime.from(scheduledTime, location);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0, 'Reminder', msg, tzDateTime, platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> _showReminderDialog() async {
    TextEditingController _messageController = TextEditingController();
    DateTime _selectedDateTime = DateTime.now();

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Pengingat'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Judul pengingat',
                ),
              ),
              SizedBox(height: 16),
              ListTile(
                title: Text('Pilih Tanggal dan Waktu'),
                subtitle: Text(
                  DateFormat.yMMMMd().add_jm().format(_selectedDateTime),
                ),
                trailing: Icon(Icons.keyboard_arrow_down),
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _selectedDateTime,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        _selectedDateTime = DateTime(
                          pickedDate.year,
                          pickedDate.month,
                          pickedDate.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );
                      });
                    }
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Set Pengingat'),
              onPressed: () async {
                if (_messageController.text.isNotEmpty) {
                  await _scheduleNotification(
                    _selectedDateTime,
                    _messageController.text,
                  );
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
