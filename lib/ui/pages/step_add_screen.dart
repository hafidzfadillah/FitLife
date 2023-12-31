import 'package:flutter/material.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:fitlife/ui/pages/record_run_screen.dart';

import '../../core/viewmodels/user/user_provider.dart';
import '../widgets/CustomAppBar.dart';
import '../widgets/input_costume.dart';

class StepAddScren extends StatefulWidget {
  const StepAddScren({Key? key}) : super(key: key);

  @override
  State<StepAddScren> createState() => _StepAddScrenState();
}

class _StepAddScrenState extends State<StepAddScren> {
  TextEditingController? step = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightModeBgColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: defMargin),
        height: 70,
        child: FloatingActionButton.extended(
            onPressed: () {
              // userProvider
              UserProvider userProvider = UserProvider();
              userProvider.storeStep(int.parse(step?.text ?? "0"));
              // toast message
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Berhasil menambah data aktivitas lari Anda '),
                ),
              );
              // delay
              Future.delayed(const Duration(seconds: 2), () {
                // pop screen
                Navigator.popAndPushNamed(context, '/home');
              });
            },
            label: Text('Simpan',
                style: normalText.copyWith(
                    color: Colors.white, fontWeight: FontWeight.w600))),
      ),
      appBar: CustomAppBar(
          title: 'Tambah data aktivitas lari manual',
          backgroundColor: lightModeBgColor,
          elevation: 0,
          leading: Card(
            elevation: 0,
            shape: const CircleBorder(),
            color: Colors.transparent,
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.arrow_back,
                    color: Color(0xff372534),
                  ),
                )),
          )),
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          Text(
            "Masukan aktivitas lari terakhir anda",
            style: normalText.copyWith(
                fontSize: 16,
                color: const Color(0xff333333),
                fontWeight: FontWeight.w500),
          ),
          CustomFormField(
            hintText: 'Contoh : 50 (langkah)',
            state: step!,
            labelText: '',
            isSecure: false,
            inputType: TextInputType.number,
          ),
        ],
      )),
    );
  }
}
