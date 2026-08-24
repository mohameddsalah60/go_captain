import '../errors/failures.dart';

class ErrorMapper {
  /// Returns a user-friendly (Arabic) message for the given [Failure].
  static String friendlyMessage(Failure failure) {
    final normalized = failure.errorMessage
        .replaceAll('Exception: ', '')
        .replaceAll('SocketException', '')
        .replaceAll('DioException', '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim()
        .toLowerCase();

    if (normalized.isEmpty) return 'تعذّر إكمال الطلب. حاول مرة أخرى.';

    if (normalized.contains('socket') ||
        normalized.contains('network') ||
        normalized.contains('connection')) {
      return 'لا يوجد اتصال بالإنترنت. تحقق من الشبكة ثم حاول مرة أخرى.';
    }

    if (normalized.contains('timeout') || normalized.contains('time')) {
      return 'انتهت مهلة الاتصال. حاول مرة أخرى بعد قليل.';
    }

    if (normalized.contains('401') || normalized.contains('unauthorized')) {
      return 'غير مصرح. تحقق من بيانات الاعتماد ثم حاول مرة أخرى.';
    }

    if (normalized.contains('404') || normalized.contains('not found')) {
      return 'الموارد المطلوبة غير متوفرة حالياً.';
    }

    if (normalized.contains('500') || normalized.contains('internal server')) {
      return 'خطأ في الخادم. حاول مرة أخرى لاحقاً.';
    }

    // Fallback to the server message if it's short and meaningful
    if (normalized.length < 80) {
      // Capitalize first letter (simple)
      return '${normalized[0].toUpperCase()}${normalized.substring(1)}';
    }

    return 'تعذّر إكمال العملية. حاول مرة أخرى.';
  }
}
