import 'package:equatable/equatable.dart';

sealed class NetworkCheckerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class InternetConnectedEvent extends NetworkCheckerEvent {}

final class InternetDisconnectedEvent extends NetworkCheckerEvent {}
