import 'package:flutter/material.dart';

class Demo extends StatelessWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('demo title'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Wrap(
          children: [
            Container(
              height: 300,
              color: Colors.purple,
            ),
            // Column(
            //   children: [
            //     ListTile(
            //       tileColor: Colors.red,
            //       leading: Icon(Icons.abc),
            //       title: Text('data'),
            //     ),
            //     ListTile(
            //       tileColor: Colors.green,
            //       leading: Icon(Icons.access_alarm_rounded),
            //       title: Text('dskfjj'),
            //     ),
            //   ],
            // ),
            Expanded(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                // shrinkWrap: true,

                itemCount: 50,
                itemBuilder: (context, index) => ListTile(
                  tileColor: Colors.yellow,
                  leading: Icon(Icons.key_off),
                  title: Text('${index}'),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}