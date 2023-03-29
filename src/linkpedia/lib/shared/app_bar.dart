import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const TopBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage()))
            },
          ),
          title: Text(title),
          iconTheme: const IconThemeData(
            color: Colors.white,
            size: 36.0,
          ),
          backgroundColor: Colors.deepPurple,
          elevation: 0.0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.elliptical(50, 25),
            ),
          ),
        ),
        ClipPath(
          clipper: BottomLeftArcClipper(),
          child: Container(
            color: Colors.deepPurple,
            height: kToolbarHeight,
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class BottomLeftArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    const rad = Radius.elliptical(75, 50);

    path.lineTo(0, size.height);
    path.lineTo(0, rad.y);
    path.arcToPoint(
      Offset(rad.x, 0),
      radius: rad,
      clockwise: true,
    );
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
