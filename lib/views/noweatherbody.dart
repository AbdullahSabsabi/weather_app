import 'package:flutter/material.dart';

class NoWeatherBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'there is no weather.  ',
            style: TextStyle(fontSize: 30),
          ),
          Text(
            'start searching now please ',
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }
}
