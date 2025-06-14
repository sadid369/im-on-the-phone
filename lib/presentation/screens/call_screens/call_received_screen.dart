import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CallReceivedScreen extends StatefulWidget {
  const CallReceivedScreen({Key? key}) : super(key: key);

  @override
  State<CallReceivedScreen> createState() => _CallReceivedScreenState();
}

class _CallReceivedScreenState extends State<CallReceivedScreen> {
  bool isPressLoudSpeaker = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top spacer
            const SizedBox(height: 20),
            // Avatar and name/duration
            Column(
              children: const [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xFFC57C6B),
                  child: Text(
                    'M',
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'MOM',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '1:30',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            // Buttons grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _CallOption(
                        icon: Icons.mic_off,
                        label: 'Mute',
                      ),
                      _CallOption(
                        icon: Icons.dialpad,
                        label: 'Keyboard',
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isPressLoudSpeaker = !isPressLoudSpeaker;
                          });
                        },
                        child: _CallOption(
                          icon: isPressLoudSpeaker
                              ? Icons.volume_up
                              : Icons.volume_off_sharp,
                          label: isPressLoudSpeaker ? 'Speaker' : 'Sound',
                          color: isPressLoudSpeaker ? Colors.white54 : null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      _CallOption(
                        icon: Icons.add_call,
                        label: 'Add call',
                      ),
                      _CallOption(
                        icon: Icons.videocam,
                        label: 'Video',
                      ),
                      _CallOption(
                        icon: Icons.person_add,
                        label: 'Callers',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Hang up button
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: FloatingActionButton(
                elevation: 0,
                shape: CircleBorder(),
                backgroundColor: Colors.red,
                onPressed: () {
                  context.pop();
                },
                child: const Icon(
                  Icons.call_end,
                  size: 32,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CallOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;

  const _CallOption(
      {Key? key, required this.icon, required this.label, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: color == null ? Color(0xff898989) : color,
              shape: BoxShape.circle,
              border: color == null
                  ? null
                  : Border.all(color: Colors.black.withOpacity(0.2))),
          child: Icon(
            icon,
            size: 28,
            color: color == null ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
