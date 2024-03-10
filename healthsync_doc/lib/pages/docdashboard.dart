import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
// ignore: unused_import
import 'addPrescrition.dart';
import 'manageAppo.dart';
import 'docprofile.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
      case 1:
        page = AppointmentScreen(mobile: 'asd',memberId: 'san');
      case 2:
        page = MyProfile();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                    NavigationRailDestination(
                    icon: Icon(Icons.manage_history),
                    label: Text('Manage Appointment'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.health_and_safety),
                    label: Text('Profile'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}
//////////1st Pages

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     const String appTitle = 'Welcome Doctor Sagarika';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        // #docregion addWidget
        body: const SingleChildScrollView(
          child: Column(
            children: [
              ImageSection(
                image: '/Users/dream/Home/SandipaCapstoneProj/navigation_proj/images/HelthSync.png',
              ),
              TitleSection(
                name: 'Patient Name: Krishna Prasad',
                location: 'Kolkata,Westbengal',
              ),
               ButtonSection(),
              TextSection(
                description:

                    'Very good doctor and kind at heart. Gives maximum time '
                    'o hear patient views. His clinical diagnosis is very sharp. '
                    'Most of the times he avoids surgery and does not do  '
                    'unnecessary surgeries. And, after treatment, '
                    'he himself calls the patients and follow up their condition'
                    'which is a rare quality we see in doctors nowadays. Thank you ',
              ),
        
              TitleSection(
                name: 'Next Apponiments...',
                location: 'On : 10th March,20024 from 10AM to 11PM',
              ),
            AppSection(
                name: 'Name: Basudeb Basu',
                location: 'Appolo Clinic, Baraha Nagar',
              ),
              AppSection(
                name: 'Name: Sanjib Das',
                location: 'Appolo Clinic, Baraha Nagar',
              ),
              AppSection(
                name: 'Name: Divya Ramesh',
                location: 'Appolo Clinic, Baraha Nagar',
              ),
            ],
          ),
        ),
        // #enddocregion addWidget
      ),
    );
  }
}
class TitleSection extends StatelessWidget {
  const TitleSection({
    super.key,
    required this.name,
    required this.location,
  });

  final String name;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  location,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          // #docregion Icon

          // #enddocregion Icon
         //const Text('41'),
        ],
      ),
    );
  }
}

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ButtonWithText(
            color: color,
            icon: Icons.call,
            label: 'CALL',
          ),
          ButtonWithText(
            color: color,
            icon: Icons.near_me,
            label: 'ROUTE',
          ),
          ButtonWithText(
            color: color,
            icon: Icons.share,
            label: 'SHARE',
          ),
        ],
      ),
    );
  }
}

class ButtonWithText extends StatelessWidget {
  const ButtonWithText({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
  });

  final Color color;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class TextSection extends StatelessWidget {
  const TextSection({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        description,
        softWrap: true,
      ),
    );
  }
}
class AppSection extends StatelessWidget {
  const AppSection({
    super.key,
    required this.name,
    required this.location,
  });

  final String name;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  location,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
           
          // #docregion Icon
            ElevatedButton.icon(
                onPressed: () {
                   //_selectDate(context);
                  // addItemToList();
                   Navigator.push(
              context,
             MaterialPageRoute(builder: (context) => RecordAddPage(mobile: 'asd',memberId: 'san')),
                   );
                },
                 icon: Icon(Icons.next_plan),
                label: Text('Start'),
              ),
              
              ElevatedButton.icon(
                onPressed: () {
                   //_selectDate(context);
                  // addItemToList();
                   //Navigator.push(
             // context,
             //MaterialPageRoute(builder: (context) => RecordAddPage(mobile: 'asd',memberId: 'san')),
                //   );
                },
                 icon: Icon(Icons.share),
                label: Text('Share Prescription'),
              ),


        ],
      ),
    );
  }
}

// #docregion ImageSection
class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    // #docregion Image-asset
    return Image.asset(
      image,
      width: 600,
      height: 240,
      fit: BoxFit.cover,
    );
    // #enddocregion Image-asset
  }
}
// #enddocregion ImageSection

/////////End of 1st page
class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}