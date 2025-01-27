import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/weather.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final Weather weather;

  const CurrentWeatherWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildLastUpdated(theme),
        const SizedBox(height: 40),
        _buildWeatherIcon(theme),
        const SizedBox(height: 40),
        _buildTemperature(theme),
        const SizedBox(height: 20),
        _buildCondition(theme),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildLastUpdated(ThemeData theme) {
    return Text(
      'Updated ${DateFormat('HH:mm').format(DateTime.now())}',
      style: theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.onSurface.withOpacity(0.38),
      ),
    );
  }

  Widget _buildWeatherIcon(ThemeData theme) {
    IconData iconData;
    switch (weather.condition.toLowerCase()) {
      case 'rain':
        iconData = Icons.water_drop;
        break;
      case 'clouds':
        iconData = Icons.cloud;
        break;
      case 'clear':
        iconData = Icons.wb_sunny;
        break;
      default:
        iconData = Icons.cloud;
    }

    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: theme.colorScheme.onSurface.withOpacity(0.1),
        borderRadius: BorderRadius.circular(60),
      ),
      child: Icon(
        iconData,
        size: 70,
        color: theme.colorScheme.onSurface,
      ),
    );
  }

  Widget _buildTemperature(ThemeData theme) {
    return Text(
      '${weather.temperature.toStringAsFixed(2)}°',
      style: theme.textTheme.displayLarge?.copyWith(
        color: theme.colorScheme.onSurface,
        fontWeight: FontWeight.w200,
        letterSpacing: -4,
      ),
    );
  }

  Widget _buildCondition(ThemeData theme) {
    return Text(
      'So, it\'s ${weather.condition}.',
      style: theme.textTheme.titleLarge?.copyWith(
        color: theme.colorScheme.onSurface.withOpacity(0.7),
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
