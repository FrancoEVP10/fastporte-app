import 'package:fastporte_app/contracts/screens/screens.dart';
import 'package:fastporte_app/home/home_screen.dart';
import 'package:fastporte_app/static/support_screen.dart';
import 'package:fastporte_app/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:fastporte_app/globals.dart' as globals;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final screens = [
    HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('FastPorte'),
      ),
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          //Aqui se pondrian los screens
          HomeScreen(),
          Container(color: Colors.red,),
          if (globals.role == 'cliente')
            UserContractsScreen(),
          if (globals.role == 'transportista')
            HistoryScreen(),
          SupportScreen(),
        ],
      ),
      bottomNavigationBar: BounceTapBar(
        onTabChanged: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Color.fromRGBO(26, 204, 141, 1),
        items: const [
          Icon(Icons.home, color: Colors.white,),
          Icon(Icons.local_shipping_rounded, color: Colors.white,),
          Icon(Icons.menu_book_rounded, color: Colors.white,),
          Icon(Icons.question_mark_outlined, color: Colors.white,),
        ],
      ),
    );
  }
}

class BounceTapBar extends StatefulWidget {
  const BounceTapBar({
    Key? key, 
    this.backgroundColor = const Color.fromRGBO(26, 204, 141, 1), 
    required this.items,
    required this.onTabChanged,
    this.initialIndex = 0,
    this.movement = 30,
  }) : super(key: key);
  final Color backgroundColor;
  final List<Widget> items;
  final ValueChanged<int> onTabChanged;
  final int? initialIndex;
  final double movement;

  @override
  State<BounceTapBar> createState() => _BounceTapBarState();
}

class _BounceTapBarState extends State<BounceTapBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animCircleItem;
  late Animation _animElevationIn;
  late Animation _animElevationOut;

  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex ?? 0;
    _controller = AnimationController(
      vsync: this, 
      duration: const Duration(
        milliseconds: 1200
      )
    );

    _animCircleItem = CurveTween(
      curve: Interval(
        0.1,
        0.5,
      ),
    ).animate(_controller);

    _animElevationIn = CurveTween(
      curve: Interval(
        0.3,
        0.5,
        curve: Curves.bounceOut,
      ),
    ).animate(_controller);

    _animElevationOut = CurveTween(
      curve: Interval(
        0.55,
        1.0,
        curve: Curves.bounceOut,
      ),
    ).animate(_controller);

    _controller.forward(from: 1.0);
  }

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double currentWidth = width;
    double currentElevation = 0.0;
    final movement = widget.movement;
    return SizedBox(
      height: 56.0,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _){

          currentWidth = width;
          currentElevation = -movement * _animElevationIn.value + (movement - 56.0/4) * _animElevationOut.value;

          return Center(
            child: Container(
              width: currentWidth,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.vertical(
                top: Radius.circular(20)
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(widget.items.length, (index) {
                final child = widget.items[index];
                final innerWidget = CircleAvatar(
                        radius: 30.0,
                        backgroundColor: widget.backgroundColor,
                        child: child,
                      );
                if (index == _currentIndex){
                return Expanded(
                  child: CustomPaint(
                      foregroundPainter: _CircleItemPainter(_animCircleItem.value),
                      child: Transform.translate(
                        offset: Offset(0.0, currentElevation),
                        child: innerWidget,
                      ),
                    ),
                );
                }else{
                  return Expanded(
                    child: GestureDetector(
                    onTap: () {
                      widget.onTabChanged(index);
                      setState(() {
                        _currentIndex = index;
                      });
                      _controller.forward(from: 0.0);
                    },
                    child: innerWidget,
                    ),
                  );
                }
              },) 
            ),
            ),
          );
        },
      ),
    );
  }
}

class _CircleItemPainter extends CustomPainter {

  final double progress;

  _CircleItemPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size){
    final center = Offset(size.width / 2, size.height / 2);
    final radius = 20.0 * progress;
    const strokeWidth = 10.0;
    final currentStrokeWidth = strokeWidth * (1 - progress);
    if(progress < 1.0){
      canvas.drawCircle(center, radius, Paint()
      ..color=Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = currentStrokeWidth,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}