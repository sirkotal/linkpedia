import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () => {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()))
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const SettingsPage()))
          },
        ),
      ],
      iconTheme: const IconThemeData(
        color: Colors.deepPurple,
        size: 36.0,
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2.0),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.deepPurple,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
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
