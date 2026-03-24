enum Method { get, post, put, delete }

enum ThankYouFlow { delivery, pickup }

enum PaymentMethod { cardNfc, googlePay, applePay }

enum ReceiverType { mobile, email, flat }

enum LockerSize { small, medium, large }

enum CustomButtonType {
  primary,
  outline,
  plain,
}

enum EidFlowState {
  idle,
  initializing,
  needAllFilesPermission,
  ready,
  connectingReader,
  readerConnected,
  reading,
  cardRead,
  error,
}