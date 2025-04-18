import 'package:intl/intl.dart';


String get tripDeleted => Intl.message(
  'has been deleted.',
  name: 'tripDeleted',
  desc: 'Confirmation message when a trip is deleted',
);

String get undo => Intl.message(
  'Undo',
  name: 'undo',
  desc: 'Undo action for deleting a trip',
);
