sealed class Failure {
  final String message;
  const Failure(this.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Failed to load data. Check your connection.']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Failed to load cached data.']);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Reciter data not found.']);
}
