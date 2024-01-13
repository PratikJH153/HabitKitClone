import 'package:flutter/material.dart';
import 'package:habittracker/theme/theme.dart';

class DialogBoxWidget extends StatelessWidget {
  final String title;
  final String des;
  final String firstButton;
  final String secondButton;
  final VoidCallback firstOnTap;
  final VoidCallback secondOnTap;
  const DialogBoxWidget({
    required this.title,
    required this.des,
    required this.firstButton,
    required this.secondButton,
    required this.firstOnTap,
    required this.secondOnTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(des),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                    ),
                    onPressed: firstOnTap,
                    child: Text(firstButton),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: secondOnTap,
                    child: Text(secondButton),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
