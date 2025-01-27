import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/current_weather_widget.dart';
import '../widgets/forecast_widget.dart';
import '../widgets/weather_loading_widget.dart';
import '../../blocs/weather/weather_bloc.dart';
import '../../blocs/connectivity/connectivity_bloc.dart';
import 'city_search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            return Text(
              state.currentWeather?.cityName ?? 'Select City',
              style: theme.textTheme.displaySmall?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: theme.colorScheme.onSurface,
              size: 28,
            ),
            onPressed: () async {
              final city = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CitySearchScreen()),
              );
              if (city != null && context.mounted) {
                context.read<WeatherBloc>().add(FetchWeather(city));
              }
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocBuilder<ConnectivityBloc, ConnectivityState>(
        builder: (context, connectivityState) {
          return Column(
            children: [
              if (!connectivityState.isConnected)
                Container(
                  width: double.infinity,
                  color: theme.colorScheme.error.withValues(alpha: 0.1),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.wifi_off,
                        color: theme.colorScheme.error,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Offline Mode - Showing cached data',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const WeatherLoadingWidget();
                    }

                    if (state.error != null) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (state.currentWeather != null)
                            CurrentWeatherWidget(
                                weather: state.currentWeather!),
                          Container(
                            margin: const EdgeInsets.all(16),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.error
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: theme.colorScheme.error,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    state.error!,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.error,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }

                    if (state.currentWeather == null) {
                      return Center(
                        child: Text(
                          'Search for a city to get started',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.7),
                          ),
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<WeatherBloc>().add(RefreshWeather());
                      },
                      color: theme.colorScheme.primary,
                      backgroundColor: theme.colorScheme.surface,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CurrentWeatherWidget(
                                  weather: state.currentWeather!),
                              const SizedBox(height: 32),
                              if (state.forecast.isNotEmpty)
                                ForecastWidget(forecast: state.forecast),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
