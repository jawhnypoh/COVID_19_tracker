import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './views/GlobalView.dart';
import './views/USView.dart';
import './views/SearchView.dart';
import './views/CountriesView.dart';
import './views/AboutView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COVID-19 Tracker',
      theme: ThemeData.dark(
      ),
      home: HomePage(title: 'COVID-19 Tracker'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  final List<Widget> screens = [
    const SearchView(key: PageStorageKey('Search')),
    const USView(key: PageStorageKey('US')),
    const GlobalView(key: PageStorageKey('Global')),
    const CountriesView(key: PageStorageKey('Countries')),
    const AboutView(key: PageStorageKey('About')),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  int _selectedIndex = 2;

  static const TextStyle optionsStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: screens[_selectedIndex],
        bucket: bucket,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.newspaper), title: Text('Search'), // Potentially news?
          ),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.flagUsa), title: Text('Murica'),
          ),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.globeAmericas), title: Text('Global'),
          ),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.mapMarked), title: Text('Countries'),
          ),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.infoCircle), title: Text('About'),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemSelected,
      ),
    );
  }
}
