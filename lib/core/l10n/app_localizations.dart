import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @totalCarted.
  ///
  /// In en, this message translates to:
  /// **'Total Carted Products'**
  String get totalCarted;

  /// No description provided for @deliveryAddress.
  ///
  /// In en, this message translates to:
  /// **'Delivery Address'**
  String get deliveryAddress;

  /// No description provided for @tapToEditDeliveryInfo.
  ///
  /// In en, this message translates to:
  /// **'Tap to edit your delivery information'**
  String get tapToEditDeliveryInfo;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @editAddress.
  ///
  /// In en, this message translates to:
  /// **'Edit Address'**
  String get editAddress;

  /// No description provided for @updateYourDeliveryInformation.
  ///
  /// In en, this message translates to:
  /// **'Update your delivery information'**
  String get updateYourDeliveryInformation;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @trendyChef.
  ///
  /// In en, this message translates to:
  /// **'Trendy Chef'**
  String get trendyChef;

  /// No description provided for @addtocart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get addtocart;

  /// No description provided for @yourCartISEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your Cart Is Empty'**
  String get yourCartISEmpty;

  /// No description provided for @totalCartedProducts.
  ///
  /// In en, this message translates to:
  /// **'Total Carted Products'**
  String get totalCartedProducts;

  /// No description provided for @totalPurchased.
  ///
  /// In en, this message translates to:
  /// **'Total Purchased'**
  String get totalPurchased;

  /// No description provided for @dash.
  ///
  /// In en, this message translates to:
  /// **'Dash'**
  String get dash;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order;

  /// No description provided for @wishList.
  ///
  /// In en, this message translates to:
  /// **'WishList'**
  String get wishList;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @shop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get shop;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'LogOut'**
  String get logout;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'CheckOut'**
  String get checkout;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get items;

  /// No description provided for @deleteMsg.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this item from your cart?'**
  String get deleteMsg;

  /// No description provided for @keepIt.
  ///
  /// In en, this message translates to:
  /// **'Keep It'**
  String get keepIt;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @undoneMsg.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone'**
  String get undoneMsg;

  /// No description provided for @pay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay;

  /// No description provided for @validaddressmsg.
  ///
  /// In en, this message translates to:
  /// **'Please provide a valid delivery address'**
  String get validaddressmsg;

  /// No description provided for @failpaymentpageopenmsg.
  ///
  /// In en, this message translates to:
  /// **'Failed to open payment page'**
  String get failpaymentpageopenmsg;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @shippingcost.
  ///
  /// In en, this message translates to:
  /// **'Shipping Cost'**
  String get shippingcost;

  /// No description provided for @totalincvat.
  ///
  /// In en, this message translates to:
  /// **'Total Incl. VAT'**
  String get totalincvat;

  /// No description provided for @paymentcancelled.
  ///
  /// In en, this message translates to:
  /// **'Payment Cancelled'**
  String get paymentcancelled;

  /// No description provided for @yourpaymentwascancelled.
  ///
  /// In en, this message translates to:
  /// **'Your payment was cancelled'**
  String get yourpaymentwascancelled;

  /// No description provided for @nochargesweremade.
  ///
  /// In en, this message translates to:
  /// **'No Charges were made'**
  String get nochargesweremade;

  /// No description provided for @backtohome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backtohome;

  /// No description provided for @paymentfailed.
  ///
  /// In en, this message translates to:
  /// **'Payment Failed'**
  String get paymentfailed;

  /// No description provided for @yourpaymentcouldnotbeprocessed.
  ///
  /// In en, this message translates to:
  /// **'Your payment Could not be processed'**
  String get yourpaymentcouldnotbeprocessed;

  /// No description provided for @pleasetryagainoruseadifferentmethod.
  ///
  /// In en, this message translates to:
  /// **'Please try again or use a different method'**
  String get pleasetryagainoruseadifferentmethod;

  /// No description provided for @tryagain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryagain;

  /// No description provided for @placeorder.
  ///
  /// In en, this message translates to:
  /// **'Place Order'**
  String get placeorder;

  /// No description provided for @orderprocessing.
  ///
  /// In en, this message translates to:
  /// **'Order Processing...'**
  String get orderprocessing;

  /// No description provided for @shippingcostunderreview.
  ///
  /// In en, this message translates to:
  /// **'Shipping Cost Under Review'**
  String get shippingcostunderreview;

  /// No description provided for @readytopay.
  ///
  /// In en, this message translates to:
  /// **'Ready to Pay'**
  String get readytopay;

  /// No description provided for @confirmyourorder.
  ///
  /// In en, this message translates to:
  /// **'Confirm your order'**
  String get confirmyourorder;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @myorders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myorders;

  /// No description provided for @goodmorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get goodmorning;

  /// No description provided for @goodafternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get goodafternoon;

  /// No description provided for @goodevening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get goodevening;

  /// No description provided for @confirmorder.
  ///
  /// In en, this message translates to:
  /// **'Confirm Order'**
  String get confirmorder;

  /// No description provided for @areyousureyouwanttoplacethisorder.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to place this order?'**
  String get areyousureyouwanttoplacethisorder;

  /// No description provided for @yesplaceorder.
  ///
  /// In en, this message translates to:
  /// **'Yes, Place Order'**
  String get yesplaceorder;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @bysigninginyouagreetoour.
  ///
  /// In en, this message translates to:
  /// **'By signing in, you agree to our'**
  String get bysigninginyouagreetoour;

  /// No description provided for @orderplaced.
  ///
  /// In en, this message translates to:
  /// **'Order Placed'**
  String get orderplaced;

  /// No description provided for @ordersuccessmessage.
  ///
  /// In en, this message translates to:
  /// **'Your order has been placed successfully.\nThanks for shopping with us!'**
  String get ordersuccessmessage;

  /// No description provided for @checkorder.
  ///
  /// In en, this message translates to:
  /// **'Check Order'**
  String get checkorder;

  /// No description provided for @continueshopping.
  ///
  /// In en, this message translates to:
  /// **'Continue Shopping'**
  String get continueshopping;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
