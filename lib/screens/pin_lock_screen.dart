import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';

class PinLockScreen extends StatefulWidget {
  const PinLockScreen({super.key});

  @override
  State<PinLockScreen> createState() => _PinLockScreenState();
}

class _PinLockScreenState extends State<PinLockScreen> {
  String _enteredPin = '';
  final String _correctPin = '1234';
  String _errorMessage = '';

  void _onKeyTap(String value) {
    if (_enteredPin.length < 4) {
      setState(() {
        _enteredPin += value;
      });

      if (_enteredPin.length == 4) {
        _validatePin();
      }
    }
  }

  void _onBackspace() {
    if (_enteredPin.isNotEmpty) {
      setState(() {
        _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
      });
    }
  }

  void _validatePin() {
    if (_enteredPin == _correctPin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      HapticFeedback.vibrate();
      setState(() {
        _errorMessage = 'Incorrect PIN';
        _enteredPin = '';
      });
    }
  }

  Widget _buildPinDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        bool filled = index < _enteredPin.length;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: filled ? Colors.green : Colors.white30,
          ),
        );
      }),
    );
  }

  Widget _buildKeypadButton(String value, {IconData? icon, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap ?? () => _onKeyTap(value),
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 70,
        height: 70,
        alignment: Alignment.center,
        child: icon != null
            ? Icon(icon, color: Colors.green, size: 26)
            : Text(
                value,
                style: const TextStyle(fontSize: 24, color: Colors.green, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0), // Reddish background like screenshot
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Image.asset('../../assets/icons/T.png', height: 60),
            const SizedBox(height: 30),
            const Text(
              'Enter your login PIN',
              style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            _buildPinDots(),
            const SizedBox(height: 10),
            Text(
              _errorMessage,
              style: const TextStyle(color: Colors.red, fontSize: 14),
            ),
            const SizedBox(height: 16),
            const Text(
              'Forgot PIN?',
              style: TextStyle(color: Colors.green, fontSize: 14),
            ),
            const SizedBox(height: 30),

            // KEYPAD
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var row in [
                      ['1', '2', '3'],
                      ['4', '5', '6'],
                      ['7', '8', '9'],
                    ])
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: row.map((e) => _buildKeypadButton(e)).toList(),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildKeypadButton('', icon: Icons.fingerprint, onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Fingerprint coming soon')),
                          );
                        }),
                        _buildKeypadButton('0'),
                        _buildKeypadButton('', icon: Icons.backspace, onTap: _onBackspace),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
