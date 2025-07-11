class SocketEvents {

  // Connection events

  static const connect = 'connect';

  static const disconnect = 'disconnect';

  static const connectError = 'connect_error';

  static const error = 'error';

  // Driver events

  static const goOnline = 'goOnline';

  static const goOffline = 'goOffline';

  static const joinDriver = 'joinDriver';

  static const newOrder = 'newOrder';

  static const orderNotAccepted = 'orderNotAccepted';

  static const acceptOrder = 'acceptOrder';

  static const rejectOrder = 'rejectOrder';

  static const updateLocation = 'updateLocation';

  static const acceptedOrderScreen = 'acceptedOrderScreen';

  static const sendOTP = 'sendOTP';

  static const otpPhoneNo = 'otpPhoneNo';

  static const getCurrentOrderDetails = 'getCurrentOrderDetails';

  static const readyForDelivery = 'readyForDelivery';

  static const isOnline = 'is_online';

  static const trackDriverLocation = 'trackDriverLocation';

  static const deliveryComplete = 'deliveryComplete';

}
