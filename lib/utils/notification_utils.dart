part of 'utils.dart';

void pushNotification({String content, String heading}) async {
  var status = await OneSignal.shared.getPermissionSubscriptionState();

  var playerId = status.subscriptionStatus.userId;

  await OneSignal.shared.postNotification(OSCreateNotification(
    playerIds: [playerId],
    content: content,
    heading: heading,
  ));
}