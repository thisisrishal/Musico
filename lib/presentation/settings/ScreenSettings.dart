import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:musico_scratch/custom/customTexts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSettings extends StatefulWidget {
  const ScreenSettings({Key? key}) : super(key: key);

  @override
  State<ScreenSettings> createState() => _ScreenSettingsState();
}

class _ScreenSettingsState extends State<ScreenSettings> {
  bool _toggled = false;
  @override
  void initState() {
    super.initState();
    getSwitchValues();
  }

  Future<bool> getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? _toggled = prefs.getBool("notification");

    return _toggled ?? true;
  }

  getSwitchValues() async {
    _toggled = await getSwitchState();
  }

  Future<bool> saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("notification", value);
    return prefs.setBool("notification", value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: SwitchListTile(
                          title: const Text('Notifications',
                              style: TextStyle(
                                fontSize: 25,
                              )),
                          secondary: const Icon(
                            FontAwesomeIcons.solidBell,
                          ),
                          value: _toggled,
                          onChanged: (bool value) {
                            setState(() {
                              _toggled = value;
                              saveSwitchState(value);
                              if (_toggled == true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'App need to Restart to see the Changes',
                                      style: TextStyle(),
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'App need to Restart to see the Changes',
                                    ),
                                  ),
                                );
                              }
                            });
                          },
                        ),
                      ),
                      // TextButton(onPressed: (){}, child:Column(
                      //   children: [

                      //   ],
                      // ) ),
                      GestureDetector(
                        onTap: () {
                          showAboutDialog(
                            context: context,
                            applicationName: 'Musico',
                            applicationVersion: '1.0.1',
                            children: [
                              const Text(
                                "Musico is a Offline Music Player Created by Mohammed Rishal.",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                            applicationIcon: SizedBox(
                              height: 47,
                              width: 47,
                              child: Image.asset(
                                  "assets/images/7461e3b8cc4ec795203213c851932faa.jpg"),
                            ),
                          );
                        },
                        child: richTextHead(
                          'About',
                          color: Colors.white,
                          weight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      richTextHead('Version', size: 16, color: Colors.white),
                      richTextHead('1.2.1.013',
                          size: 14, color: Colors.white60),
                      SizedBox(
                        height: 15,
                      ),
                      richTextHead('Terms and Conditions',
                          size: 16, color: Colors.white),
                      richTextHead('All the stuff you need to know',
                          size: 14, color: Colors.white60),
                      SizedBox(
                        height: 15,
                      ),
                      richTextHead('Privacy Policy',
                          size: 16, color: Colors.white),
                      richTextHead('important for both of us',
                          size: 14, color: Colors.white60),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
