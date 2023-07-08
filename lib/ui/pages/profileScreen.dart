import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:fitlife/ui/widgets/CustomAppBar.dart';
import 'package:fitlife/ui/widgets/button.dart';

import '../../core/viewmodels/connection/connection.dart';
import '../../core/viewmodels/user/user_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    UserProvider userProvider = UserProvider();
    userProvider.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightModeBgColor,
      appBar: AppBar(
        backgroundColor: lightModeBgColor,
        elevation: 0,
        title: Text("Akun Saya",
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600)),
        // leading: IconButton(
        //   color: Color(0xff33333),
        //   icon: Icon(Icons.close, color: Colors.black, size: 30),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      body: ChangeNotifierProvider(
          create: (context) => UserProvider(), child: ProfileBody()),
    );
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({
    super.key,
  });

  Future<void> refreshHome(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    userProvider.clearUserData();
    ConnectionProvider.instance(context).setConnection(true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ConnectionProvider, UserProvider>(
        builder: (context, connectionProv, userProvider, child) {
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

      if (userProvider.user == null && !userProvider.onSearch) {
        userProvider.getUserData();

        return Center(child: const CircularProgressIndicator());
      }
      if (userProvider.user == null && userProvider.onSearch) {
        // if the categories are being searched, show a skeleton loading
        return Center(child: const CircularProgressIndicator());
      }
      return SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 104,
                        height: 104,
                        decoration: BoxDecoration(
                          color: Color(0xff9EF07B),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Image.asset(
                            "assets/images/avatar_dummy.png",
                            width: 64,
                            height: 64,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        userProvider.user?.name ?? "",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      userProvider.user?.isVip == 1
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Vip Hingga",
                                  style: GoogleFonts.poppins(
                                      color: Color(0xff484848),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(" 10/08/2023",
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600))
                              ],
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
              "Badge",
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.w600),
            )),
                Text(" Lihat Semua",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color:  primaryDarkColor))

              
              ],
            ),
            
            SizedBox(
              height: 20,
            ),
            Container(
              height:  70,
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
            
                scrollDirection:  Axis.horizontal,
            
                children: [
                  
                  
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child:                   Image.asset("assets/images/badge_dummy_1.png", width: 70, height: 70, fit: BoxFit.cover,),
               
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child:                   Image.asset("assets/images/badge_dummy_2.png", width: 70, height: 70, fit: BoxFit.cover,),
               
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child:                   Image.asset("assets/images/badge_dummy_3.png", width: 70, height: 70, fit: BoxFit.cover,),
               
                  ),
               

                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "General",
              style: headerTextStyle.copyWith(
                  fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Row(
                          children: [
                            Image.asset("assets/images/edit_profile_icon.png",
                                width: 30, height: 30),
                            SizedBox(width: 10),
                            Text("Edit Data Diri",
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                          ],
                        )),
                    Icon(Icons.arrow_right_rounded, size: 30),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        Image.asset("assets/images/privacy_icon.png",
                            width: 30, height: 30),
                        SizedBox(width: 10),
                        Text("Privacy  And Policy ",
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                      ],
                    )),
                    Icon(Icons.arrow_right_rounded, size: 30),
                  ],
                ),
                SizedBox(height: 5),
                  Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                            onTap: () async {
                        SharedPreferences localStorage =
                            await SharedPreferences.getInstance();

                        // AddressProvider.instance(context).clearAddress();
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        await preferences.clear();

                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (route) => false);
                      },
                          child: Row(
                                              children: [
                          Image.asset("assets/images/exit_account_Icon.png",
                              width: 30, height: 30),
                          SizedBox(width: 10),
                          Text("Keluar Akun ",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                                              ],
                                            ),
                        )),
                    Icon(Icons.arrow_right_rounded, size: 30),
                  ],
                ),
               
              ],
            )
          ],
        ),
      );
    });
  }
}
