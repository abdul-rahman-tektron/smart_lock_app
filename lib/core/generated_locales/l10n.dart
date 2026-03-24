// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(_current != null,
        'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(instance != null,
        'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Welcome to the App`
  String get welcome {
    return Intl.message(
      'Welcome to the App',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `العربية`
  String get switchLng {
    return Intl.message(
      'العربية',
      name: 'switchLng',
      desc: '',
      args: [],
    );
  }

  /// `The page you are looking for does not exist.`
  String get pageNotFound {
    return Intl.message(
      'The page you are looking for does not exist.',
      name: 'pageNotFound',
      desc: '',
      args: [],
    );
  }

  /// `مرحباً بكم في وزارة الخارجية`
  String get welcomeTitleAr {
    return Intl.message(
      'مرحباً بكم في وزارة الخارجية',
      name: 'welcomeTitleAr',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to the Ministry of Foreign Affairs`
  String get welcomeTitleEn {
    return Intl.message(
      'Welcome to the Ministry of Foreign Affairs',
      name: 'welcomeTitleEn',
      desc: '',
      args: [],
    );
  }

  /// `Please choose your preferred language`
  String get chooseLanguage {
    return Intl.message(
      'Please choose your preferred language',
      name: 'chooseLanguage',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `عربي`
  String get arabic {
    return Intl.message(
      'عربي',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `للحجز الرجاء مسح رمز الاستجابة السريعة أدناه`
  String get appointmentAr {
    return Intl.message(
      'للحجز الرجاء مسح رمز الاستجابة السريعة أدناه',
      name: 'appointmentAr',
      desc: '',
      args: [],
    );
  }

  /// `For appointment, please scan the QR code below`
  String get appointmentEn {
    return Intl.message(
      'For appointment, please scan the QR code below',
      name: 'appointmentEn',
      desc: '',
      args: [],
    );
  }

  /// `What Would You Like To Do?`
  String get optionsTitle {
    return Intl.message(
      'What Would You Like To Do?',
      name: 'optionsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please select an option to continue`
  String get optionsSubtitle {
    return Intl.message(
      'Please select an option to continue',
      name: 'optionsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Check In`
  String get checkIn {
    return Intl.message(
      'Check In',
      name: 'checkIn',
      desc: '',
      args: [],
    );
  }

  /// `Check Out`
  String get checkOut {
    return Intl.message(
      'Check Out',
      name: 'checkOut',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Please scan the QR code sent to your mail`
  String get qrScanTitle {
    return Intl.message(
      'Please scan the QR code sent to your mail',
      name: 'qrScanTitle',
      desc: '',
      args: [],
    );
  }

  /// `Ensure the QR code is clearly visible in front of the scanner`
  String get qrScanHint {
    return Intl.message(
      'Ensure the QR code is clearly visible in front of the scanner',
      name: 'qrScanHint',
      desc: '',
      args: [],
    );
  }

  /// `Please scan your face for identity verification`
  String get faceScanTitle {
    return Intl.message(
      'Please scan your face for identity verification',
      name: 'faceScanTitle',
      desc: '',
      args: [],
    );
  }

  /// `Look at the camera on the right hand side`
  String get faceScanHint {
    return Intl.message(
      'Look at the camera on the right hand side',
      name: 'faceScanHint',
      desc: '',
      args: [],
    );
  }

  /// `Almost there!`
  String get confirmTitle {
    return Intl.message(
      'Almost there!',
      name: 'confirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Your Visit Details`
  String get confirmDetails {
    return Intl.message(
      'Confirm Your Visit Details',
      name: 'confirmDetails',
      desc: '',
      args: [],
    );
  }

  /// `Consent`
  String get consentTitle {
    return Intl.message(
      'Consent',
      name: 'consentTitle',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Building`
  String get building {
    return Intl.message(
      'Building',
      name: 'building',
      desc: '',
      args: [],
    );
  }

  /// `Host Name`
  String get hostName {
    return Intl.message(
      'Host Name',
      name: 'hostName',
      desc: '',
      args: [],
    );
  }

  /// `Department`
  String get department {
    return Intl.message(
      'Department',
      name: 'department',
      desc: '',
      args: [],
    );
  }

  /// `Gate`
  String get gate {
    return Intl.message(
      'Gate',
      name: 'gate',
      desc: '',
      args: [],
    );
  }

  /// `Visit Purpose`
  String get visitPurpose {
    return Intl.message(
      'Visit Purpose',
      name: 'visitPurpose',
      desc: '',
      args: [],
    );
  }

  /// `Visit Start Date`
  String get visitStartDate {
    return Intl.message(
      'Visit Start Date',
      name: 'visitStartDate',
      desc: '',
      args: [],
    );
  }

  /// `Visit End Date`
  String get visitEndDate {
    return Intl.message(
      'Visit End Date',
      name: 'visitEndDate',
      desc: '',
      args: [],
    );
  }

  /// `The personal data that you provide on this page will be used for the purposes of ensuring the safety and security of visitors and staff during visits to MOFA sites. MOFA also uses this personal data to accurately identify visitors upon arrival at MOFA's sites, which may include using the photo provided on this page to verify the visitor's identity using facial recognition.`
  String get consentBullet1 {
    return Intl.message(
      'The personal data that you provide on this page will be used for the purposes of ensuring the safety and security of visitors and staff during visits to MOFA sites. MOFA also uses this personal data to accurately identify visitors upon arrival at MOFA\'s sites, which may include using the photo provided on this page to verify the visitor\'s identity using facial recognition.',
      name: 'consentBullet1',
      desc: '',
      args: [],
    );
  }

  /// `If you are submitting personal data on behalf of other visitors, you confirm that they are aware of this privacy statement and have consented to the submission of their data.`
  String get consentBullet2 {
    return Intl.message(
      'If you are submitting personal data on behalf of other visitors, you confirm that they are aware of this privacy statement and have consented to the submission of their data.',
      name: 'consentBullet2',
      desc: '',
      args: [],
    );
  }

  /// `The system reflects Intersec’s core themes of advanced security, trusted identity, and intelligent access control.`
  String get consentBullet3 {
    return Intl.message(
      'The system reflects Intersec’s core themes of advanced security, trusted identity, and intelligent access control.',
      name: 'consentBullet3',
      desc: '',
      args: [],
    );
  }

  /// `I acknowledge that no external devices or equipment brought on-site will be connected to MOFA's internal systems or networks under any circumstances.`
  String get acknowledgementText {
    return Intl.message(
      'I acknowledge that no external devices or equipment brought on-site will be connected to MOFA\'s internal systems or networks under any circumstances.',
      name: 'acknowledgementText',
      desc: '',
      args: [],
    );
  }

  /// `You're Successfully Checked In!`
  String get checkInSuccess {
    return Intl.message(
      'You\'re Successfully Checked In!',
      name: 'checkInSuccess',
      desc: '',
      args: [],
    );
  }

  /// `How was your experience?`
  String get feedbackQuestion {
    return Intl.message(
      'How was your experience?',
      name: 'feedbackQuestion',
      desc: '',
      args: [],
    );
  }

  /// `How Would You Like To Check out?`
  String get checkoutTitle {
    return Intl.message(
      'How Would You Like To Check out?',
      name: 'checkoutTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please select an option to continue`
  String get checkoutSubtitle {
    return Intl.message(
      'Please select an option to continue',
      name: 'checkoutSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Facial Scan`
  String get facialScan {
    return Intl.message(
      'Facial Scan',
      name: 'facialScan',
      desc: '',
      args: [],
    );
  }

  /// `Scan QR Code`
  String get scanQrCode {
    return Intl.message(
      'Scan QR Code',
      name: 'scanQrCode',
      desc: '',
      args: [],
    );
  }

  /// ` أهلاً بكم في `
  String get welcomeHeaderAr {
    return Intl.message(
      ' أهلاً بكم في ',
      name: 'welcomeHeaderAr',
      desc: '',
      args: [],
    );
  }

  /// `جناح تيكترونيكس`
  String get tektronixBoothAr {
    return Intl.message(
      'جناح تيكترونيكس',
      name: 'tektronixBoothAr',
      desc: '',
      args: [],
    );
  }

  /// `ذكي. آمن. وسهل الوصول.`
  String get taglineAr {
    return Intl.message(
      'ذكي. آمن. وسهل الوصول.',
      name: 'taglineAr',
      desc: '',
      args: [],
    );
  }

  /// `مرحبًا بكم في`
  String get welcomeToThe {
    return Intl.message(
      'مرحبًا بكم في',
      name: 'welcomeToThe',
      desc: '',
      args: [],
    );
  }

  /// ` جناح تيكترونيكس`
  String get tektronixBoothEn {
    return Intl.message(
      ' جناح تيكترونيكس',
      name: 'tektronixBoothEn',
      desc: '',
      args: [],
    );
  }

  /// `ذكي. آمن. وسهل الوصول.`
  String get taglineEn {
    return Intl.message(
      'ذكي. آمن. وسهل الوصول.',
      name: 'taglineEn',
      desc: '',
      args: [],
    );
  }

  /// `ابدأ الآن لتجربة أسرع داخل الجناح`
  String get getStartedBooth {
    return Intl.message(
      'ابدأ الآن لتجربة أسرع داخل الجناح',
      name: 'getStartedBooth',
      desc: '',
      args: [],
    );
  }

  /// `يرجى مسح رمز QR لتجاوز الانتظار`
  String get scanQrSkipWaitAr {
    return Intl.message(
      'يرجى مسح رمز QR لتجاوز الانتظار',
      name: 'scanQrSkipWaitAr',
      desc: '',
      args: [],
    );
  }

  /// `امسح رمز QR لتجاوز الانتظار`
  String get scanQrSkipWaitEn {
    return Intl.message(
      'امسح رمز QR لتجاوز الانتظار',
      name: 'scanQrSkipWaitEn',
      desc: '',
      args: [],
    );
  }

  /// `Check Out with Access Card`
  String get cardCheckoutTitle {
    return Intl.message(
      'Check Out with Access Card',
      name: 'cardCheckoutTitle',
      desc: '',
      args: [],
    );
  }

  /// `Access Card Number`
  String get cardNumberTitle {
    return Intl.message(
      'Access Card Number',
      name: 'cardNumberTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select a card`
  String get cardNumberHint {
    return Intl.message(
      'Select a card',
      name: 'cardNumberHint',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueKey {
    return Intl.message(
      'Continue',
      name: 'continueKey',
      desc: '',
      args: [],
    );
  }

  /// `Choose a Checkout Method`
  String get checkoutMethodTitle {
    return Intl.message(
      'Choose a Checkout Method',
      name: 'checkoutMethodTitle',
      desc: '',
      args: [],
    );
  }

  /// `Use Access Card`
  String get useAccessCard {
    return Intl.message(
      'Use Access Card',
      name: 'useAccessCard',
      desc: '',
      args: [],
    );
  }

  /// `Manual Checkout`
  String get manualCheckout {
    return Intl.message(
      'Manual Checkout',
      name: 'manualCheckout',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Document ID`
  String get documentId {
    return Intl.message(
      'Document ID',
      name: 'documentId',
      desc: '',
      args: [],
    );
  }

  /// `Nationality`
  String get nationality {
    return Intl.message(
      'Nationality',
      name: 'nationality',
      desc: '',
      args: [],
    );
  }

  /// `Visiting Department`
  String get visitingDepartment {
    return Intl.message(
      'Visiting Department',
      name: 'visitingDepartment',
      desc: '',
      args: [],
    );
  }

  /// `Visiting Purpose`
  String get visitingPurpose {
    return Intl.message(
      'Visiting Purpose',
      name: 'visitingPurpose',
      desc: '',
      args: [],
    );
  }

  /// `Access Card Number`
  String get accessCardNumber {
    return Intl.message(
      'Access Card Number',
      name: 'accessCardNumber',
      desc: '',
      args: [],
    );
  }

  /// `Select Access Card`
  String get selectAccessCard {
    return Intl.message(
      'Select Access Card',
      name: 'selectAccessCard',
      desc: '',
      args: [],
    );
  }

  /// `By proceeding, you confirm that the personal information provided on this screen may be collected and processed by Tektronix Technology Systems LLC for demonstration and evaluation purposes, including visitor identification, access control, and security management.`
  String get consentBulletTek1 {
    return Intl.message(
      'By proceeding, you confirm that the personal information provided on this screen may be collected and processed by Tektronix Technology Systems LLC for demonstration and evaluation purposes, including visitor identification, access control, and security management.',
      name: 'consentBulletTek1',
      desc: '',
      args: [],
    );
  }

  /// `This may include the use of facial images or biometric data strictly for demonstration during your visit, in accordance with applicable data protection and privacy regulations.`
  String get consentBulletTek2 {
    return Intl.message(
      'This may include the use of facial images or biometric data strictly for demonstration during your visit, in accordance with applicable data protection and privacy regulations.',
      name: 'consentBulletTek2',
      desc: '',
      args: [],
    );
  }

  /// `The system reflects a core focus on advanced security technologies, trusted digital identity, and intelligent access control, showcased solely to demonstrate secure and seamless visitor experiences within a controlled environment.`
  String get consentBulletTek3 {
    return Intl.message(
      'The system reflects a core focus on advanced security technologies, trusted digital identity, and intelligent access control, showcased solely to demonstrate secure and seamless visitor experiences within a controlled environment.',
      name: 'consentBulletTek3',
      desc: '',
      args: [],
    );
  }

  /// `I acknowledge and consent to the processing of my information for the purposes stated above.`
  String get ackConsentTek {
    return Intl.message(
      'I acknowledge and consent to the processing of my information for the purposes stated above.',
      name: 'ackConsentTek',
      desc: '',
      args: [],
    );
  }

  /// `Verifying... please wait`
  String get verifyingPleaseWait {
    return Intl.message(
      'Verifying... please wait',
      name: 'verifyingPleaseWait',
      desc: '',
      args: [],
    );
  }

  /// `Kindly wait while your visit is being processed`
  String get kindlyWaitVisitProcess {
    return Intl.message(
      'Kindly wait while your visit is being processed',
      name: 'kindlyWaitVisitProcess',
      desc: '',
      args: [],
    );
  }

  /// `Scan Face`
  String get scanFace {
    return Intl.message(
      'Scan Face',
      name: 'scanFace',
      desc: '',
      args: [],
    );
  }

  /// `Scan Again`
  String get scanAgain {
    return Intl.message(
      'Scan Again',
      name: 'scanAgain',
      desc: '',
      args: [],
    );
  }

  /// `Verifying…`
  String get verifying {
    return Intl.message(
      'Verifying…',
      name: 'verifying',
      desc: '',
      args: [],
    );
  }

  /// `Hold still… verifying your face`
  String get faceHoldStillHeader {
    return Intl.message(
      'Hold still… verifying your face',
      name: 'faceHoldStillHeader',
      desc: '',
      args: [],
    );
  }

  /// `Verified ✅`
  String get faceVerifiedHeader {
    return Intl.message(
      'Verified ✅',
      name: 'faceVerifiedHeader',
      desc: '',
      args: [],
    );
  }

  /// `We couldn’t verify your identity!`
  String get faceNotVerifiedHeader {
    return Intl.message(
      'We couldn’t verify your identity!',
      name: 'faceNotVerifiedHeader',
      desc: '',
      args: [],
    );
  }

  /// `Let’s verify your identity!`
  String get faceLetsVerifyHeader {
    return Intl.message(
      'Let’s verify your identity!',
      name: 'faceLetsVerifyHeader',
      desc: '',
      args: [],
    );
  }

  /// `Using the front camera. This will take a moment.`
  String get faceUsingCameraSub {
    return Intl.message(
      'Using the front camera. This will take a moment.',
      name: 'faceUsingCameraSub',
      desc: '',
      args: [],
    );
  }

  /// `You’re good to continue.`
  String get faceContinueSub {
    return Intl.message(
      'You’re good to continue.',
      name: 'faceContinueSub',
      desc: '',
      args: [],
    );
  }

  /// `Please try again.`
  String get faceRetrySub {
    return Intl.message(
      'Please try again.',
      name: 'faceRetrySub',
      desc: '',
      args: [],
    );
  }

  /// `Ensure your face is clearly visible.`
  String get faceEnsureVisibleSub {
    return Intl.message(
      'Ensure your face is clearly visible.',
      name: 'faceEnsureVisibleSub',
      desc: '',
      args: [],
    );
  }

  /// `Reference image not available`
  String get faceRefNotAvailable {
    return Intl.message(
      'Reference image not available',
      name: 'faceRefNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Face not detected`
  String get faceNotDetected {
    return Intl.message(
      'Face not detected',
      name: 'faceNotDetected',
      desc: '',
      args: [],
    );
  }

  /// `Face recognized`
  String get faceRecognized {
    return Intl.message(
      'Face recognized',
      name: 'faceRecognized',
      desc: '',
      args: [],
    );
  }

  /// `Face not recognized`
  String get faceNotRecognized {
    return Intl.message(
      'Face not recognized',
      name: 'faceNotRecognized',
      desc: '',
      args: [],
    );
  }

  /// `Verification failed`
  String get faceVerificationFailed {
    return Intl.message(
      'Verification failed',
      name: 'faceVerificationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Network error occurred`
  String get networkErrorOccurred {
    return Intl.message(
      'Network error occurred',
      name: 'networkErrorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `You're successfully checked out!`
  String get checkoutSuccess {
    return Intl.message(
      'You\'re successfully checked out!',
      name: 'checkoutSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for your feedback.`
  String get thankYouFeedback {
    return Intl.message(
      'Thank you for your feedback.',
      name: 'thankYouFeedback',
      desc: '',
      args: [],
    );
  }

  /// `Manual Checkout`
  String get manualCheckoutTitle {
    return Intl.message(
      'Manual Checkout',
      name: 'manualCheckoutTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select a visitor to checkout`
  String get manualCheckoutSubtitle {
    return Intl.message(
      'Select a visitor to checkout',
      name: 'manualCheckoutSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `No active visitors found`
  String get noActiveUsersFound {
    return Intl.message(
      'No active visitors found',
      name: 'noActiveUsersFound',
      desc: '',
      args: [],
    );
  }

  /// `Loading active visitors…`
  String get loadingActiveVisitors {
    return Intl.message(
      'Loading active visitors…',
      name: 'loadingActiveVisitors',
      desc: '',
      args: [],
    );
  }

  /// `Alert`
  String get alertTitle {
    return Intl.message(
      'Alert',
      name: 'alertTitle',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to checkout {name}?`
  String confirmCheckoutQuestion(Object name) {
    return Intl.message(
      'Do you want to checkout $name?',
      name: 'confirmCheckoutQuestion',
      desc: '',
      args: [name],
    );
  }

  /// `this visitor`
  String get thisVisitor {
    return Intl.message(
      'this visitor',
      name: 'thisVisitor',
      desc: '',
      args: [],
    );
  }

  /// `Yes, Checkout`
  String get yesCheckout {
    return Intl.message(
      'Yes, Checkout',
      name: 'yesCheckout',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Please wait`
  String get pleaseWait {
    return Intl.message(
      'Please wait',
      name: 'pleaseWait',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message(
      'Checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Walk-In Registration`
  String get walkInRegistration {
    return Intl.message(
      'Walk-In Registration',
      name: 'walkInRegistration',
      desc: '',
      args: [],
    );
  }

  /// `No appointment yet? Register now`
  String get walkInSubtitle {
    return Intl.message(
      'No appointment yet? Register now',
      name: 'walkInSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Check-In`
  String get checkInTitle {
    return Intl.message(
      'Check-In',
      name: 'checkInTitle',
      desc: '',
      args: [],
    );
  }

  /// `Scan your QR and Face`
  String get checkInSubtitleShort {
    return Intl.message(
      'Scan your QR and Face',
      name: 'checkInSubtitleShort',
      desc: '',
      args: [],
    );
  }

  /// `Check-Out`
  String get checkOutTitle {
    return Intl.message(
      'Check-Out',
      name: 'checkOutTitle',
      desc: '',
      args: [],
    );
  }

  /// `Complete your visit`
  String get checkOutSubtitleShort {
    return Intl.message(
      'Complete your visit',
      name: 'checkOutSubtitleShort',
      desc: '',
      args: [],
    );
  }

  /// `Secure, Smart Controlled Access`
  String get secureSmartAccess {
    return Intl.message(
      'Secure, Smart Controlled Access',
      name: 'secureSmartAccess',
      desc: '',
      args: [],
    );
  }

  /// `Scan QR to continue`
  String get scanQrToContinue {
    return Intl.message(
      'Scan QR to continue',
      name: 'scanQrToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Hold the QR near the scanner. It will detect automatically.`
  String get qrScanInstruction {
    return Intl.message(
      'Hold the QR near the scanner. It will detect automatically.',
      name: 'qrScanInstruction',
      desc: '',
      args: [],
    );
  }

  /// `Fetching appointment…`
  String get fetchingAppointment {
    return Intl.message(
      'Fetching appointment…',
      name: 'fetchingAppointment',
      desc: '',
      args: [],
    );
  }

  /// `Ready to Scan`
  String get readyToScan {
    return Intl.message(
      'Ready to Scan',
      name: 'readyToScan',
      desc: '',
      args: [],
    );
  }

  /// `How would you like to Register?`
  String get registerHowTitle {
    return Intl.message(
      'How would you like to Register?',
      name: 'registerHowTitle',
      desc: '',
      args: [],
    );
  }

  /// `Scan Emirates ID`
  String get scanEmiratesId {
    return Intl.message(
      'Scan Emirates ID',
      name: 'scanEmiratesId',
      desc: '',
      args: [],
    );
  }

  /// `Scan Passport`
  String get scanPassport {
    return Intl.message(
      'Scan Passport',
      name: 'scanPassport',
      desc: '',
      args: [],
    );
  }

  /// `OR`
  String get or {
    return Intl.message(
      'OR',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Passport No`
  String get passportNo {
    return Intl.message(
      'Passport No',
      name: 'passportNo',
      desc: '',
      args: [],
    );
  }

  /// `Emirates ID`
  String get emiratesId {
    return Intl.message(
      'Emirates ID',
      name: 'emiratesId',
      desc: '',
      args: [],
    );
  }

  /// `Select Nationality`
  String get selectNationality {
    return Intl.message(
      'Select Nationality',
      name: 'selectNationality',
      desc: '',
      args: [],
    );
  }

  /// `Select Department`
  String get selectDepartment {
    return Intl.message(
      'Select Department',
      name: 'selectDepartment',
      desc: '',
      args: [],
    );
  }

  /// `Select Purpose`
  String get selectPurpose {
    return Intl.message(
      'Select Purpose',
      name: 'selectPurpose',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Photo captured`
  String get photoCaptured {
    return Intl.message(
      'Photo captured',
      name: 'photoCaptured',
      desc: '',
      args: [],
    );
  }

  /// `Retake`
  String get retake {
    return Intl.message(
      'Retake',
      name: 'retake',
      desc: '',
      args: [],
    );
  }

  /// `Tap to capture`
  String get tapToCapture {
    return Intl.message(
      'Tap to capture',
      name: 'tapToCapture',
      desc: '',
      args: [],
    );
  }

  /// `Auto captures in 3s`
  String get autoCapturesIn3s {
    return Intl.message(
      'Auto captures in 3s',
      name: 'autoCapturesIn3s',
      desc: '',
      args: [],
    );
  }

  /// `Submitting...`
  String get submitting {
    return Intl.message(
      'Submitting...',
      name: 'submitting',
      desc: '',
      args: [],
    );
  }

  /// `Kindly wait while your visit is being processed.`
  String get submittingWaitMessage {
    return Intl.message(
      'Kindly wait while your visit is being processed.',
      name: 'submittingWaitMessage',
      desc: '',
      args: [],
    );
  }

  /// `Required`
  String get required {
    return Intl.message(
      'Required',
      name: 'required',
      desc: '',
      args: [],
    );
  }

  /// `is required`
  String get isRequired {
    return Intl.message(
      'is required',
      name: 'isRequired',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Enter`
  String get enter {
    return Intl.message(
      'Enter',
      name: 'enter',
      desc: '',
      args: [],
    );
  }

  /// `Action required`
  String get actionRequired {
    return Intl.message(
      'Action required',
      name: 'actionRequired',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Branded dialog`
  String get brandedDialog {
    return Intl.message(
      'Branded dialog',
      name: 'brandedDialog',
      desc: '',
      args: [],
    );
  }

  /// `Keep your face inside the frame`
  String get keepInsideFrame {
    return Intl.message(
      'Keep your face inside the frame',
      name: 'keepInsideFrame',
      desc: '',
      args: [],
    );
  }

  /// `Fit from top of head to chin`
  String get fitFromTopToChin {
    return Intl.message(
      'Fit from top of head to chin',
      name: 'fitFromTopToChin',
      desc: '',
      args: [],
    );
  }

  /// `Align face inside the frame`
  String get alignFaceInsideFrame {
    return Intl.message(
      'Align face inside the frame',
      name: 'alignFaceInsideFrame',
      desc: '',
      args: [],
    );
  }

  /// `Capturing...`
  String get capturing {
    return Intl.message(
      'Capturing...',
      name: 'capturing',
      desc: '',
      args: [],
    );
  }

  /// `Visitor already checked in`
  String get visitorAlreadyCheckedIn {
    return Intl.message(
      'Visitor already checked in',
      name: 'visitorAlreadyCheckedIn',
      desc: '',
      args: [],
    );
  }

  /// `Checkout Confirmation`
  String get checkoutConfirmation {
    return Intl.message(
      'Checkout Confirmation',
      name: 'checkoutConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Submission Successful`
  String get submissionSuccessful {
    return Intl.message(
      'Submission Successful',
      name: 'submissionSuccessful',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
