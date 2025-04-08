// Importing core libraries
import 'dart:io';
import 'dart:math';
int astronauts = 1;


  //https://dart.cn/language/#variables
void my_variables(){
    var name = 'Voyager I';
    var year = 1977;
    var antennaDiameter = 3.7;
    var flybyObjects = ['Jupiter', 'Saturn', 'Uranus', 'Neptune'];
    var image = {
    'tags': ['saturn'],
    'url': '//path/to/saturn.jpg',
    };
    control_flow_statements(year, flybyObjects);
}

  //https://dart.cn/language/#contol-flow-statements
void control_flow_statements(year,flybyObjects){
  if (year >= 2001) {
    print('21st century');
  } else if (year >= 1901) {
    print('20th century');
  }

  for (final object in flybyObjects) {
   print(object);
  }

  for (int month = 1; month <= 12; month++) {
   print(month);
  }

  while (year < 2016) {
   year += 1;
  }
}

//https://dart.cn/language/#functions
int fibonacci(int n) {
  if (n == 0 || n == 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

//https://dart.cn/language/#classes
class Spacecraft {
  String name;
  DateTime? launchDate;

  // Read-only non-final property
  int? get launchYear => launchDate?.year;

  // Constructor, with syntactic sugar for assignment to members.
  Spacecraft(this.name, this.launchDate) {
    // Initialization code goes here.
  }

  // Named constructor that forwards to the default one.
  Spacecraft.unlaunched(String name) : this(name, null);

  // Method.
  void describe() {
    print('Spacecraft: $name');
    // Type promotion doesn't work on getters.
    var launchDate = this.launchDate;
    if (launchDate != null) {
      int years = DateTime.now().difference(launchDate).inDays ~/ 365;
      print('Launched: $launchYear ($years years ago)');
    } else {
      print('Unlaunched');
    }
  }
}

//https://dart.cn/language/#enums

enum PlanetType { terrestrial, gas, ice }

/// Enum that enumerates the different planets in our solar system
/// and some of their properties.
enum Planet {
  mercury(planetType: PlanetType.terrestrial, moons: 0, hasRings: false),
  venus(planetType: PlanetType.terrestrial, moons: 0, hasRings: false),
  earth(planetType: PlanetType.terrestrial, moons: 1, hasRings: false),
  // ···
  uranus(planetType: PlanetType.ice, moons: 27, hasRings: true),
  neptune(planetType: PlanetType.ice, moons: 14, hasRings: true);

  /// A constant generating constructor
  const Planet({
    required this.planetType,
    required this.moons,
    required this.hasRings,
  });

  /// All instance variables are final
  final PlanetType planetType;
  final int moons;
  final bool hasRings;

  /// Enhanced enums support getters and other methods
  bool get isGiant =>
      planetType == PlanetType.gas || planetType == PlanetType.ice;
}

//https://dart.cn/language/#inheritance
class Orbiter extends Spacecraft {
  double altitude;
  Orbiter(super.name, DateTime super.launchDate, this.altitude);
}

//https://dart.cn/language/#mixins
mixin Piloted {
  int astronauts = 1;
  
  void describeCrew() {
    print('Number of astronauts: $astronauts');
  }
  
}



class PilotedCraft extends Spacecraft with Piloted {
  PilotedCraft(super.name, super.launchDate); // 需要构造函数
}

class MockSpaceship implements Spacecraft {
  @override
  String name;
  
  @override
  DateTime? launchDate;
  
  MockSpaceship(this.name, this.launchDate);
  
  @override
  void describe() => print("Mock: $name");
  
  @override
  int? get launchYear => launchDate?.year;
}

abstract class Describable {
  void describe();

  void describeWithEmphasis() {
    print('=========');
    describe();
    print('=========');
  }
}

//https://dart.cn/language/#async
const oneSecond = Duration(seconds: 1);
// ···
Future<void> printWithDelay(String message) async {
  await Future.delayed(oneSecond);
  print(message);
}

Future<void> createDescriptions(Iterable<String> objects) async {
  for (final object in objects) {
    try {
      var file = File('$object.txt');
      if (await file.exists()) {
        var modified = await file.lastModified();
        print(
          'File for $object already exists. It was modified on $modified.',
        );
        continue;
      }
      await file.create();
      await file.writeAsString('Start describing $object in this file.');
    } on IOException catch (e) {
      print('Cannot create description for $object: $e');
    }
  }
}

Stream<String> report(Spacecraft craft, Iterable<String> objects) async* {
  for (final object in objects) {
    await Future.delayed(oneSecond);
    yield '${craft.name} flies by $object';
  }
}



Future<void> describeFlybyObjects(List<String> flybyObjects) async {
  try {
    for (final object in flybyObjects) {
      var description = await File('$object.txt').readAsString();
      print(description);
    }
  } on IOException catch (e) {
    print('Could not describe object: $e');
  } finally {
    flybyObjects.clear();
  }
}


//main函数
void main(List<String> arguments) {
    print('Hello, World!');

    my_variables();
    var result = fibonacci(20);
    var voyager = Spacecraft('Voyager I', DateTime(1977, 9, 5));
    voyager.describe();
    var voyager3 = Spacecraft.unlaunched('Voyager III');
    voyager3.describe();

    final yourPlanet = Planet.earth;
  
    if (!yourPlanet.isGiant) {
       print('Your planet is not a "giant planet".');
     }
    if (astronauts == 0) {
    throw StateError('No astronauts.');
}
}