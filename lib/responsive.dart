import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? lassmobile;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
    this.lassmobile,
  }) : super(key: key);

// This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, isDesktop help us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 850;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // If our width is more than 1100 then we consider it a desktop
    if (size.width >= 1100) {
      print('desktop');
      return desktop;
    }
    // If width it less then 1100 and more then 850 we consider it as tablet
    else if (size.width >= 1000 && tablet != null) {
      print('tablet');
      return tablet!;
    } else if (size.width <= 630.0) {
      return lassmobile!;
    }
    // Or less then that we called it mobile
    else {
      print('mobile');
      return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        double maxWidth = constraints.maxWidth;
        print('_size.width ${size.width}');
        print('mobile $maxWidth');
        return mobile;
      });
    }
  }
}
