import 'dart:convert';
import 'dart:math' as math;

int randomNumber() {

  // returns a random number between 1 and 2147483647
  var rng = math.Random();
  int randomNumber = rng.nextInt(2147483647) + 1;
  return randomNumber;

}
