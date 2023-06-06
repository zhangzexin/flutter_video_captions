import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/videopage.dart';

class MyTestApp extends StatefulWidget {
  const MyTestApp({super.key});

  @override
  State<MyTestApp> createState() => _MyTestAppState();
}

class _MyTestAppState extends State<MyTestApp> {


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      backgroundColor: Colors.black,
      appBar: null,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            VideoPage(),
          ],
        ),
      ),
    ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
