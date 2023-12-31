import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:fitlife/ui/widgets/button.dart';

class ExerciseSchedule extends StatefulWidget {
  final List<Map<String, dynamic>> exercises;
  final int isPremium;

  const ExerciseSchedule(
      {super.key, required this.exercises, required this.isPremium});

  @override
  State<ExerciseSchedule> createState() => _ExerciseScheduleState();
}

class _ExerciseScheduleState extends State<ExerciseSchedule> {
  int currentWeek = 0;
  int selectedDay = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                'Minggu 1',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: subheaderSize),
              ),
              const Spacer(),
              Visibility(
                  child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    iconSize: 16,
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  IconButton(
                    onPressed: () {},
                    iconSize: 16,
                    icon: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ))
            ],
          ),
          Container(
            height: 15.h,
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: widget.exercises[currentWeek]["days"].length,
              itemBuilder: (c, i) {
                int status = widget.exercises[currentWeek]["days"][i]['status'];
                int day = widget.exercises[currentWeek]["days"][i]["day"];

                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedDay = i;
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(defRadius),
                        color:
                            Color(i == selectedDay ? 0xffEDF8F4 : 0xffFFFFFF)),
                    child: Column(
                      children: [
                        widget.exercises[currentWeek]["days"][i]['status'] == 0
                            ? const Icon(
                                Icons.lock,
                                color: Color(0xffCECECE),
                                size: 32,
                              )
                            : Icon(
                                Icons.check_circle,
                                color: status == 2
                                    ? Color(0xffF9D171)
                                    : const Color(0xffCECECE),
                                size: 32,
                              ),
                        const Spacer(),
                        Text(
                          "Hari $day",
                          style: i == selectedDay
                              ? GoogleFonts.poppins(fontWeight: FontWeight.w600)
                              : GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffC8C8C8)),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Visibility(
                            visible: i == selectedDay,
                            child: Container(
                              height: 2,
                              margin: EdgeInsets.symmetric(horizontal: 1.h),
                              decoration: BoxDecoration(
                                  color: Color(0xffF9D171),
                                  borderRadius: BorderRadius.circular(4)),
                            ))
                      ],
                    ),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 1.h,
                  childAspectRatio: 0.7),
            ),
          ),
          RoundedButton(
              title: 'Mulai olahraga terencana',
              style: GoogleFonts.poppins(color: Colors.white),
              background: Color(0xffF9D171),
              onClick: () {
                print(widget.isPremium);
                if (widget.exercises[currentWeek]['days'][selectedDay]
                        ['status'] !=
                    0) {
                  // if (widget.isPremium == 0) {
                  //   Navigator.pushNamed(
                  //     context,
                  //     '/premium',
                  //   );
                  // } else {
                    Navigator.pushNamed(context, '/list-sport',
                        arguments: widget.exercises[currentWeek]['days']
                            [selectedDay]);
                  // }
                } else {
                  Fluttertoast.showToast(
                      msg: 'Selesaikan sesi sebelumnya terlebih dahulu');
                }
              },
              width: double.infinity),
          SizedBox(
            height: 2.h,
          ),
          RoundedOutlineButton(
              title: 'Catat aktivitas Manual',
              style: GoogleFonts.poppins(color: Color(0xffF9D171)),
              color: Color(0xffF9D171),
              onClick: () {
                Navigator.pushNamed(context, '/input-sport');
              },
              width: double.infinity),
        ],
      ),
    );
  }
}
