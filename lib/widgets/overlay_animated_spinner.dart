import 'package:anexpress/core/styles/app_colors.dart';
import 'package:anexpress/core/values/local_files.dart';
import 'package:flutter/material.dart';

class OverLayAnimatedSpinner extends StatefulWidget {
  const OverLayAnimatedSpinner({Key? key}) : super(key: key);

  @override
  State<OverLayAnimatedSpinner> createState() => _OverLayAnimatedSpinnerState();
}

class _OverLayAnimatedSpinnerState extends State<OverLayAnimatedSpinner>
    with TickerProviderStateMixin {
  AnimationController? anim;

  @override
  void initState() {
    super.initState();

    anim =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  dispose() {
    anim!.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    anim!.forward();
    return Center(
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0)
              .animate(CurvedAnimation(parent: anim!, curve: Curves.easeInOut)),
          child: SlideTransition(
            position: Tween<Offset>(
                    begin: const Offset(0.0, 0.25), end: const Offset(0.0, 0.0))
                .animate(
                    CurvedAnimation(parent: anim!, curve: Curves.easeInOut)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.whiteA700.withOpacity(0.3)),
                      strokeWidth: 4,
                    ),
                  ),
                ),
                Center(
                    child: Opacity(
                  opacity: 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(LocalFiles.imgAnExpressLogo,
                        width: 30, height: 30, fit: BoxFit.contain),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
