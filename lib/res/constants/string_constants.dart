class Strings {
  // General
  static const String appName = "Thuka";
  static const String ok = "OK";
  static const String cancel = "Cancel";
  static const String save = "Save";
  static const String delete = "Delete";
  static const String edit = "Edit";
  static const String done = "Done";
  static const String loading = "Loading...";
  static const String retry = "Retry";
  static const String close = "Close";
  static const String confirm = "Confirm";
  static const String search = "Search";
  static const String clear = "Clear";
  static const String viewAll = "View All";
  static const String seeDetails = "See Details";
  static const String continueLabel = "Continue";
  static const String showPassword = "Show password";
  static const String hidePassword = "Hide password";
  static const String orLabel = "OR";

  // Error messages
  static const String somethingWentWrong = "Something went wrong";
  static const String noInternet = "No internet connection";
  static const String sessionExpired = "Session expired. Please login again.";
  static const String noDataFound = "No data found";
  static const String connectionErrorTitle = "Oops! No Connection.";
  static const String connectionErrorDesc =
      "Check your connection and try again.";
  static const String noResultsFound = "Sorry, no results found!";
  static const String noResultsDesc =
      "Please try refining your search or using different keywords.";

  // Auth
  static const String welcomeBack = "Welcome Back";
  static const String signInToContinue =
      "Sign in to shop and track your orders";
  static const String authTrustLine = "Secure checkout · Order tracking";
  static const String login = "Login";
  static const String register = "Register";
  static const String email = "Email";
  static const String password = "Password";
  static const String mobileNumber = "Mobile Number";
  static const String getOtp = "Get OTP";
  static const String dontHaveAccount = "Don't have an account? ";
  static const String signUp = "Sign Up";
  static const String continueWithGoogle = "Continue with Google";
  static const String forgotPassword = "Forgot Password?";
  static const String refresh = "Refresh";
  static const String error500Title = "Server Error";
  static const String error500Message = "Internal server error occurred.";
  static const String noDataAvailable = "No data available";
  static const String noDataAvailableDesc =
      "There is no data to show right now.";
  static const String goBackButton = "Go Back";
  static const String noDataMessage = "We couldn't find any data.";
  static const String noOffersYet = "No Offers";
  static const String noOffersYetDesc = "No offers are currently available.";
  static const String logIn = "Login";
  static const String noGiftCards = "No Gift Cards";
  static const String noGiftCardsDesc = "You don't have any gift cards yet.";
  static const String noFavoriteProducts = "No Favorites";
  static const String noFavoriteProductsDesc =
      "You haven't favorited any products.";
  static const String noTransactionsFound = "No Transactions";
  static const String noTransactionsDesc =
      "You don't have any past transactions.";
  static const String noNotifications = "No Notifications";
  static const String noNotificationsDesc = "You are all caught up.";
  static const String noActiveSchemes = "No Active Schemes";
  static const String noActiveSchemesDesc =
      "You aren't enrolled in any schemes.";
  static const String joinAScheme = "Join a Scheme";
  static const String errorTitle = "Error";
  static const String errorDescription = "An unexpected error occurred.";
  static const String noDataTitle = "No Data";
  static const String enterYourPassword = "Enter your password";
  static const String enterYourMobileNumber = "Enter your mobile number";
  static const String searchMembers = "Search members";
  static const String otpCode = "OTP Code";
  static const String helperTextSecure =
      "Your details stay secure and private.";
  static const String sharedWidgets = "Shared Widgets";
  static const String sharedWidgetsSubtitle =
      "Reference components for auth, content, and actions.";
  static const String previewCardTitle = "Reusable Surface";
  static const String previewCardSubtitle =
      "Use this shared container for cards, summary boxes, and grouped content.";
  static const String componentDialogTitle = "Component Dialog";
  static const String componentDialogMessage =
      "Dialogs and bottom sheets now use shared surfaces and actions.";
  static const String componentBottomSheetTitle = "Component Bottom Sheet";
  static const String componentBottomSheetMessage =
      "This bottom sheet demonstrates the common modal surface.";
  static const String sampleTileTitle = "Notifications";
  static const String sampleTileSubtitle =
      "Shared list tiles keep spacing and actions consistent.";
  static const String sampleEmptyMessage =
      "Use this screen to preview the shared widget kit during development.";
  static const String openDialog = "Open Dialog";
  static const String openSheet = "Open Sheet";

  // Validation
  static const String emailRequired = "Email is required";
  static const String invalidEmail = "Enter a valid email address";
  static const String passwordRequired = "Password is required";
  static const String passwordTooShort =
      "Password must be at least 6 characters";
  static const String passwordTooWeak = "Password is too weak";
  static const String passwordsDoNotMatch = "Passwords do not match";
  static const String fieldRequired = "This field is required";
  static const String invalidPhone = "Enter a valid phone number";
  static const String invalidName = "Enter a valid name";
  static const String invalidUrl = "Enter a valid URL";

  // Navigation
  static const String navHome = "Home";
  static const String navBills = "Bills";
  static const String navNewBill = "New Bill";
  static const String navReports = "Reports";
  static const String navSettings = "Settings";
  static const String exitPressAgain = "Press back again to exit";

  // Screen titles
  static const String homeTitle = "Home";
  static const String billsTitle = "Bills";
  static const String newBillTitle = "New Bill";
  static const String reportsTitle = "Reports";
  static const String settingsTitle = "Settings";
  static const String homeWelcome = "Welcome to Thuka";
  static const String homeSubtitle =
      "Track sales, bills, and daily business at a glance.";
  static const String newBillPlaceholder =
      "Create a new bill for your customer.";
  static const String createBill = "Create Bill";
  static const String productOutOfStock = "This product is out of stock";
  static String productInsufficientStock(int count) =>
      "Only $count units available";
  static String productAvailableStock(int count) => "Available: $count";
  static const String outOfStock = "Out of stock";

  // Home dashboard
  static const String goodMorning = "Good Morning";
  static const String goodAfternoon = "Good Afternoon";
  static const String goodEvening = "Good Evening";
  static const String todaysSales = "Today's Sales";
  static const String vsYesterday = "vs Yesterday";
  static const String bills = "Bills";
  static const String avgBillValue = "Avg. Bill Value";
  static const String bestSeller = "Best Seller";
  static const String sold = "Sold";
  static const String quickActions = "Quick Actions";
  static const String newBillAction = "New Bill";
  static const String createInvoice = "Create Invoice";
  static const String findBill = "Find Bill";
  static const String searchInvoice = "Search Invoice";
  static const String addProduct = "Add Product";
  static const String newItem = "New Item";
  static const String topProductsToday = "Top Products Today";
  static const String recentBills = "Recent Bills";
  static const String noTopProductsToday = "No products sold today";
  static const String noRecentBills = "No recent bills";
  static const String paid = "Paid";
  static const String credit = "Credit";
  static const String unpaid = "Unpaid";
  static const String partiallyPaid = "Partially Paid";
  static const String paymentStatusLabel = "Payment Status:";
  static const String markAsPaid = "Mark as Paid";
  static const String markAsUnpaid = "Mark as Unpaid";
  static const String paidOn = "Paid on";
  static const String paymentStatusUpdated = "Payment status updated";
  static const String totalAmount = "Total Amount";
  static const String discount = "Discount";
  static const String paidAmount = "Paid Amount";
  static const String balanceDue = "Balance Due";
  static const String phone = "Phone";
  static const String viewFullDetails = "View Full Details";
  static const String open = "Open";
  static const String closed = "Closed";
  static const String walkInCustomer = "Walk-in Customer";
  static const String noCustomerSelectedTitle = "No Customer Selected";
  static const String continueWithoutCustomerMessage =
      "No customer is selected. Do you want to continue without a customer?";
  static const String walkInCreditBalanceMessage =
      "will be recorded as outstanding balance for this walk-in bill";
  static const String cups = "Cups";
  static const String pcs = "Pcs";
  static const String ofSales = "of sales";
  static const String homeMenu = "Menu";
  static const String appMenuTitle = "Thuka Menu";
  static const String appMenuSubtitle = "Manage business inventory";
  static const String billedViaApp = "Billed via Thuka App";
  static const String receiptStorePhoneLabel = "Ph";
  static const String appBrandFooter = "Thuka App";
  static const String notifications = "Notifications";

  // CRUD Screen Titles
  static const String categoriesTitle = "Categories";
  static const String productsTitle = "Products";
  static const String customersTitle = "Customers";
  static const String addCategory = "Add Category";
  static const String editCategory = "Edit Category";
  static const String deleteCategoryConfirm =
      "Are you sure you want to delete this category?";
  static const String editProduct = "Edit Product";
  static const String deleteProductConfirm =
      "Are you sure you want to delete this product?";
  static const String addCustomer = "Add Customer";
  static const String editCustomer = "Edit Customer";
  static const String deleteCustomerConfirm =
      "Are you sure you want to delete this customer?";
  static const String categoryName = "Category Name";
  static const String productName = "Product Name";
  static const String quantity = "Quantity";
  static const String unit = "Unit";
  static const String unitRequired = "Unit *";
  static const String selectUnit = "Select Unit";
  static const String selectUnitRequired = "Please select a unit";
  static const String fillAllRequiredFields = "Please fill all required fields";
  static const String unitLockedHint =
      "Unit cannot be changed after the product is created";
  static const String pricePerUnit = "Price per unit";
  static const String quickSelect = "Quick Select";
  static const String customQuantity = "Custom Quantity";
  static const String customQuantityHint = "Enter quantity...";
  static const String setQuantity = "Set Quantity";
  static const String selectQuantity = "Select Quantity";
  static const String removeProduct = "Remove Product";
  static const String unitPriceLabel = "Unit Price";
  static String productAvailableStockQty(double count) =>
      "Available: ${_formatQty(count)}";
  static String productInsufficientStockQty(double count) =>
      "Only ${_formatQty(count)} units available";

  static String _formatQty(double count) {
    if (count == count.truncateToDouble()) {
      return count.toInt().toString();
    }
    return count
        .toStringAsFixed(3)
        .replaceAll(RegExp(r'0+$'), '')
        .replaceAll(RegExp(r'\.$'), '');
  }
  static const String barcode = "Barcode";
  static const String sgst = "SGST";
  static const String cgst = "CGST";
  static const String sgstPercentHint = "SGST (%) — optional";
  static const String cgstPercentHint = "CGST (%) — optional";
  static const String sgstTotal = "SGST Total";
  static const String cgstTotal = "CGST Total";
  static const String gstTotal = "GST Total";
  static const String notAvailable = "—";
  static const String price = "Price";
  static const String purchasePrice = "Purchase Price";
  static const String selectCategory = "Select Category";
  static const String customerName = "Customer Name";
  static const String phoneNumber = "Phone Number";

  // Estimates
  static const String calculationTitle = "Estimates";
  static const String calculationSubtitle = "Multi-customer order bills";
  static const String newCalculationBill = "New Bill";
  static const String editCalculationBill = "Edit Bill";
  static const String billName = "Bill Name";
  static const String billNameHint = "e.g. Monday Morning Orders";
  static const String addCustomerToBill = "Add Customer";
  static const String customerAlreadyInBill =
      "This customer is already in the bill";
  static const String removeCustomerConfirm =
      "Remove this customer and all their products from the bill?";
  static const String grandTotal = "Grand Total";
  static const String customerSubtotal = "Subtotal";
  static const String saveBill = "Save Bill";
  static const String deleteBillConfirm =
      "Are you sure you want to delete this estimate?";
  static const String noCalculationBills = "No estimates yet";
  static const String noCalculationBillsHint =
      "Create an estimate to save customer product lists and totals";
  static const String billSavedSuccess = "Estimate saved successfully";
  static const String productUnavailable = "Price unavailable";
  static const String selectCustomerFirst = "Select a customer first";
  static const String eachCustomerNeedsProduct =
      "Each customer needs at least one product";
  static const String enterBillName = "Enter a bill name";
  static const String calculationBillDetails = "Estimate Details";

  // Printer
  static const String printBill = "Print Bill";
  static const String saveBillLabel = "Save Bill";
  static const String printInvoice = "Print Invoice";
  static const String printerSettingsTitle = "Printer";
  static const String startWorkingHour = "Start Working Hour";
  static const String endWorkingHour = "End Working Hour";
  static const String selectStartTime = "Select start time";
  static const String selectEndTime = "Select end time";
  static const String managePrinter = "Manage Printer";
  static const String paperWidth = "Paper Width";
  static const String paperWidth58 = "58 mm";
  static const String paperWidth80 = "80 mm";
  static const String pairedPrinterHint =
      "Make sure your printer is paired in Bluetooth settings before scanning.";
  static const String noPrinterConnected = "No printer connected";
  static const String printerConnected = "Printer connected";
  static const String bluetoothPrinterHint =
      "Connect a Bluetooth receipt printer to enable direct bill printing.";
  static const String scanPrinters = "Scan Printers";
  static const String connectPrinter = "Connect";
  static const String printerConnectedShort = "Connected";
  static const String disconnectPrinter = "Disconnect Printer";
  static const String testPrint = "Test Print";
  static const String printerTestLabel = "TEST PRINT";
  static const String printerTestSuccess = "Test print sent successfully";
  static const String printerSavedSuccess = "Receipt sent to printer";
  static const String printerFallbackPreview =
      "Printer unavailable. Showing bill preview instead.";
  static const String printerBluetoothDisabled =
      "Bluetooth is turned off. Enable Bluetooth to use the printer.";
  static const String printerPermissionDenied =
      "Bluetooth permission is required to connect to the printer.";
  static const String printerConnectionFailed =
      "Failed to connect to the printer. Check that it is paired and powered on.";
  static const String printerDeviceNotFound =
      "Printer not found. Scan for printers and try again.";
  static const String printerNotConnected = "No Bluetooth printer connected.";
  static const String printerPrintFailed =
      "Failed to print receipt. Check the printer connection.";
  static const String printerScanFailed =
      "Failed to scan for printers. Check Bluetooth and permissions.";
  static const String printerUnknownError =
      "An unexpected printer error occurred. Please try again.";
}
