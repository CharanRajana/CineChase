import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 30,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Recommendation systems are programs that suggest recommendations to users depending on a variety of criteria. These systems estimate the most likely product that consumers will buy and that they will be interested in. Various companies like Netflix, Amazon, and other use recommender systems to help their users find the right product or movie for them.\n\nThis web application is demonstration of how recommendation system work. ',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}
