part of 'connectivity_bloc.dart';

class ConnectivityState extends Equatable {
  final bool isConnected;
  final String? lastUpdated;
  final bool isInitialized;

  const ConnectivityState({
    this.isConnected = false,
    this.lastUpdated,
    this.isInitialized = false,
  });

  ConnectivityState copyWith({
    bool? isConnected,
    String? lastUpdated,
    bool? isInitialized,
  }) {
    return ConnectivityState(
      isConnected: isConnected ?? this.isConnected,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }

  @override
  List<Object?> get props => [isConnected, lastUpdated, isInitialized];
}
