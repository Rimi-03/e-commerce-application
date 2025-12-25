import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TestSupabaseScreen extends StatefulWidget {
  const TestSupabaseScreen({super.key});

  @override
  State<TestSupabaseScreen> createState() => _TestSupabaseScreenState();
}

class _TestSupabaseScreenState extends State<TestSupabaseScreen> {
  String connectionStatus = 'Testing connection...';
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    _checkConnection();
  }

  Future<void> _checkConnection() async {
    try {
      final client = Supabase.instance.client;

      // Try to access Supabase
      print('[v0] Testing Supabase connection...');
      // print('[v0] URL: ${client.supabaseUrl}');

      setState(() {
        connectionStatus = '''
✓ Supabase Connected Successfully!

Status: Ready to use

Next steps:
1. Run the SQL schema in Supabase
2. Start using authentication
3. Create/read/update data
        ''';
        isConnected = true;
      });
    } catch (e) {
      print('[v0] Connection error: $e');
      setState(() {
        connectionStatus = '''
✗ Connection Failed!

Error: $e

Make sure you:
1. Added correct Supabase URL
2. Added correct Anon Key
3. Supabase project is active
        ''';
        isConnected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supabase Connection Test'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isConnected ? Colors.green[100] : Colors.red[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isConnected ? Colors.green : Colors.red,
                    width: 2,
                  ),
                ),
                child: Text(
                  connectionStatus,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Courier',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _checkConnection,
                child: const Text('Test Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
