import 'dart:convert';
import 'dart:math' as math;

int randomNumber() {
  /// MODIFY CODE ONLY BELOW THIS LINE

  var rng = math.Random();
  int randomNumber = rng.nextInt(2147483647) + 1;
  return randomNumber;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
