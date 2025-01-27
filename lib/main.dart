// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'package:weatherapp/data/api/weather_service.dart';
import 'package:weatherapp/ui/screens/home_screen.dart';
import 'blocs/weather/weather_bloc.dart';
import 'blocs/connectivity/connectivity_bloc.dart';
import 'data/repositories/weather_repository.dart';

import 'data/providers/local_storage_provider.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
        HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  await LocalStorageProvider.init();
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectivityBloc>(
          create: (context) => ConnectivityBloc(
            connectivity: Connectivity(),
          )..add(CheckConnectivity()),
        ),
        BlocProvider<WeatherBloc>(
          create: (context) => WeatherBloc(
            weatherRepository: WeatherRepository(
              connectivityBloc: context.read<ConnectivityBloc>(),
              service: WeatherService.create(),
              storage: LocalStorageProvider(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Weather App',
        theme: FlexThemeData.light(scheme: FlexScheme.blueM3),
        darkTheme: FlexThemeData.dark(scheme: FlexScheme.blueM3),
        home: BlocListener<ConnectivityBloc, ConnectivityState>(
          listener: (context, state) {
            if (!state.isConnected) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No internet connection. Using cached data.'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: const HomeScreen(),
        ),
      ),
    );
  }
}
