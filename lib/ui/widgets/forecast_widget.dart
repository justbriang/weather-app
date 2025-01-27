import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/forecast.dart';

class ForecastWidget extends StatelessWidget {
  final List<Forecast> forecast;

  const ForecastWidget({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.24),
          thickness: 0.5,
        ),
        const SizedBox(height: 20),
        ...forecast.map((day) => _buildForecastDay(day, theme)).toList(),
      ],
    );
  }

  String _formatDateTime(String dateStr) {
    final date = DateTime.parse(dateStr);
    return DateFormat('E, MMM d').format(date);
  }

  Widget _buildForecastDay(Forecast day, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              _formatDateTime("${day.date}"),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${day.tempMax.toStringAsFixed(1)}° ${day.tempMin.toStringAsFixed(1)}°',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
