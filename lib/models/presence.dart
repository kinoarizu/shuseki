part of 'models.dart';

class Presence extends Equatable {
  final int total;
  final int sick;
  final int permit;
  final int alpha;

  Presence(
    this.total,
    this.sick,
    this.permit,
    this.alpha,
  );

  Presence copyWith({int total, int sick, int permit, int alpha}) => Presence(
    total ?? this.total,
    sick ?? this.sick,
    permit ?? this.permit,
    alpha ?? this.alpha,
  );

  @override
  List<Object> get props => [total, sick, permit, alpha];
}