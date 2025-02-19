import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:utility_module/jail_broken_detector.dart';
import 'package:utility_module/utitlity_constants.dart';
import 'jail_broken_test.mocks.dart';

@GenerateMocks([MethodChannel])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockMethodChannel mockChannel;
  late JailbreakDetection jailbreakDetection;

  const String jailBrokenMethod = UtilityMethodChannel.jailBroken;
  const String developerModeMethod = UtilityMethodChannel.developerMode;

  setUp(() {
    mockChannel = MockMethodChannel();
    jailbreakDetection = JailbreakDetection(mockChannel);
  });

  group('JailbreakDetection Tests with Mockito', () {
    test('jailbroken returns true when channel returns true', () async {
      when(mockChannel.invokeMethod<bool>(jailBrokenMethod))
          .thenAnswer((_) async => true);

      bool result = await jailbreakDetection.jailbroken;

      expect(result, isTrue);
      verify(mockChannel.invokeMethod<bool>(jailBrokenMethod)).called(1);
    });

    test('jailbroken returns false when channel returns false', () async {
      when(mockChannel.invokeMethod<bool>(jailBrokenMethod))
          .thenAnswer((_) async => false);

      bool result = await jailbreakDetection.jailbroken;

      expect(result, isFalse);
      verify(mockChannel.invokeMethod<bool>(jailBrokenMethod)).called(1);
    });

    test('jailbroken returns true when channel returns null', () async {
      when(mockChannel.invokeMethod<bool>(jailBrokenMethod))
          .thenAnswer((_) async => null);

      bool result = await jailbreakDetection.jailbroken;

      expect(result, isTrue);
      verify(mockChannel.invokeMethod<bool>(jailBrokenMethod)).called(1);
    });

    test('developerMode returns true when channel returns true', () async {
      when(mockChannel.invokeMethod<bool>(developerModeMethod))
          .thenAnswer((_) async => true);

      bool result = await jailbreakDetection.developerMode;

      expect(result, isTrue);
      verify(mockChannel.invokeMethod<bool>(developerModeMethod)).called(1);
    });

    test('developerMode returns false when channel returns false', () async {
      when(mockChannel.invokeMethod<bool>(developerModeMethod))
          .thenAnswer((_) async => false);

      bool result = await jailbreakDetection.developerMode;

      expect(result, isFalse);
      verify(mockChannel.invokeMethod<bool>(developerModeMethod)).called(1);
    });

    test('developerMode returns true when channel returns null', () async {
      when(mockChannel.invokeMethod<bool>(developerModeMethod))
          .thenAnswer((_) async => null);

      bool result = await jailbreakDetection.developerMode;

      expect(result, isTrue);
      verify(mockChannel.invokeMethod<bool>(developerModeMethod)).called(1);
    });

    test('jailbroken throws MissingPluginException when method not mocked',
        () async {
      when(mockChannel.invokeMethod<bool>(jailBrokenMethod))
          .thenThrow(MissingPluginException());

      expect(jailbreakDetection.jailbroken,
          throwsA(isA<MissingPluginException>()));
      verify(mockChannel.invokeMethod<bool>(jailBrokenMethod)).called(1);
    });

    test('developerMode throws MissingPluginException when method not mocked',
        () async {
      when(mockChannel.invokeMethod<bool>(developerModeMethod))
          .thenThrow(MissingPluginException());

      expect(jailbreakDetection.developerMode,
          throwsA(isA<MissingPluginException>()));
      verify(mockChannel.invokeMethod<bool>(developerModeMethod)).called(1);
    });
  });
}
