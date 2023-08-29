// import 'package:flutter/material.dart';
//
// void main() => runApp(const LearnContext());
//
// class LearnContext extends StatelessWidget {
//   const LearnContext({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: const HomePage(),
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.dark(useMaterial3: true),
//       themeMode: ThemeMode.dark,
//     );
//   }
// }
//
//
// class Example extends StatelessWidget {
//   const Example({super.key});
//
//   static void nextScreen(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const ExampleScreen(),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: OutlinedButton(
//             onPressed: () => nextScreen(context),
//             child: const Text("Example Screen"),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class ExampleScreen extends StatelessWidget {
//   const ExampleScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: SafeArea(
//         child: ColoredWidget(
//           initialColor: Colors.teal,
//           child: Padding(
//             padding: const EdgeInsets.all(40),
//             child: ColoredWidget(
//               key: key,
//               initialColor: Colors.green,
//               child: const Padding(
//                 padding: EdgeInsets.all(40),
//                 child: ColorButton(),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class ColoredWidget extends StatefulWidget {
//   final Widget child;
//   final Color initialColor;
//
//   const ColoredWidget({
//     required this.child,
//     required this.initialColor,
//     super.key,
//   });
//
//   @override
//   State<ColoredWidget> createState() => _ColoredWidgetState();
// }
//
// class _ColoredWidgetState extends State<ColoredWidget> {
//   late Color color;
//
//   @override
//   void initState() {
//     color = widget.initialColor;
//     super.initState();
//   }
//
//   void changeColor(Color color) {
//     setState(() {
//       this.color = color;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ColoredBox(
//       color: color,
//       child: widget.child,
//     );
//   }
// }
//
// class ColorButton extends StatelessWidget {
//   const ColorButton({super.key});
//
//   void _onPressed(BuildContext context) {
//     final state = context.findAncestorStateOfType<_ColoredWidgetState>();
//     if (state != null) {
//       state.changeColor(Colors.black);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ColoredWidget(
//       initialColor: Colors.blue,
//       child: Center(
//         child: OutlinedButton(
//           onPressed: () => _onPressed(context),
//           child: const Text("Tap"),
//         ),
//       ),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => HomePageState();
// }
//
// class HomePageState extends State<HomePage> {
//   void tap() {
//
//     text2 = text1;
//     setState(() {});
//   }
//
//   String text1 = 'void func';
//   String text2 = 'state less';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ButtonStateless(),
//             SizedBox(height: 20),
//             ButtonStateless(),
//             SizedBox(height: 20),
//             ButtonStateless(),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ButtonStateless extends StatelessWidget {
//   const ButtonStateless({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final stateHomePage = context.findAncestorStateOfType<HomePageState>();
//     return ElevatedButton(
//       onPressed: () => stateHomePage?.tap(),
//       child: Text(stateHomePage?.text2 ?? ''),
//     );
//   }
// }






import 'package:flutter/material.dart';

void main() => runApp(const LearnInherited());

class ValueProvider extends InheritedWidget {
  final int value;

  const ValueProvider({required this.value, super.key, required super.child});

  @override
  bool updateShouldNotify(ValueProvider oldWidget) {
    return oldWidget.value != value;
  }
}

class LearnInherited extends StatelessWidget {
  const LearnInherited({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int value = 0;

  void increment() => setState(() => ++value);

  void decrement() => setState(() => --value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton.filled(
                    onPressed: increment, icon: const Icon(Icons.add)),
                IconButton.filled(
                    onPressed: decrement, icon: const Icon(Icons.remove)),
              ],
            ),
            const SizedBox(height: 10),
            ValueProvider(
              value: value,
              child: const One(),
            ),
          ],
        ),
      ),
    );
  }
}

class One extends StatelessWidget {
  const One({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("One."),
        Two(),
      ],
    );
  }
}

class Two extends StatelessWidget {
  const Two({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Two."),
        Three(),
      ],
    );
  }
}

class Three extends StatefulWidget {
  const Three({Key? key}) : super(key: key);

  @override
  State<Three> createState() => _ThreeState();
}

class _ThreeState extends State<Three> {
  int get value {
    final provider = context.dependOnInheritedWidgetOfExactType<ValueProvider>();
    return provider?.value ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Three."),
        Text("Value: $value"),
      ],
    );
  }
}




















