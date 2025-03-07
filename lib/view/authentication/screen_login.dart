import 'package:flutter/material.dart';
import 'package:flutter_task/view/home/screen_home.dart';

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              _showBottomSheet(context);
            },
            child: const Text('Login')),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Makes it take only necessary space
            children: [
              const Text("Modal BottomSheet",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text("This is a simple bottom sheet."),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (ctx)=>const ScreenHome( ))),
                child: const Text("GO to home screen"),
              ),
            ],
          ),
        );
      },
    );
  }
}
