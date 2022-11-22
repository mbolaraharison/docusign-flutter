import 'package:flutter/material.dart';

import 'pdf.dart';
import 'config.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.settings)),
                Tab(icon: Icon(Icons.picture_as_pdf)),
              ],
            ),
            title: const Text('Flutter Tabs Example'),
          ),
          body: const TabBarView(
            children: [
              Config(
                title: 'Config',
              ),
              InvoicePdf(
                title: 'PDF',
              ),
            ],
          ),
        ));
  }
}
