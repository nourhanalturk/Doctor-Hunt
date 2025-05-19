import 'failure.dart';

class ServerFailure extends Failure {
  ServerFailure([String message = 'Server error']) : super(500 ,message);
}