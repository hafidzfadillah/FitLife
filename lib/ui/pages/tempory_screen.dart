import "package:flutter/material.dart";

class TemporyScreen extends StatelessWidget {
  const TemporyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  Column(children: [
          Text("Tempory Screen"),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/water-record'); 
            },
            child: const Text('Go to Drink water screen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/vita-pulse'); 
            },
            child: const Text('Go to Drink Mission health screen'),
          ),
           ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/shop');
          },
          child: const Text('Go to Shop'),
        ),
        
        ],)
      )
    );
  }
}
