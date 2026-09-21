// lib/res/constants/string_constants.dart
import 'package:thuga/res/l10n/locale_catalog.dart';

/// Locale-aware string facade. Copy lives in assets/l10n/{en,ml}.json.
/// Add keys to both JSON files first, then expose a getter here.
class Strings {
  Strings._();

  static String get appName => LocaleCatalog.instance.t('appName');
  static String get ok => LocaleCatalog.instance.t('ok');
  static String get cancel => LocaleCatalog.instance.t('cancel');
  static String get save => LocaleCatalog.instance.t('save');
  static String get delete => LocaleCatalog.instance.t('delete');
  static String get edit => LocaleCatalog.instance.t('edit');
  static String get done => LocaleCatalog.instance.t('done');
  static String get loading => LocaleCatalog.instance.t('loading');
  static String get retry => LocaleCatalog.instance.t('retry');
  static String get close => LocaleCatalog.instance.t('close');
  static String get confirm => LocaleCatalog.instance.t('confirm');
  static String get search => LocaleCatalog.instance.t('search');
  static String get clear => LocaleCatalog.instance.t('clear');
  static String get viewAll => LocaleCatalog.instance.t('viewAll');
  static String get seeDetails => LocaleCatalog.instance.t('seeDetails');
  static String get continueLabel => LocaleCatalog.instance.t('continueLabel');
  static String get showPassword => LocaleCatalog.instance.t('showPassword');
  static String get hidePassword => LocaleCatalog.instance.t('hidePassword');
  static String get orLabel => LocaleCatalog.instance.t('orLabel');
  static String get somethingWentWrong => LocaleCatalog.instance.t('somethingWentWrong');
  static String get noInternet => LocaleCatalog.instance.t('noInternet');
  static String get sessionExpired => LocaleCatalog.instance.t('sessionExpired');
  static String get noDataFound => LocaleCatalog.instance.t('noDataFound');
  static String get connectionErrorTitle => LocaleCatalog.instance.t('connectionErrorTitle');
  static String get connectionErrorDesc => LocaleCatalog.instance.t('connectionErrorDesc');
  static String get noResultsFound => LocaleCatalog.instance.t('noResultsFound');
  static String get noResultsDesc => LocaleCatalog.instance.t('noResultsDesc');
  static String get welcomeBack => LocaleCatalog.instance.t('welcomeBack');
  static String get signInToContinue => LocaleCatalog.instance.t('signInToContinue');
  static String get authTrustLine => LocaleCatalog.instance.t('authTrustLine');
  static String get login => LocaleCatalog.instance.t('login');
  static String get register => LocaleCatalog.instance.t('register');
  static String get email => LocaleCatalog.instance.t('email');
  static String get password => LocaleCatalog.instance.t('password');
  static String get mobileNumber => LocaleCatalog.instance.t('mobileNumber');
  static String get getOtp => LocaleCatalog.instance.t('getOtp');
  static String get dontHaveAccount => LocaleCatalog.instance.t('dontHaveAccount');
  static String get signUp => LocaleCatalog.instance.t('signUp');
  static String get continueWithGoogle => LocaleCatalog.instance.t('continueWithGoogle');
  static String get forgotPassword => LocaleCatalog.instance.t('forgotPassword');
  static String get refresh => LocaleCatalog.instance.t('refresh');
  static String get error500Title => LocaleCatalog.instance.t('error500Title');
  static String get error500Message => LocaleCatalog.instance.t('error500Message');
  static String get noDataAvailable => LocaleCatalog.instance.t('noDataAvailable');
  static String get noDataAvailableDesc => LocaleCatalog.instance.t('noDataAvailableDesc');
  static String get goBackButton => LocaleCatalog.instance.t('goBackButton');
  static String get noDataMessage => LocaleCatalog.instance.t('noDataMessage');
  static String get noOffersYet => LocaleCatalog.instance.t('noOffersYet');
  static String get noOffersYetDesc => LocaleCatalog.instance.t('noOffersYetDesc');
  static String get logIn => LocaleCatalog.instance.t('logIn');
  static String get noGiftCards => LocaleCatalog.instance.t('noGiftCards');
  static String get noGiftCardsDesc => LocaleCatalog.instance.t('noGiftCardsDesc');
  static String get noFavoriteProducts => LocaleCatalog.instance.t('noFavoriteProducts');
  static String get noFavoriteProductsDesc => LocaleCatalog.instance.t('noFavoriteProductsDesc');
  static String get noTransactionsFound => LocaleCatalog.instance.t('noTransactionsFound');
  static String get noTransactionsDesc => LocaleCatalog.instance.t('noTransactionsDesc');
  static String get noNotifications => LocaleCatalog.instance.t('noNotifications');
  static String get noNotificationsDesc => LocaleCatalog.instance.t('noNotificationsDesc');
  static String get noActiveSchemes => LocaleCatalog.instance.t('noActiveSchemes');
  static String get noActiveSchemesDesc => LocaleCatalog.instance.t('noActiveSchemesDesc');
  static String get joinAScheme => LocaleCatalog.instance.t('joinAScheme');
  static String get errorTitle => LocaleCatalog.instance.t('errorTitle');
  static String get errorDescription => LocaleCatalog.instance.t('errorDescription');
  static String get noDataTitle => LocaleCatalog.instance.t('noDataTitle');
  static String get enterYourPassword => LocaleCatalog.instance.t('enterYourPassword');
  static String get enterYourMobileNumber => LocaleCatalog.instance.t('enterYourMobileNumber');
  static String get searchMembers => LocaleCatalog.instance.t('searchMembers');
  static String get otpCode => LocaleCatalog.instance.t('otpCode');
  static String get helperTextSecure => LocaleCatalog.instance.t('helperTextSecure');
  static String get sharedWidgets => LocaleCatalog.instance.t('sharedWidgets');
  static String get sharedWidgetsSubtitle => LocaleCatalog.instance.t('sharedWidgetsSubtitle');
  static String get previewCardTitle => LocaleCatalog.instance.t('previewCardTitle');
  static String get previewCardSubtitle => LocaleCatalog.instance.t('previewCardSubtitle');
  static String get componentDialogTitle => LocaleCatalog.instance.t('componentDialogTitle');
  static String get componentDialogMessage => LocaleCatalog.instance.t('componentDialogMessage');
  static String get componentBottomSheetTitle => LocaleCatalog.instance.t('componentBottomSheetTitle');
  static String get componentBottomSheetMessage => LocaleCatalog.instance.t('componentBottomSheetMessage');
  static String get sampleTileTitle => LocaleCatalog.instance.t('sampleTileTitle');
  static String get sampleTileSubtitle => LocaleCatalog.instance.t('sampleTileSubtitle');
  static String get sampleEmptyMessage => LocaleCatalog.instance.t('sampleEmptyMessage');
  static String get openDialog => LocaleCatalog.instance.t('openDialog');
  static String get openSheet => LocaleCatalog.instance.t('openSheet');
  static String get emailRequired => LocaleCatalog.instance.t('emailRequired');
  static String get invalidEmail => LocaleCatalog.instance.t('invalidEmail');
  static String get passwordRequired => LocaleCatalog.instance.t('passwordRequired');
  static String get passwordTooShort => LocaleCatalog.instance.t('passwordTooShort');
  static String get passwordTooWeak => LocaleCatalog.instance.t('passwordTooWeak');
  static String get passwordsDoNotMatch => LocaleCatalog.instance.t('passwordsDoNotMatch');
  static String get fieldRequired => LocaleCatalog.instance.t('fieldRequired');
  static String get invalidPhone => LocaleCatalog.instance.t('invalidPhone');
  static String get invalidName => LocaleCatalog.instance.t('invalidName');
  static String get invalidUrl => LocaleCatalog.instance.t('invalidUrl');
  static String get navHome => LocaleCatalog.instance.t('navHome');
  static String get navBills => LocaleCatalog.instance.t('navBills');
  static String get navNewBill => LocaleCatalog.instance.t('navNewBill');
  static String get navReports => LocaleCatalog.instance.t('navReports');
  static String get navSettings => LocaleCatalog.instance.t('navSettings');
  static String get exitPressAgain => LocaleCatalog.instance.t('exitPressAgain');
  static String get homeTitle => LocaleCatalog.instance.t('homeTitle');
  static String get billsTitle => LocaleCatalog.instance.t('billsTitle');
  static String get newBillTitle => LocaleCatalog.instance.t('newBillTitle');
  static String get reportsTitle => LocaleCatalog.instance.t('reportsTitle');
  static String get settingsTitle => LocaleCatalog.instance.t('settingsTitle');
  static String get homeWelcome => LocaleCatalog.instance.t('homeWelcome');
  static String get homeSubtitle => LocaleCatalog.instance.t('homeSubtitle');
  static String get newBillPlaceholder => LocaleCatalog.instance.t('newBillPlaceholder');
  static String get createBill => LocaleCatalog.instance.t('createBill');
  static String get productOutOfStock => LocaleCatalog.instance.t('productOutOfStock');
  static String get outOfStock => LocaleCatalog.instance.t('outOfStock');
  static String get goodMorning => LocaleCatalog.instance.t('goodMorning');
  static String get goodAfternoon => LocaleCatalog.instance.t('goodAfternoon');
  static String get goodEvening => LocaleCatalog.instance.t('goodEvening');
  static String get todaysSales => LocaleCatalog.instance.t('todaysSales');
  static String get vsYesterday => LocaleCatalog.instance.t('vsYesterday');
  static String get bills => LocaleCatalog.instance.t('bills');
  static String get avgBillValue => LocaleCatalog.instance.t('avgBillValue');
  static String get bestSeller => LocaleCatalog.instance.t('bestSeller');
  static String get sold => LocaleCatalog.instance.t('sold');
  static String get quickActions => LocaleCatalog.instance.t('quickActions');
  static String get newBillAction => LocaleCatalog.instance.t('newBillAction');
  static String get createInvoice => LocaleCatalog.instance.t('createInvoice');
  static String get findBill => LocaleCatalog.instance.t('findBill');
  static String get searchInvoice => LocaleCatalog.instance.t('searchInvoice');
  static String get addProduct => LocaleCatalog.instance.t('addProduct');
  static String get newItem => LocaleCatalog.instance.t('newItem');
  static String get topProductsToday => LocaleCatalog.instance.t('topProductsToday');
  static String get recentBills => LocaleCatalog.instance.t('recentBills');
  static String get noTopProductsToday => LocaleCatalog.instance.t('noTopProductsToday');
  static String get noRecentBills => LocaleCatalog.instance.t('noRecentBills');
  static String get paid => LocaleCatalog.instance.t('paid');
  static String get credit => LocaleCatalog.instance.t('credit');
  static String get unpaid => LocaleCatalog.instance.t('unpaid');
  static String get partiallyPaid => LocaleCatalog.instance.t('partiallyPaid');
  static String get paymentStatusLabel => LocaleCatalog.instance.t('paymentStatusLabel');
  static String get markAsPaid => LocaleCatalog.instance.t('markAsPaid');
  static String get markAsUnpaid => LocaleCatalog.instance.t('markAsUnpaid');
  static String get paidOn => LocaleCatalog.instance.t('paidOn');
  static String get paymentStatusUpdated => LocaleCatalog.instance.t('paymentStatusUpdated');
  static String get totalAmount => LocaleCatalog.instance.t('totalAmount');
  static String get discount => LocaleCatalog.instance.t('discount');
  static String get paidAmount => LocaleCatalog.instance.t('paidAmount');
  static String get balanceDue => LocaleCatalog.instance.t('balanceDue');
  static String get phone => LocaleCatalog.instance.t('phone');
  static String get viewFullDetails => LocaleCatalog.instance.t('viewFullDetails');
  static String get open => LocaleCatalog.instance.t('open');
  static String get closed => LocaleCatalog.instance.t('closed');
  static String get walkInCustomer => LocaleCatalog.instance.t('walkInCustomer');
  static String get noCustomerSelectedTitle => LocaleCatalog.instance.t('noCustomerSelectedTitle');
  static String get continueWithoutCustomerMessage => LocaleCatalog.instance.t('continueWithoutCustomerMessage');
  static String get walkInCreditBalanceMessage => LocaleCatalog.instance.t('walkInCreditBalanceMessage');
  static String get cups => LocaleCatalog.instance.t('cups');
  static String get pcs => LocaleCatalog.instance.t('pcs');
  static String get ofSales => LocaleCatalog.instance.t('ofSales');
  static String get homeMenu => LocaleCatalog.instance.t('homeMenu');
  static String get appMenuTitle => LocaleCatalog.instance.t('appMenuTitle');
  static String get appMenuSubtitle => LocaleCatalog.instance.t('appMenuSubtitle');
  static String get billedViaApp => LocaleCatalog.instance.t('billedViaApp');
  static String get receiptStorePhoneLabel => LocaleCatalog.instance.t('receiptStorePhoneLabel');
  static String get appBrandFooter => LocaleCatalog.instance.t('appBrandFooter');
  static String get notifications => LocaleCatalog.instance.t('notifications');
  static String get categoriesTitle => LocaleCatalog.instance.t('categoriesTitle');
  static String get productsTitle => LocaleCatalog.instance.t('productsTitle');
  static String get customersTitle => LocaleCatalog.instance.t('customersTitle');
  static String get addCategory => LocaleCatalog.instance.t('addCategory');
  static String get editCategory => LocaleCatalog.instance.t('editCategory');
  static String get deleteCategoryConfirm => LocaleCatalog.instance.t('deleteCategoryConfirm');
  static String get editProduct => LocaleCatalog.instance.t('editProduct');
  static String get deleteProductConfirm => LocaleCatalog.instance.t('deleteProductConfirm');
  static String get addCustomer => LocaleCatalog.instance.t('addCustomer');
  static String get editCustomer => LocaleCatalog.instance.t('editCustomer');
  static String get deleteCustomerConfirm => LocaleCatalog.instance.t('deleteCustomerConfirm');
  static String get categoryName => LocaleCatalog.instance.t('categoryName');
  static String get productName => LocaleCatalog.instance.t('productName');
  static String get quantity => LocaleCatalog.instance.t('quantity');
  static String get unit => LocaleCatalog.instance.t('unit');
  static String get unitRequired => LocaleCatalog.instance.t('unitRequired');
  static String get selectUnit => LocaleCatalog.instance.t('selectUnit');
  static String get selectUnitRequired => LocaleCatalog.instance.t('selectUnitRequired');
  static String get fillAllRequiredFields => LocaleCatalog.instance.t('fillAllRequiredFields');
  static String get unitLockedHint => LocaleCatalog.instance.t('unitLockedHint');
  static String get pricePerUnit => LocaleCatalog.instance.t('pricePerUnit');
  static String get quickSelect => LocaleCatalog.instance.t('quickSelect');
  static String get customQuantity => LocaleCatalog.instance.t('customQuantity');
  static String get customQuantityHint => LocaleCatalog.instance.t('customQuantityHint');
  static String get setQuantity => LocaleCatalog.instance.t('setQuantity');
  static String get selectQuantity => LocaleCatalog.instance.t('selectQuantity');
  static String get removeProduct => LocaleCatalog.instance.t('removeProduct');
  static String get unitPriceLabel => LocaleCatalog.instance.t('unitPriceLabel');
  static String get barcode => LocaleCatalog.instance.t('barcode');
  static String get sgst => LocaleCatalog.instance.t('sgst');
  static String get cgst => LocaleCatalog.instance.t('cgst');
  static String get sgstPercentHint => LocaleCatalog.instance.t('sgstPercentHint');
  static String get cgstPercentHint => LocaleCatalog.instance.t('cgstPercentHint');
  static String get sgstTotal => LocaleCatalog.instance.t('sgstTotal');
  static String get cgstTotal => LocaleCatalog.instance.t('cgstTotal');
  static String get gstTotal => LocaleCatalog.instance.t('gstTotal');
  static String get notAvailable => LocaleCatalog.instance.t('notAvailable');
  static String get price => LocaleCatalog.instance.t('price');
  static String get purchasePrice => LocaleCatalog.instance.t('purchasePrice');
  static String get selectCategory => LocaleCatalog.instance.t('selectCategory');
  static String get customerName => LocaleCatalog.instance.t('customerName');
  static String get phoneNumber => LocaleCatalog.instance.t('phoneNumber');
  static String get calculationTitle => LocaleCatalog.instance.t('calculationTitle');
  static String get calculationSubtitle => LocaleCatalog.instance.t('calculationSubtitle');
  static String get newCalculationBill => LocaleCatalog.instance.t('newCalculationBill');
  static String get editCalculationBill => LocaleCatalog.instance.t('editCalculationBill');
  static String get billName => LocaleCatalog.instance.t('billName');
  static String get billNameHint => LocaleCatalog.instance.t('billNameHint');
  static String get addCustomerToBill => LocaleCatalog.instance.t('addCustomerToBill');
  static String get customerAlreadyInBill => LocaleCatalog.instance.t('customerAlreadyInBill');
  static String get removeCustomerConfirm => LocaleCatalog.instance.t('removeCustomerConfirm');
  static String get grandTotal => LocaleCatalog.instance.t('grandTotal');
  static String get customerSubtotal => LocaleCatalog.instance.t('customerSubtotal');
  static String get saveBill => LocaleCatalog.instance.t('saveBill');
  static String get deleteBillConfirm => LocaleCatalog.instance.t('deleteBillConfirm');
  static String get noCalculationBills => LocaleCatalog.instance.t('noCalculationBills');
  static String get noCalculationBillsHint => LocaleCatalog.instance.t('noCalculationBillsHint');
  static String get billSavedSuccess => LocaleCatalog.instance.t('billSavedSuccess');
  static String get productUnavailable => LocaleCatalog.instance.t('productUnavailable');
  static String get selectCustomerFirst => LocaleCatalog.instance.t('selectCustomerFirst');
  static String get eachCustomerNeedsProduct => LocaleCatalog.instance.t('eachCustomerNeedsProduct');
  static String get enterBillName => LocaleCatalog.instance.t('enterBillName');
  static String get calculationBillDetails => LocaleCatalog.instance.t('calculationBillDetails');
  static String get printBill => LocaleCatalog.instance.t('printBill');
  static String get saveBillLabel => LocaleCatalog.instance.t('saveBillLabel');
  static String get printInvoice => LocaleCatalog.instance.t('printInvoice');
  static String get printerSettingsTitle => LocaleCatalog.instance.t('printerSettingsTitle');
  static String get startWorkingHour => LocaleCatalog.instance.t('startWorkingHour');
  static String get endWorkingHour => LocaleCatalog.instance.t('endWorkingHour');
  static String get selectStartTime => LocaleCatalog.instance.t('selectStartTime');
  static String get selectEndTime => LocaleCatalog.instance.t('selectEndTime');
  static String get managePrinter => LocaleCatalog.instance.t('managePrinter');
  static String get paperWidth => LocaleCatalog.instance.t('paperWidth');
  static String get paperWidth58 => LocaleCatalog.instance.t('paperWidth58');
  static String get paperWidth80 => LocaleCatalog.instance.t('paperWidth80');
  static String get pairedPrinterHint => LocaleCatalog.instance.t('pairedPrinterHint');
  static String get noPrinterConnected => LocaleCatalog.instance.t('noPrinterConnected');
  static String get printerConnected => LocaleCatalog.instance.t('printerConnected');
  static String get bluetoothPrinterHint => LocaleCatalog.instance.t('bluetoothPrinterHint');
  static String get scanPrinters => LocaleCatalog.instance.t('scanPrinters');
  static String get connectPrinter => LocaleCatalog.instance.t('connectPrinter');
  static String get printerConnectedShort => LocaleCatalog.instance.t('printerConnectedShort');
  static String get disconnectPrinter => LocaleCatalog.instance.t('disconnectPrinter');
  static String get testPrint => LocaleCatalog.instance.t('testPrint');
  static String get printerTestLabel => LocaleCatalog.instance.t('printerTestLabel');
  static String get printerTestSuccess => LocaleCatalog.instance.t('printerTestSuccess');
  static String get printerSavedSuccess => LocaleCatalog.instance.t('printerSavedSuccess');
  static String get printerFallbackPreview => LocaleCatalog.instance.t('printerFallbackPreview');
  static String get printerBluetoothDisabled => LocaleCatalog.instance.t('printerBluetoothDisabled');
  static String get printerPermissionDenied => LocaleCatalog.instance.t('printerPermissionDenied');
  static String get printerConnectionFailed => LocaleCatalog.instance.t('printerConnectionFailed');
  static String get printerDeviceNotFound => LocaleCatalog.instance.t('printerDeviceNotFound');
  static String get printerNotConnected => LocaleCatalog.instance.t('printerNotConnected');
  static String get printerPrintFailed => LocaleCatalog.instance.t('printerPrintFailed');
  static String get printerScanFailed => LocaleCatalog.instance.t('printerScanFailed');
  static String get printerUnknownError => LocaleCatalog.instance.t('printerUnknownError');
  static String get language => LocaleCatalog.instance.t('language');
  static String get english => LocaleCatalog.instance.t('english');
  static String get malayalam => LocaleCatalog.instance.t('malayalam');
  static String get languageSectionTitle => LocaleCatalog.instance.t('languageSectionTitle');
  static String get themeLight => LocaleCatalog.instance.t('themeLight');
  static String get themeDark => LocaleCatalog.instance.t('themeDark');
  static String get themeSystem => LocaleCatalog.instance.t('themeSystem');
  static String get themeTitle => LocaleCatalog.instance.t('themeTitle');

  static String productInsufficientStock(int count) =>
      LocaleCatalog.instance.tParams('productInsufficientStock', {'count': '$count'});

  static String productAvailableStock(int count) =>
      LocaleCatalog.instance.tParams('productAvailableStock', {'count': '$count'});

  static String productAvailableStockQty(double count) =>
      LocaleCatalog.instance.tParams('productAvailableStockQty', {'count': _formatQty(count)});

  static String productInsufficientStockQty(double count) =>
      LocaleCatalog.instance.tParams('productInsufficientStockQty', {'count': _formatQty(count)});

  static String _formatQty(double count) {
    if (count == count.truncateToDouble()) {
      return count.toInt().toString();
    }
    return count
        .toStringAsFixed(3)
        .replaceAll(RegExp(r'0+$'), '')
        .replaceAll(RegExp(r'\.$'), '');
  }
  static String get storeProfile => LocaleCatalog.instance.t('storeProfile');
  static String get myStoreFallback => LocaleCatalog.instance.t('myStoreFallback');
  static String get noEmailSet => LocaleCatalog.instance.t('noEmailSet');
  static String get storeName => LocaleCatalog.instance.t('storeName');
  static String get enterBusinessName => LocaleCatalog.instance.t('enterBusinessName');
  static String get contactEmail => LocaleCatalog.instance.t('contactEmail');
  static String get enterBusinessEmail => LocaleCatalog.instance.t('enterBusinessEmail');
  static String get contactPhone => LocaleCatalog.instance.t('contactPhone');
  static String get enterPhoneNumber => LocaleCatalog.instance.t('enterPhoneNumber');
  static String get address => LocaleCatalog.instance.t('address');
  static String get enterAddress => LocaleCatalog.instance.t('enterAddress');
  static String get appPreferenceSection => LocaleCatalog.instance.t('appPreferenceSection');
  static String get savePreferences => LocaleCatalog.instance.t('savePreferences');
  static String get logout => LocaleCatalog.instance.t('logout');
  static String get confirmLogout => LocaleCatalog.instance.t('confirmLogout');
  static String get confirmLogoutMessage => LocaleCatalog.instance.t('confirmLogoutMessage');
  static String get rangeToday => LocaleCatalog.instance.t('rangeToday');
  static String get rangeYesterday => LocaleCatalog.instance.t('rangeYesterday');
  static String get rangeLast7Days => LocaleCatalog.instance.t('rangeLast7Days');
  static String get rangeThisMonth => LocaleCatalog.instance.t('rangeThisMonth');
  static String get rangeThisWeek => LocaleCatalog.instance.t('rangeThisWeek');
  static String get rangeAllTime => LocaleCatalog.instance.t('rangeAllTime');
  static String get topSellingProducts => LocaleCatalog.instance.t('topSellingProducts');
  static String get noProductSalesRecorded => LocaleCatalog.instance.t('noProductSalesRecorded');
  static String get totalSales => LocaleCatalog.instance.t('totalSales');
  static String get totalBills => LocaleCatalog.instance.t('totalBills');
  static String get pendingBills => LocaleCatalog.instance.t('pendingBills');
  static String get updatedJustNow => LocaleCatalog.instance.t('updatedJustNow');
  static String get salesAnalytics => LocaleCatalog.instance.t('salesAnalytics');
  static String get paymentModeShare => LocaleCatalog.instance.t('paymentModeShare');
  static String get noTransactions => LocaleCatalog.instance.t('noTransactions');
  static String get searchBillsHint => LocaleCatalog.instance.t('searchBillsHint');
  static String get categoriesSubtitle => LocaleCatalog.instance.t('categoriesSubtitle');
  static String get productsSubtitle => LocaleCatalog.instance.t('productsSubtitle');
  static String get customersSubtitle => LocaleCatalog.instance.t('customersSubtitle');
  static String get purchasesTitle => LocaleCatalog.instance.t('purchasesTitle');
  static String get purchasesSubtitle => LocaleCatalog.instance.t('purchasesSubtitle');
  static String get enterEmailAddress => LocaleCatalog.instance.t('enterEmailAddress');
  static String get billDetails => LocaleCatalog.instance.t('billDetails');
  static String get shareReceipt => LocaleCatalog.instance.t('shareReceipt');
  static String get shareAsImage => LocaleCatalog.instance.t('shareAsImage');
  static String get shareAsText => LocaleCatalog.instance.t('shareAsText');
  static String get receiptHeader => LocaleCatalog.instance.t('receiptHeader');
  static String get invoiceNo => LocaleCatalog.instance.t('invoiceNo');
  static String get customer => LocaleCatalog.instance.t('customer');
  static String get date => LocaleCatalog.instance.t('date');
  static String get paymentMethod => LocaleCatalog.instance.t('paymentMethod');
  static String get itemDescription => LocaleCatalog.instance.t('itemDescription');
  static String get qty => LocaleCatalog.instance.t('qty');
  static String get total => LocaleCatalog.instance.t('total');
  static String get subtotal => LocaleCatalog.instance.t('subtotal');
  static String get itemDiscounts => LocaleCatalog.instance.t('itemDiscounts');
  static String get billDiscount => LocaleCatalog.instance.t('billDiscount');
  static String get amountPaid => LocaleCatalog.instance.t('amountPaid');
  static String get remainingBalance => LocaleCatalog.instance.t('remainingBalance');
  static String get thankYouShopping => LocaleCatalog.instance.t('thankYouShopping');
  static String get share => LocaleCatalog.instance.t('share');
  static String get storeNameEmpty => LocaleCatalog.instance.t('storeNameEmpty');
  static String get addressEmpty => LocaleCatalog.instance.t('addressEmpty');
  static String get phoneEmpty => LocaleCatalog.instance.t('phoneEmpty');
  static String get companyDetailsSaveFailed => LocaleCatalog.instance.t('companyDetailsSaveFailed');
  static String get companyDetailsSavedSuccess => LocaleCatalog.instance.t('companyDetailsSavedSuccess');
  static String get settingsResetSuccess => LocaleCatalog.instance.t('settingsResetSuccess');

  static String dueAmount(String amount) =>
      LocaleCatalog.instance.tParams('dueAmount', {'amount': amount});

  static String invoiceWithNumber(String number) =>
      LocaleCatalog.instance.tParams('invoiceWithNumber', {'number': number});
  static String get quickProduct => LocaleCatalog.instance.t('quickProduct');
  static String get quickProductHint => LocaleCatalog.instance.t('quickProductHint');
  static String get addImage => LocaleCatalog.instance.t('addImage');
  static String get searchProductsHint => LocaleCatalog.instance.t('searchProductsHint');
  static String get sortBy => LocaleCatalog.instance.t('sortBy');
  static String get lowestPrice => LocaleCatalog.instance.t('lowestPrice');
  static String get highestPrice => LocaleCatalog.instance.t('highestPrice');
  static String get newPurchase => LocaleCatalog.instance.t('newPurchase');
  static String get purchaseDate => LocaleCatalog.instance.t('purchaseDate');
  static String get addItem => LocaleCatalog.instance.t('addItem');
  static String get selectProduct => LocaleCatalog.instance.t('selectProduct');
  static String get addItemToPurchase => LocaleCatalog.instance.t('addItemToPurchase');
  static String get noPurchaseItemsYet => LocaleCatalog.instance.t('noPurchaseItemsYet');
  static String get createPurchase => LocaleCatalog.instance.t('createPurchase');
  static String get billedViaPrefix => LocaleCatalog.instance.t('billedViaPrefix');
  static String get failedCaptureBillPreview => LocaleCatalog.instance.t('failedCaptureBillPreview');
  static String get failedFormatBillImage => LocaleCatalog.instance.t('failedFormatBillImage');
  static String get print => LocaleCatalog.instance.t('print');
  static String get all => LocaleCatalog.instance.t('all');
  static String get selectDateRange => LocaleCatalog.instance.t('selectDateRange');
  static String get status => LocaleCatalog.instance.t('status');
  static String get scanBarcode =>
      LocaleCatalog.instance.t('scanBarcode', fallback: 'Scan Barcode');
  static String get barcodeNotFound =>
      LocaleCatalog.instance.t('barcodeNotFound', fallback: 'No product found with this barcode');
  static String get addedToBill =>
      LocaleCatalog.instance.t('addedToBill', fallback: 'added to bill');
  static String get enterBarcodeManually =>
      LocaleCatalog.instance.t('enterBarcodeManually', fallback: 'Enter Manually');
  static String get enterBarcodeNumber =>
      LocaleCatalog.instance.t('enterBarcodeNumber', fallback: 'Enter the barcode number');
  static String get barcodeNumber =>
      LocaleCatalog.instance.t('barcodeNumber', fallback: 'Barcode Number');
  static String get cantScanBarcode =>
      LocaleCatalog.instance.t('cantScanBarcode', fallback: "Can't scan barcode?");
  static String get noCameraPermission =>
      LocaleCatalog.instance.t('noCameraPermission', fallback: 'Camera permission is required to scan barcodes');

  static String purchaseItemsCount(int count) =>
      LocaleCatalog.instance.tParams('purchaseItemsCount', {'count': '$count'});

  static String qtyTimesPrice({required String qty, required String price}) =>
      LocaleCatalog.instance.tParams('qtyTimesPrice', {'qty': qty, 'price': price});

  static String errorSharingImage(Object error) =>
      LocaleCatalog.instance.tParams('errorSharingImage', {'error': '$error'});

  static String customerNumber(Object? id) =>
      LocaleCatalog.instance.tParams('customerNumber', {'id': '${id ?? ''}'});
}
