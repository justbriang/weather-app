import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/blocs/weather/weather_bloc.dart';
import '../../blocs/connectivity/connectivity_bloc.dart';

class CitySearchScreen extends StatelessWidget {
  const CitySearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, connectivityState) {
        final isOffline = !connectivityState.isConnected;
        return Scaffold(
          backgroundColor: theme.colorScheme.surface,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,
                  color: theme.colorScheme.onSurface),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Column(
            children: [
              if (isOffline)
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
                        'Offline Mode - Showing cached cities',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Search City',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      if (!isOffline)
                        TextField(
                          style: TextStyle(color: theme.colorScheme.onSurface),
                          decoration: InputDecoration(
                            hintText: 'Enter city name',
                            hintStyle: TextStyle(
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.5),
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.5),
                            ),
                            filled: true,
                            fillColor: theme.colorScheme.onSurface
                                .withValues(alpha: 0.1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: theme.colorScheme.onSurface),
                            ),
                          ),
                          onSubmitted: (value) {
                            if (value.isNotEmpty) {
                              Navigator.pop(context, value);
                            }
                          },
                        ),
                      const SizedBox(height: 24),
                      Text(
                        isOffline ? 'Cached Cities' : 'Popular Cities',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          if (isOffline)
                            ...context
                                .read<WeatherBloc>()
                                .state
                                .searchedCities
                                .map((city) =>
                                    _buildCityChip(context, city, theme))
                          else
                            ...[
                              'London',
                              'New York',
                              'Tokyo',
                              'Paris',
                              'Berlin',
                              'Sydney'
                            ].map(
                                (city) => _buildCityChip(context, city, theme)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCityChip(BuildContext context, String city, ThemeData theme) {
    return InkWell(
      onTap: () => Navigator.pop(context, city),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          city,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
