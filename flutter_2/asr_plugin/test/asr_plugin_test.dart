import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:asr_plugin/asr_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('asr_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await AsrPlugin.platformVersion, '42');
  });
}
