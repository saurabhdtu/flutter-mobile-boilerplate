/// Generates UUID v1, v4, v5, v6, v7, v8 following RFC4122 standard.
// ignore_for_file: constant_identifier_names
// ignore_for_file: deprecated_member_use_from_same_package
// TODO: Remove this ignore when we remove the deprecated options.

library uuid;

import 'dart:typed_data';

import 'package:utility_module/uuid_generator/data.dart';
import 'package:utility_module/uuid_generator/rng.dart';
import 'package:utility_module/uuid_generator/validation.dart';

import 'enums.dart';
import 'parsing.dart';
import 'uuid_value.dart';
import 'v4.dart';

export 'uuid_value.dart';
export 'enums.dart';

/// uuid for Dart
/// Author: Yulian Kuncheff
/// Released under MIT License.

class Uuid {
  final GlobalOptions? goptions;

  @Deprecated('Please use the Namespace enum in enums.dart instead.')
  static const NAMESPACE_DNS = '6ba7b810-9dad-11d1-80b4-00c04fd430c8';
  @Deprecated('Please use the Namespace enum in enums.dart instead.')
  static const NAMESPACE_URL = '6ba7b811-9dad-11d1-80b4-00c04fd430c8';
  @Deprecated('Please use the Namespace enum in enums.dart instead.')
  static const NAMESPACE_OID = '6ba7b812-9dad-11d1-80b4-00c04fd430c8';
  @Deprecated('Please use the Namespace enum in enums.dart instead.')
  static const NAMESPACE_X500 = '6ba7b814-9dad-11d1-80b4-00c04fd430c8';
  @Deprecated('Please use the Namespace enum in enums.dart instead.')
  static const NAMESPACE_NIL = '00000000-0000-0000-0000-000000000000';

  /// Creates a new instance of the Uuid class.
  /// Optionally you can pass in a [GlobalOptions] object to set global options
  /// for all UUID generation.
  /// [GlobalOptions.rng] is a [RNG] class that returns a list of random bytes.
  ///
  /// Defaults rng function is `UuidUtil.mathRNG`
  ///
  /// Example: Using CryptoRNG globally
  ///
  /// ```dart
  /// var uuid = Uuid(options: {
  ///   'grng': UuidUtil.cryptoRNG
  /// })
  ///
  /// // Generate a v4 (random) id that will use cryptRNG for its rng function
  /// uuid.v4();
  /// ```
  const Uuid({this.goptions});

  /// Parses the provided [uuid] into a list of byte values as a List<int>.
  /// Can optionally be provided a [buffer] to write into and
  ///  a positional [offset] for where to start inputting into the buffer.
  /// Throws FormatException if the UUID is invalid. Optionally you can set
  /// [validate] to false to disable validation of the UUID before parsing.
  ///
  /// Example parsing a UUID string
  ///
  /// ```dart
  /// var bytes = uuid.parse('797ff043-11eb-11e1-80d6-510998755d10');
  /// // bytes-> [121, 127, 240, 67, 17, 235, 17, 225, 128, 214, 81, 9, 152, 117, 93, 16]
  /// ```
  static List<int> parse(
    String uuid, {
    List<int>? buffer,
    int offset = 0,
    bool validate = true,
    ValidationMode validationMode = ValidationMode.strictRFC4122,
  }) {
    return UuidParsing.parse(uuid,
        buffer: buffer,
        offset: offset,
        validate: validate,
        validationMode: validationMode);
  }

  /// Parses the provided [uuid] into a list of byte values as a Uint8List.
  /// Can optionally be provided a [buffer] to write into and
  ///  a positional [offset] for where to start inputting into the buffer.
  /// Throws FormatException if the UUID is invalid. Optionally you can set
  /// [validate] to false to disable validation of the UUID before parsing.
  static Uint8List parseAsByteList(String uuid,
      {List<int>? buffer,
      int offset = 0,
      bool validate = true,
      ValidationMode validationMode = ValidationMode.strictRFC4122}) {
    return UuidParsing.parseAsByteList(uuid,
        buffer: buffer,
        offset: offset,
        validate: validate,
        validationMode: validationMode);
  }

  /// Unparses a [buffer] of bytes and outputs a proper UUID string.
  /// An optional [offset] is allowed if you want to start at a different point
  /// in the buffer.
  /// Throws an exception if the buffer does not have a length of 16
  ///
  /// Example parsing and unparsing a UUID string
  ///
  /// ```dart
  /// var uuidString = uuid.unparse(bytes);
  /// // uuidString -> '797ff043-11eb-11e1-80d6-510998755d10'
  /// ```
  static String unparse(List<int> buffer, {int offset = 0}) {
    return UuidParsing.unparse(buffer, offset: offset);
  }

  /// Validates the provided [uuid] to make sure it has all the necessary
  /// components and formatting and returns a [bool]
  /// You can choose to validate from a string or from a byte list based on
  /// which parameter is passed.
  static bool isValidUUID(
      {String fromString = '',
      Uint8List? fromByteList,
      ValidationMode validationMode = ValidationMode.strictRFC4122,
      bool noDashes = false}) {
    return UuidValidation.isValidUUID(
        fromString: fromString,
        fromByteList: fromByteList,
        validationMode: validationMode,
        noDashes: noDashes);
  }

  /// Generates a RNG version 4 UUID
  ///
  /// By default it will generate a string based mathRNG, and will return
  /// a string. If you wish to use crypto-strong RNG, pass in UuidUtil.cryptoRNG
  ///
  /// The first argument is an options map that takes various configuration
  /// options detailed in the readme. This is going to be eventually deprecated.
  ///
  /// The second argument is a [V4Options] object that takes the same options as
  /// the options map. This is the preferred way to pass options.
  ///
  /// http://tools.ietf.org/html/rfc4122.html#section-4.4
  ///
  /// Example: Generate string UUID with different RNG method
  ///
  /// ```dart
  /// import 'package:uuid/uuid_util.dart';
  /// uuid.v4(options: {
  ///   'rng': UuidUtil.cryptoRNG
  /// });
  /// // -> "109156be-c4fb-41ea-b1b4-efe1671c5836"
  /// ```
  ///
  /// Example: Generate string UUID with different RNG method and named parameters
  ///
  /// ```dart
  /// import 'package:uuid/uuid_util.dart';
  /// uuid.v4(options: {
  ///   'rng': UuidUtil.mathRNG,
  ///   'namedArgs': new Map.fromIterables([const Symbol('seed')],[1])
  /// });
  /// // -> "09a91894-e93f-4141-a3ec-82eb32f2a3ef"
  /// ```
  ///
  /// Example: Generate string UUID with different RNG method and positional parameters
  ///
  /// ```dart
  /// import 'package:uuid/uuid_util.dart';
  /// uuid.v4(options: {
  ///   'rng': UuidUtil.cryptoRNG,
  ///   'positionalArgs': [1]
  /// });
  /// // -> "09a91894-e93f-4141-a3ec-82eb32f2a3ef"
  /// ```
  ///
  /// Example: Generate string UUID with fully-specified options
  ///
  /// ```dart
  /// uuid.v4(options: {
  ///   'random': [
  ///     0x10, 0x91, 0x56, 0xbe, 0xc4, 0xfb, 0xc1, 0xea,
  ///     0x71, 0xb4, 0xef, 0xe1, 0x67, 0x1c, 0x58, 0x36
  ///   ]
  /// });
  /// // -> "109156be-c4fb-41ea-b1b4-efe1671c5836"
  /// ```
  String v4(
      {@Deprecated('use config instead. Removal in 5.0.0')
      Map<String, dynamic>? options,
      V4Options? config}) {
    if (options != null && options.isNotEmpty) {
      var rng = options["rng"];
      if (options["rng"] != null && options["rng"] is! RNG) {
        rng = LegacyRNG(
            options["rng"], options["namedArgs"], options["positionalArgs"]);
      }
      config = V4Options(options["random"], rng);
    }
    return UuidV4(goptions: goptions).generate(options: config);
  }

  /// Generates a RNG version 4 UUID into a provided buffer
  ///
  /// By default it will generate a string based off mathRNG, and will
  /// place the result into the provided [buffer]. The [buffer] will also be returned.
  /// If you wish to have crypto-strong RNG, pass in UuidUtil.cryptoRNG.
  ///
  /// Optionally an [offset] can be provided with a start position in the buffer.
  ///
  /// The first optional argument is an options map that takes various configuration
  /// options detailed in the readme. This is going to be eventually deprecated.
  ///
  /// The second optional argument is a [V4Options] object that takes the same options as
  /// the options map. This is the preferred way to pass options.
  ///
  /// http://tools.ietf.org/html/rfc4122.html#section-4.4
  ///
  /// Example: Generate two IDs in a single buffer
  ///
  /// ```dart
  /// var myBuffer = new List(32);
  /// uuid.v4buffer(myBuffer);
  /// uuid.v4buffer(myBuffer, offset: 16);
  /// ```
  List<int> v4buffer(
    List<int> buffer, {
    @Deprecated('use config instead. Removal in 5.0.0')
    Map<String, dynamic>? options,
    V4Options? config,
    int offset = 0,
  }) {
    var result = options != null ? v4(options: options) : v4(config: config);
    return UuidParsing.parse(result, buffer: buffer, offset: offset);
  }

  /// Generates a RNG version 4 UUID as a [UuidValue] object
  ///
  /// By default it will generate a string based mathRNG, and will return
  /// a [UuidValue] object. If you wish to use crypto-strong RNG, pass in UuidUtil.cryptoRNG
  ///
  /// The first argument is an options map that takes various configuration
  /// options detailed in the readme. This is going to be eventually deprecated.
  ///
  /// The second argument is a [V4Options] object that takes the same options as
  /// the options map. This is the preferred way to pass options.
  ///
  /// http://tools.ietf.org/html/rfc4122.html#section-4.4
  ///
  /// Example: UuidValue usage
  ///
  /// ```dart
  /// uuidValue = uuid.v4obj(options: {
  ///   'random': [
  ///     0x10, 0x91, 0x56, 0xbe, 0xc4, 0xfb, 0xc1, 0xea,
  ///     0x71, 0xb4, 0xef, 0xe1, 0x67, 0x1c, 0x58, 0x36
  ///   ]
  /// }) // -> UuidValue{uuid: '109156be-c4fb-41ea-b1b4-efe1671c5836'}
  ///
  /// print(uuidValue) -> // -> '109156be-c4fb-41ea-b1b4-efe1671c5836'
  /// uuidValue.toBytes() -> // -> [...]
  /// ```
  UuidValue v4obj(
      {@Deprecated('use config instead. Removal in 5.0.0')
      Map<String, dynamic>? options,
      V4Options? config}) {
    return options != null
        ? UuidValue.fromString(v4(options: options))
        : UuidValue.fromString(v4(config: config));
  }

}
