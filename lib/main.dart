import 'package:flutter/material.dart';
import 'package:hero_animation/model/person.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const Scaffold(
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final List<Person> person = [
      Person(name: "majed", age: "27", emoji: "🧑🏻‍💻"),
      Person(name: "Mark", age: "30", emoji: "👨🏻‍💼")
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("People", style: TextStyle(fontSize: 30)),
      ),
      body: ListView.builder(
        itemCount: person.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Hero(
              tag: person[index].name,
              child: Text(
                person[index].emoji,
                style: const TextStyle(fontSize: 40),
              ),
            ),
            title:
                Text(person[index].name, style: const TextStyle(fontSize: 20)),
            subtitle:
                Text(person[index].age, style: const TextStyle(fontSize: 16)),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailsPage(person: person[index]),
              ));
            },
          );
        },
      ),
    );
  }
}

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.person});
  final Person person;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          flightShuttleBuilder: (flightContext, animation, flightDirection,
              fromHeroContext, toHeroContext) {
            switch (flightDirection) {
              case HeroFlightDirection.push:
                return Material(
                    color: Colors.transparent,
                    child: ScaleTransition(
                        scale: animation.drive(Tween(begin: 0.0, end: 1.0)
                            .chain(CurveTween(curve: Curves.fastOutSlowIn))),
                        child: toHeroContext.widget));
              case HeroFlightDirection.pop:
                return Material(
                    color: Colors.transparent, child: fromHeroContext.widget);
            }
          },
          tag: widget.person.name,
          child: Text(
            widget.person.emoji,
            style: const TextStyle(fontSize: 40),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [Text(widget.person.name), Text(widget.person.age)],
        ),
      ),
    );
  }
}
