import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String thumbnailUrl;
  const DetailScreen({Key? key, required this.thumbnailUrl}) : super(key: key);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Center(
                  child: Image.network(
                    widget.thumbnailUrl,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              MaterialButton(
                minWidth: 200.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0)),
                height: 35,
                color: Colors.lightBlueAccent,
                child: const Text('go back',
                    style: TextStyle(fontSize: 16.0, color: Colors.white)),
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
