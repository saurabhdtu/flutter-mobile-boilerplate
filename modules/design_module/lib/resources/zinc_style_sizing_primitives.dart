abstract class SizingPrimitives {
  double get xxxs;
  double get xxs;
  double get xs;
  double get s;
  double get m;
  double get l;
  double get xl;
  double get xxl;
  double get xxxl;
  double get xxxxl;
}

class TwosSizingPrimitive extends SizingPrimitives {
  @override
  double get xxxxl => 40;

  @override
  double get xxxl => 32;

  @override
  double get xxl => 24;

  @override
  double get xl => 20;

  @override
  double get l => 16;

  @override
  double get m => 12;

  @override
  double get s => 8;

  @override
  double get xs => 6;

  @override
  double get xxs => 4;

  @override
  double get xxxs => 2;
}
