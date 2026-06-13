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

  /// No description provided for @addReport.
  ///
  /// In en, this message translates to:
  /// **'Add Report'**
  String get addReport;

  /// No description provided for @watchOurStory.
  ///
  /// In en, this message translates to:
  /// **'Watch Our Story'**
  String get watchOurStory;

  /// No description provided for @seeHowWeTransformStadiums.
  ///
  /// In en, this message translates to:
  /// **'See how we transform stadiums'**
  String get seeHowWeTransformStadiums;

  /// No description provided for @secure.
  ///
  /// In en, this message translates to:
  /// **'Secure'**
  String get secure;

  /// No description provided for @topLevelSecurity.
  ///
  /// In en, this message translates to:
  /// **'Top-level security'**
  String get topLevelSecurity;

  /// No description provided for @fast.
  ///
  /// In en, this message translates to:
  /// **'Fast'**
  String get fast;

  /// No description provided for @realTimeReports.
  ///
  /// In en, this message translates to:
  /// **'Real-time reports'**
  String get realTimeReports;

  /// No description provided for @reliable.
  ///
  /// In en, this message translates to:
  /// **'Reliable'**
  String get reliable;

  /// No description provided for @alwaysAvailable.
  ///
  /// In en, this message translates to:
  /// **'Always available'**
  String get alwaysAvailable;

  /// No description provided for @smart.
  ///
  /// In en, this message translates to:
  /// **'Smart'**
  String get smart;

  /// No description provided for @aiPoweredInsights.
  ///
  /// In en, this message translates to:
  /// **'AI-powered insights'**
  String get aiPoweredInsights;

  /// No description provided for @goToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Go to Sign In'**
  String get goToSignIn;

  /// No description provided for @ourMission.
  ///
  /// In en, this message translates to:
  /// **'Our Mission'**
  String get ourMission;

  /// No description provided for @ourMissionDescription.
  ///
  /// In en, this message translates to:
  /// **'To revolutionize stadium management through innovative reporting and real-time insights for a better experience.'**
  String get ourMissionDescription;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @pleaseEnterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterYourEmail;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @pleaseEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter a password'**
  String get pleaseEnterPassword;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMinLength;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @pleaseConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get pleaseConfirmPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @restPassword.
  ///
  /// In en, this message translates to:
  /// **'Rest Password'**
  String get restPassword;

  /// No description provided for @stadiumEye.
  ///
  /// In en, this message translates to:
  /// **'Stadium Eye'**
  String get stadiumEye;

  /// No description provided for @eventMonitoringSystem.
  ///
  /// In en, this message translates to:
  /// **'Event Monitoring System'**
  String get eventMonitoringSystem;

  /// No description provided for @forgotPasswordQuestion.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPasswordQuestion;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @signInToContinueMonitoring.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue monitoring'**
  String get signInToContinueMonitoring;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @ahmed.
  ///
  /// In en, this message translates to:
  /// **'Ahmed'**
  String get ahmed;

  /// No description provided for @pleaseEnterFirstName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your First name'**
  String get pleaseEnterFirstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @alSalem.
  ///
  /// In en, this message translates to:
  /// **'Al-Salem'**
  String get alSalem;

  /// No description provided for @pleaseEnterLastName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your last name'**
  String get pleaseEnterLastName;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @phoneExample.
  ///
  /// In en, this message translates to:
  /// **'01xxx'**
  String get phoneExample;

  /// No description provided for @pleaseEnterPhone.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get pleaseEnterPhone;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @alreadyHaveUnverifiedAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have unverified account?'**
  String get alreadyHaveUnverifiedAccount;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @selectGender.
  ///
  /// In en, this message translates to:
  /// **'Select Gender'**
  String get selectGender;

  /// No description provided for @pleaseSelectGender.
  ///
  /// In en, this message translates to:
  /// **'Please select a Gender'**
  String get pleaseSelectGender;

  /// No description provided for @joinStadiumEye.
  ///
  /// In en, this message translates to:
  /// **'Join Stadium Eye'**
  String get joinStadiumEye;

  /// No description provided for @contactInformation.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get contactInformation;

  /// No description provided for @helpAndSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpAndSupport;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @loadingDataError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred in loading data'**
  String get loadingDataError;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @totalActiveUsers.
  ///
  /// In en, this message translates to:
  /// **'Total active users'**
  String get totalActiveUsers;

  /// No description provided for @totalTeams.
  ///
  /// In en, this message translates to:
  /// **'Total teams'**
  String get totalTeams;

  /// No description provided for @totalTickets.
  ///
  /// In en, this message translates to:
  /// **'Total tickets'**
  String get totalTickets;

  /// No description provided for @stadiumName.
  ///
  /// In en, this message translates to:
  /// **'Stadium Name'**
  String get stadiumName;

  /// No description provided for @kingFahdInternationalStadium.
  ///
  /// In en, this message translates to:
  /// **'King Fahd International Stadium'**
  String get kingFahdInternationalStadium;

  /// No description provided for @section.
  ///
  /// In en, this message translates to:
  /// **'Section'**
  String get section;

  /// No description provided for @northStand.
  ///
  /// In en, this message translates to:
  /// **'North Stand'**
  String get northStand;

  /// No description provided for @reviewMessage.
  ///
  /// In en, this message translates to:
  /// **'Excellent crowd management during the match.'**
  String get reviewMessage;

  /// No description provided for @review.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get review;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @photoCount.
  ///
  /// In en, this message translates to:
  /// **'Photo count'**
  String get photoCount;

  /// No description provided for @videos.
  ///
  /// In en, this message translates to:
  /// **'Videos'**
  String get videos;

  /// No description provided for @voice.
  ///
  /// In en, this message translates to:
  /// **'Voice'**
  String get voice;

  /// No description provided for @voiceRecordings.
  ///
  /// In en, this message translates to:
  /// **'Voice Recordings'**
  String get voiceRecordings;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @photos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get photos;

  /// No description provided for @mediaGallery.
  ///
  /// In en, this message translates to:
  /// **'Media Gallery'**
  String get mediaGallery;

  /// No description provided for @author.
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get author;

  /// No description provided for @created.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get created;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @stadium.
  ///
  /// In en, this message translates to:
  /// **'Stadium'**
  String get stadium;

  /// No description provided for @area.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get area;

  /// No description provided for @ticketType.
  ///
  /// In en, this message translates to:
  /// **'Ticket Type'**
  String get ticketType;

  /// No description provided for @modelType.
  ///
  /// In en, this message translates to:
  /// **'Model Type'**
  String get modelType;

  /// No description provided for @submittedOn.
  ///
  /// In en, this message translates to:
  /// **'Submitted on '**
  String get submittedOn;

  /// No description provided for @draft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get draft;

  /// No description provided for @lessonsLearned.
  ///
  /// In en, this message translates to:
  /// **'Lessons Learned'**
  String get lessonsLearned;

  /// No description provided for @lesson1.
  ///
  /// In en, this message translates to:
  /// **'Need to open additional entry gates 30 minutes earlier for high-profile matches.'**
  String get lesson1;

  /// No description provided for @lesson2.
  ///
  /// In en, this message translates to:
  /// **'Some delays in entry due to high attendance. Queue management could be improved.'**
  String get lesson2;

  /// No description provided for @challenges.
  ///
  /// In en, this message translates to:
  /// **'Challenges'**
  String get challenges;

  /// No description provided for @observations.
  ///
  /// In en, this message translates to:
  /// **'Observations'**
  String get observations;

  /// No description provided for @reportAuthor.
  ///
  /// In en, this message translates to:
  /// **'Ahmed Al-Salem'**
  String get reportAuthor;

  /// No description provided for @princeFaisalBinFahdStadium.
  ///
  /// In en, this message translates to:
  /// **'Prince Faisal bin Fahd Stadium'**
  String get princeFaisalBinFahdStadium;

  /// No description provided for @eastStand.
  ///
  /// In en, this message translates to:
  /// **'East Stand'**
  String get eastStand;

  /// No description provided for @eastStandReview.
  ///
  /// In en, this message translates to:
  /// **'Great visibility from this section.'**
  String get eastStandReview;

  /// No description provided for @eastStandDate.
  ///
  /// In en, this message translates to:
  /// **'East Stand Date'**
  String get eastStandDate;

  /// No description provided for @kingAbdullahSportsCity.
  ///
  /// In en, this message translates to:
  /// **'King Abdullah Sports City'**
  String get kingAbdullahSportsCity;

  /// No description provided for @westStand.
  ///
  /// In en, this message translates to:
  /// **'West Stand'**
  String get westStand;

  /// No description provided for @westStandReview.
  ///
  /// In en, this message translates to:
  /// **'Security personnel were well-positioned.'**
  String get westStandReview;

  /// No description provided for @westStandDate.
  ///
  /// In en, this message translates to:
  /// **'Nov 10'**
  String get westStandDate;

  /// No description provided for @alAwwalPark.
  ///
  /// In en, this message translates to:
  /// **'Al-Awwal Park'**
  String get alAwwalPark;

  /// No description provided for @southStand.
  ///
  /// In en, this message translates to:
  /// **'South Stand'**
  String get southStand;

  /// No description provided for @southStandReview.
  ///
  /// In en, this message translates to:
  /// **'Draft report in progress.'**
  String get southStandReview;

  /// No description provided for @southStandDate.
  ///
  /// In en, this message translates to:
  /// **'Nov 8'**
  String get southStandDate;

  /// No description provided for @reportDate1.
  ///
  /// In en, this message translates to:
  /// **'11/15/2025'**
  String get reportDate1;

  /// No description provided for @stadium1Name.
  ///
  /// In en, this message translates to:
  /// **'King Fahd International Stadium'**
  String get stadium1Name;

  /// No description provided for @stadium1Section.
  ///
  /// In en, this message translates to:
  /// **'North Stand'**
  String get stadium1Section;

  /// No description provided for @stadium1Review.
  ///
  /// In en, this message translates to:
  /// **'Excellent crowd management during the match.'**
  String get stadium1Review;

  /// No description provided for @stadium2Name.
  ///
  /// In en, this message translates to:
  /// **'Prince Faisal bin Fahd Stadium'**
  String get stadium2Name;

  /// No description provided for @stadium2Section.
  ///
  /// In en, this message translates to:
  /// **'East Stand'**
  String get stadium2Section;

  /// No description provided for @stadium2Review.
  ///
  /// In en, this message translates to:
  /// **'Great visibility from this section.'**
  String get stadium2Review;

  /// No description provided for @stadium3Name.
  ///
  /// In en, this message translates to:
  /// **'King Abdullah Sports City'**
  String get stadium3Name;

  /// No description provided for @stadium3Section.
  ///
  /// In en, this message translates to:
  /// **'West Stand'**
  String get stadium3Section;

  /// No description provided for @stadium3Review.
  ///
  /// In en, this message translates to:
  /// **'Security personnel were well-positioned.'**
  String get stadium3Review;

  /// No description provided for @stadium4Name.
  ///
  /// In en, this message translates to:
  /// **'Al-Awwal Park'**
  String get stadium4Name;

  /// No description provided for @stadium4Section.
  ///
  /// In en, this message translates to:
  /// **'South Stand'**
  String get stadium4Section;

  /// No description provided for @stadium4Review.
  ///
  /// In en, this message translates to:
  /// **'Draft report in progress.'**
  String get stadium4Review;

  /// No description provided for @allReports.
  ///
  /// In en, this message translates to:
  /// **'All Reports'**
  String get allReports;

  /// No description provided for @createReport.
  ///
  /// In en, this message translates to:
  /// **'Create Report'**
  String get createReport;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My profile'**
  String get myProfile;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @mediaAttachments.
  ///
  /// In en, this message translates to:
  /// **'Media Attachments'**
  String get mediaAttachments;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closed;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgress;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @resolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get resolved;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No Data'**
  String get noData;

  /// No description provided for @chooseImageSource.
  ///
  /// In en, this message translates to:
  /// **'Choose Image Source'**
  String get chooseImageSource;

  /// No description provided for @myReports.
  ///
  /// In en, this message translates to:
  /// **'My Reports'**
  String get myReports;

  /// No description provided for @submitted.
  ///
  /// In en, this message translates to:
  /// **'Submitted'**
  String get submitted;

  /// No description provided for @totalReports.
  ///
  /// In en, this message translates to:
  /// **'Total Reports'**
  String get totalReports;

  /// No description provided for @thisMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get thisMonth;

  /// No description provided for @reportDetails.
  ///
  /// In en, this message translates to:
  /// **'Report Details'**
  String get reportDetails;

  /// No description provided for @reportID.
  ///
  /// In en, this message translates to:
  /// **'Report ID'**
  String get reportID;

  /// No description provided for @submitReport.
  ///
  /// In en, this message translates to:
  /// **'Submit Report'**
  String get submitReport;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @team.
  ///
  /// In en, this message translates to:
  /// **'Team'**
  String get team;

  /// No description provided for @uploadPhoto.
  ///
  /// In en, this message translates to:
  /// **'Upload Photo'**
  String get uploadPhoto;

  /// No description provided for @uploadVideo.
  ///
  /// In en, this message translates to:
  /// **'Upload Video'**
  String get uploadVideo;

  /// No description provided for @recordVoiceNote.
  ///
  /// In en, this message translates to:
  /// **'Record Voice Note'**
  String get recordVoiceNote;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @reportAnIssueQuickly.
  ///
  /// In en, this message translates to:
  /// **'Report an issue quickly'**
  String get reportAnIssueQuickly;

  /// No description provided for @viewSubmittedReports.
  ///
  /// In en, this message translates to:
  /// **'View your submitted reports'**
  String get viewSubmittedReports;

  /// No description provided for @viewPersonalDataSettings.
  ///
  /// In en, this message translates to:
  /// **'View personal data & settings'**
  String get viewPersonalDataSettings;

  /// No description provided for @recentActivity.
  ///
  /// In en, this message translates to:
  /// **'Recent Activity'**
  String get recentActivity;

  /// No description provided for @photoCaptured.
  ///
  /// In en, this message translates to:
  /// **'Photo captured'**
  String get photoCaptured;

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'5 hours ago'**
  String get hoursAgo;

  /// No description provided for @dayAgo.
  ///
  /// In en, this message translates to:
  /// **'1 day ago'**
  String get dayAgo;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @keyTakeaways.
  ///
  /// In en, this message translates to:
  /// **'Key takeaways...'**
  String get keyTakeaways;

  /// No description provided for @anyChallengesFaced.
  ///
  /// In en, this message translates to:
  /// **'Any challenges faced...'**
  String get anyChallengesFaced;

  /// No description provided for @describeObservations.
  ///
  /// In en, this message translates to:
  /// **'Describe your observations here...'**
  String get describeObservations;

  /// No description provided for @selectArea.
  ///
  /// In en, this message translates to:
  /// **'Select Area'**
  String get selectArea;

  /// No description provided for @selectStadium.
  ///
  /// In en, this message translates to:
  /// **'Select Stadium'**
  String get selectStadium;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location *'**
  String get location;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @switchTheme.
  ///
  /// In en, this message translates to:
  /// **'Switch between light and dark theme'**
  String get switchTheme;

  /// No description provided for @languageAndRegion.
  ///
  /// In en, this message translates to:
  /// **'Language & Region'**
  String get languageAndRegion;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @pushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get pushNotifications;

  /// No description provided for @receiveUpdates.
  ///
  /// In en, this message translates to:
  /// **'Receive updates and alerts'**
  String get receiveUpdates;

  /// No description provided for @notificationsDisabled.
  ///
  /// In en, this message translates to:
  /// **'Notifications disabled'**
  String get notificationsDisabled;

  /// No description provided for @unknownState.
  ///
  /// In en, this message translates to:
  /// **'Unknown state'**
  String get unknownState;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @matches.
  ///
  /// In en, this message translates to:
  /// **'Matches'**
  String get matches;

  /// No description provided for @matche.
  ///
  /// In en, this message translates to:
  /// **'Match'**
  String get matche;

  /// No description provided for @show.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get show;

  /// No description provided for @filterMatches.
  ///
  /// In en, this message translates to:
  /// **'Filter Matches'**
  String get filterMatches;

  /// No description provided for @league.
  ///
  /// In en, this message translates to:
  /// **'League'**
  String get league;

  /// No description provided for @season.
  ///
  /// In en, this message translates to:
  /// **'Season'**
  String get season;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @chooseLeague.
  ///
  /// In en, this message translates to:
  /// **'Choose League'**
  String get chooseLeague;

  /// No description provided for @chooseCountry.
  ///
  /// In en, this message translates to:
  /// **'Choose Country'**
  String get chooseCountry;

  /// No description provided for @chooseStatus.
  ///
  /// In en, this message translates to:
  /// **'Choose Status'**
  String get chooseStatus;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @unknownVenue.
  ///
  /// In en, this message translates to:
  /// **'Unknown Venue'**
  String get unknownVenue;

  /// No description provided for @modeChanger.
  ///
  /// In en, this message translates to:
  /// **'Artificial intelligence analysis ?'**
  String get modeChanger;
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
