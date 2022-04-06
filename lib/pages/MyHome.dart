import 'package:flutter/material.dart';
import 'package:musico_scratch/custom/customTexts.dart';
import 'package:musico_scratch/pages/PageSongs.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.settings))
          ],
          bottom: TabBar(
            controller: _tabController,
            labelPadding: EdgeInsets.only(bottom: 20, top: 10),
            tabs: [
              richTextHead('Songs'),
              richTextHead('Artists'),
              richTextHead('Albums'),
              richTextHead('Playlists')
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            controller: _tabController,
            children: [
              PageSongs(),
              PageSongs(),
              PageSongs(),
              PageSongs(),
            ],
          ),
        ),
      ),
    );
  }
}
