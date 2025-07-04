import 'package:flutter/material.dart';
import 'dart:math'; // For pi

class CardFlipper extends StatefulWidget {
  final String imageUrl;

  const CardFlipper({super.key, required this.imageUrl});

  @override
  State<CardFlipper> createState() => _CardFlipperState();
}

class _CardFlipperState extends State<CardFlipper> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    )..addListener(() {
        setState(() {});
      });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
        // Toggle the front/back state after the animation completes
        setState(() {
          _showFront = !_showFront;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_controller.status == AnimationStatus.completed || _controller.status == AnimationStatus.dismissed) {
      if (_showFront) {
        _controller.forward(); // Flip from front to back
      } else {
        _controller.reverse(); // Flip from back to front
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double angle = _animation.value * pi; // Rotate 0 to pi (180 degrees)
    final double flipFactor = _showFront ? angle : angle - pi; // Adjust angle for the back

    return GestureDetector(
      onTap: _flipCard,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001) // Add perspective
          ..rotateY(flipFactor), // Rotate around Y axis
        child: _showFront
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.network(widget.imageUrl, fit: BoxFit.contain),
              ) // Front image
            : Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(pi), // Rotate back image to face front after flip
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.network(widget.imageUrl, fit: BoxFit.contain),
                ), // Back image
              ),
      ),
    );
  }
}
