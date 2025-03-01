import 'package:emendo/common/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingWidget: IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
        ),
        title: Text("Workflow"),
        actionButton: IconButton(
          onPressed: () {},
          icon: Icon(Icons.crop_landscape),
        ),
      ),
    );
  }
}
