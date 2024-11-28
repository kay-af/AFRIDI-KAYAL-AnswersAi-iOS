import "package:flutter/widgets.dart";
import "package:intl/intl.dart";

extension NumberExtension on num {
  Widget get verticalSpace => SizedBox(height: toDouble());
  Widget get horizontalSpace => SizedBox(width: toDouble());
}

class DateTimeFormatters {
  DateTimeFormatters._();

  static final DateFormat dateFullMonth = DateFormat(
    "${DateFormat.DAY} ${DateFormat.MONTH}",
    Intl.defaultLocale,
  );
}

class MathUtils {
  MathUtils._();

  static double inverseLerp(double from, double to, double value) {
    assert(from != to);
    return (value - from) / (to - from);
  }
}

class ListUtils {
  ListUtils._();

  static List<T> insertBetweenEvery<T>(List<T> input, T item) {
    List<T> result = [];

    for (int i = 0; i < input.length; i++) {
      result.add(input[i]);
      if (i != input.length - 1) {
        result.add(item);
      }
    }

    return result;
  }
}
