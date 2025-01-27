import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'connectivity_state.dart';
part 'connectivity_event.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity connectivity;
  StreamSubscription? connectivitySubscription;

  ConnectivityBloc({required this.connectivity})
      : super(const ConnectivityState()) {
    on<CheckConnectivity>(_onCheckConnectivity);
    on<ConnectivityChanged>(_onConnectivityChanged);

    connectivitySubscription = connectivity.onConnectivityChanged.listen(
      (result) async {
        if (result == ConnectivityResult.none) {
          add(ConnectivityChanged(false));
        } else {
          final isConnected = await _checkInternetConnection();
          add(ConnectivityChanged(isConnected));
        }
      },
    );
  }

  Future<bool> _checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<void> _onCheckConnectivity(
    CheckConnectivity event,
    Emitter<ConnectivityState> emit,
  ) async {
    try {
      final result = await connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        emit(state.copyWith(
          isConnected: false,
          lastUpdated: DateTime.now().toIso8601String(),
          isInitialized: true,
        ));
      } else {
        final isConnected = await _checkInternetConnection();
        emit(state.copyWith(
          isConnected: isConnected,
          lastUpdated: DateTime.now().toIso8601String(),
          isInitialized: true,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isConnected: false,
        lastUpdated: DateTime.now().toIso8601String(),
        isInitialized: true,
      ));
    }
  }

  void _onConnectivityChanged(
    ConnectivityChanged event,
    Emitter<ConnectivityState> emit,
  ) {
    emit(state.copyWith(
      isConnected: event.isConnected,
      lastUpdated: DateTime.now().toIso8601String(),
    ));
  }

  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}
