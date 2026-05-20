import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'ar'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? arText = '',
  }) =>
      [enText, arText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // Register
  {
    '8hcv407j': {
      'en': 'Ready to play?',
      'ar': 'جاهز تلعب؟',
    },
    'q0xexk63': {
      'en': 'Join FESHAH',
      'ar': 'إنشاء حساب',
    },
    'yqq8nrzc': {
      'en': 'Log in to FESHAH',
      'ar': 'تسجيل الدخول',
    },
    '6ogu4ojw': {
      'en': 'What should we call you?',
      'ar': 'الأسم',
    },
    'oahbnkh3': {
      'en': '',
      'ar': 'اسم',
    },
    's2f3covc': {
      'en': 'What should we call you?',
      'ar': 'الأسم',
    },
    'ohlwt6is': {
      'en': 'Email',
      'ar': 'الإيميل',
    },
    'wcqp23oa': {
      'en': '',
      'ar': 'بريد إلكتروني',
    },
    'dklyo2fk': {
      'en': 'Email',
      'ar': 'الإيميل',
    },
    'l9ajbwqm': {
      'en': 'Password',
      'ar': 'كلمة المرور',
    },
    'i2jz3sfk': {
      'en': '',
      'ar': 'كلمة المرور',
    },
    'wosc8egr': {
      'en': 'Password',
      'ar': 'كلمة المرور',
    },
    'phcirnqa': {
      'en': 'Confirm Password',
      'ar': 'تأكيد كلمة المرور',
    },
    'te44cai8': {
      'en': '',
      'ar': 'تأكيد كلمة المرور',
    },
    'v8bs2xl1': {
      'en': 'Confirm Password',
      'ar': 'تأكيد كلمة المرور',
    },
    'tpquuhg2': {
      'en': 'I accept the ',
      'ar': 'انا اقبل',
    },
    'se8uxwj4': {
      'en': 'Terms and Conditions',
      'ar': 'الشروط والأحكام',
    },
    'msnqxnb6': {
      'en': 'I accept the Terms and Conditions',
      'ar': 'أوافق على الشروط والأحكام',
    },
    'rj66jrpu': {
      'en': 'Join FESHAH',
      'ar': 'إنشاء حساب',
    },
    '6ir6xl7p': {
      'en': 'Returning to FESHAH? Tap to ',
      'ar': 'عندك حساب؟ سجّل دخولك',
    },
    't9mj1qls': {
      'en': 'Log in to FESHAH',
      'ar': 'تسجيل الدخول',
    },
    'e3ae5mzv': {
      'en': 'Don\'t forget to tell us your name!',
      'ar': 'الاسم مطلوب ولا يمكن تركه فارغًا',
    },
    'vyr98wme': {
      'en': 'Pick one from the dropdown',
      'ar': 'اختَر من القائمة',
    },
    'ejscdj6h': {
      'en': 'Enter a valid email',
      'ar': 'يرجى إدخال عنوان بريد إلكتروني صالح',
    },
    'chhr7nux': {
      'en': 'Check your email!',
      'ar': 'يجب أن يكون البريد الإلكتروني صالحًا!',
    },
    'c1itltwz': {
      'en': 'Pick one from the dropdown',
      'ar': 'اختَر من القائمة',
    },
    '3xrni60k': {
      'en': 'Password can\'t be empty!',
      'ar': 'كلمة المرور مطلوبة ولا يمكن أن تكون فارغة',
    },
    'eghujs2i': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'bjng5dzx': {
      'en': 'Please confirm your password.',
      'ar': 'الرجاء تأكيد كلمة المرور الخاصة بك.',
    },
    'ab27aher': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'c55wiutv': {
      'en': 'Home',
      'ar': '',
    },
  },
  // Login
  {
    'pt0heq6k': {
      'en': 'Log in to FESHAH',
      'ar': 'اتسجيل الدخول',
    },
    'wesi8b15': {
      'en': 'Unlock your FESHAH world',
      'ar': 'حيّاك بعالم فيشة!',
    },
    '5a20t246': {
      'en': 'Log in to FESHAH',
      'ar': 'تسجيل الدخول',
    },
    '1nvgfg1l': {
      'en': 'Email',
      'ar': 'الإيميل',
    },
    'tgrptewq': {
      'en': '',
      'ar': 'بريد إلكتروني',
    },
    'tmz7gdi4': {
      'en': 'Email',
      'ar': 'الإيميل',
    },
    'hzajaoeo': {
      'en': 'Password',
      'ar': 'كلمة المرور',
    },
    'iles7hbr': {
      'en': '',
      'ar': 'كلمة المرور',
    },
    '2efim58s': {
      'en': 'Password',
      'ar': 'كلمة المرور',
    },
    '16yh8pkp': {
      'en': 'Forgot password ?',
      'ar': 'هل نسيت كلمة السر ؟',
    },
    'q6clftgj': {
      'en': 'Log in to FESHAH',
      'ar': 'تسجيل الدخول',
    },
    'chgacyqm': {
      'en': 'New here? Join FESHAH',
      'ar': 'أول مره؟ أنشئ حساب',
    },
    'rl3t6f1r': {
      'en': ' Sign Up',
      'ar': 'اشتراك',
    },
    'q0kimxk7': {
      'en': 'Enter a valid email',
      'ar': 'يرجى إدخال عنوان بريد إلكتروني صالح',
    },
    'fqz330fo': {
      'en': 'Check your email!',
      'ar': 'يجب أن يكون البريد الإلكتروني صالحًا',
    },
    'ggfnflwh': {
      'en': 'Pick one from the dropdown',
      'ar': 'اختَر من القائمة',
    },
    '3wy1scra': {
      'en': 'Password can\'t be empty!',
      'ar': 'يرجى تأكيد كلمة المرور الخاصة بك',
    },
    'jb7zs7o3': {
      'en': 'Pick one from the dropdown',
      'ar': 'اختَر من القائمة',
    },
    'i640glsi': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // Profile
  {
    'jjoxceqt': {
      'en': 'What should we call you?',
      'ar': 'الأسم',
    },
    'iditvef4': {
      'en': 'Email',
      'ar': 'الإيميل',
    },
    '3960x6yj': {
      'en': 'Phone Number',
      'ar': 'رقم الهاتف',
    },
    'rm723eke': {
      'en': 'Chose your country',
      'ar': 'الدولة',
    },
    'm69zxq4p': {
      'en': 'Pick your language',
      'ar': 'اللغة',
    },
    'zke0lox1': {
      'en': 'Account Info',
      'ar': 'معلومات الحساب',
    },
    'wgj4p8ef': {
      'en': 'Saved Addresses',
      'ar': 'العناوين المحفوظة',
    },
    'v2nikwa8': {
      'en': 'Change Email',
      'ar': '',
    },
    'kpr9y7ui': {
      'en': 'Change Password',
      'ar': '',
    },
    'rqb9ioyh': {
      'en': 'Notifications',
      'ar': 'إشعارات',
    },
    '0orphdu9': {
      'en': 'Sound',
      'ar': 'صوت',
    },
    'tlrq4h14': {
      'en': 'Language',
      'ar': 'لغة',
    },
    '639od4mw': {
      'en': 'Country',
      'ar': 'دولة',
    },
    '0s91ml46': {
      'en': 'Transactions',
      'ar': 'المعاملات',
    },
    'mv065wcq': {
      'en': 'About App',
      'ar': 'حول التطبيق',
    },
    'cqz6alzc': {
      'en': 'Logout',
      'ar': 'تسجيل الخروج',
    },
    '76sdn3fu': {
      'en': 'Your profile',
      'ar': 'معلوماتك الشخصيه',
    },
    'ikm55xvc': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // Home
  {
    '3ces6fpx': {
      'en': 'Available games',
      'ar': 'الألعاب المتاحة',
    },
    '6cb9a76c': {
      'en': 'Your Rooms',
      'ar': 'غرفك',
    },
    '3otho1ws': {
      'en': 'View all',
      'ar': 'عرض الكل',
    },
    '63im02ij': {
      'en': 'Create Room',
      'ar': 'أنشاء غرفة',
    },
    'mdo1otzr': {
      'en': 'Join Room',
      'ar': 'انضم إلى الغرفة',
    },
    'ousndss8': {
      'en': 'Play with friends',
      'ar': 'العب مع الأصدقاء',
    },
    '0g7tj9f0': {
      'en': 'The fun begins when you enter a room! Join or create one now!',
      'ar': 'المتعة تبدأ عند دخول غرفة! انضم او انشئ واحدة الآن!',
    },
    'jhs7bh2c': {
      'en': 'View Rooms',
      'ar': 'عرض الغرف',
    },
    'grelvo4l': {
      'en': 'Play With Friends',
      'ar': 'غرفك',
    },
    'ql2803y1': {
      'en': 'The fun begins when you enter a room join or start one now!',
      'ar': 'غرفك',
    },
    'i9mn9opd': {
      'en': 'View Room',
      'ar': 'عرض الغرفة',
    },
    'ipxmlu80': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // Welcome
  {
    'to0dyuf3': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // RoomCreate-S2
  {
    'qdxh58vw': {
      'en': 'Room ID',
      'ar': 'رقم الغرفة',
    },
    '2n7yy8q9': {
      'en': 'Invite players',
      'ar': 'دعوة اللاعبين',
    },
    'nqpz8jdu': {
      'en': 'View Room',
      'ar': 'عرض الغرفة',
    },
    'qujcgdez': {
      'en': 'Players info & Status',
      'ar': 'معلومات اللاعبين',
    },
    'ko9goyvd': {
      'en': 'Joined',
      'ar': 'انضم',
    },
    'cexlo8sc': {
      'en': 'Invite players',
      'ar': 'دعوة اللاعبين',
    },
    '7n7yhq00': {
      'en': 'Joined',
      'ar': 'انضم',
    },
    'ca97qyni': {
      'en': ' Joined',
      'ar': ' انضم ',
    },
    '2zavag7v': {
      'en': 'Invite players',
      'ar': 'دعوة اللاعبين',
    },
    'f9wfku4n': {
      'en': 'Active',
      'ar': 'نشط حالياً',
    },
    'rh9n9obr': {
      'en': 'Invited',
      'ar': 'مدعو',
    },
    '3neienq3': {
      'en': 'Request',
      'ar': 'تم ارسال الطلب',
    },
    '74bgvrx0': {
      'en': 'All',
      'ar': 'الجميع',
    },
    'pv36ddny': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // EditProfile
  {
    '0comsesl': {
      'en': 'Email',
      'ar': 'البريد إلكتروني',
    },
    '62a42h7h': {
      'en': '',
      'ar': '',
    },
    '2bewdr60': {
      'en': 'Enter your email address',
      'ar': 'أدخل عنوان بريدك الإلكتروني',
    },
    '7k35jugy': {
      'en': 'First name',
      'ar': 'اسم',
    },
    '4j3hjhoq': {
      'en': '',
      'ar': 'أدخل اسمك',
    },
    '6qvgd7cq': {
      'en': 'Enter your first name',
      'ar': 'أدخل اسمك الأول',
    },
    'uvxbqxi7': {
      'en': 'Date of Birth ',
      'ar': 'تاريخ الميلاد',
    },
    'jq2l615l': {
      'en': 'Phone Number ',
      'ar': 'رقم التليفون',
    },
    'c8zfie2r': {
      'en': 'Please select...',
      'ar': '',
    },
    'clpw1ads': {
      'en': 'Search...',
      'ar': '',
    },
    'dejs47c2': {
      'en': 'Enter your mobile number',
      'ar': 'أدخل رقم هاتفك المحمول',
    },
    'f5yy53sp': {
      'en': 'Gender (optional) ',
      'ar': 'الجنس (اختياري)',
    },
    'a1gblcby': {
      'en': 'Male',
      'ar': 'ذكر',
    },
    'eiuzy6pi': {
      'en': 'Female',
      'ar': 'أنثى',
    },
    '2jgyekn4': {
      'en': 'Prefer not to say',
      'ar': 'أفضل عدم القول',
    },
    '4i4uis3k': {
      'en': 'Yes, I want to receive offers & discounts',
      'ar': 'نعم أريد الحصول على العروض والخصومات',
    },
    'wm8e3n6v': {
      'en': 'Subscribe to newsletter',
      'ar': 'اشترك في النشرة الإخبارية',
    },
    'prpfpa6t': {
      'en': 'Save',
      'ar': 'يحفظ',
    },
    'vdzvpdk0': {
      'en': 'Delete Account',
      'ar': 'حذف الحساب',
    },
    '1gveeodr': {
      'en': 'Field is required',
      'ar': 'الحقل مطلوب',
    },
    '6ils0vpp': {
      'en': 'Pick one from the dropdown',
      'ar': 'اختَر من القائمة',
    },
    'h29533gv': {
      'en': 'Name is required and cannot be left blank',
      'ar': 'الاسم مطلوب ولا يمكن تركه فارغًا',
    },
    'x19t20mm': {
      'en': 'Maximum characters exceded',
      'ar': '',
    },
    'ilab2prp': {
      'en': 'Pick one from the dropdown',
      'ar': 'اختَر من القائمة',
    },
    'jp6xvuoj': {
      'en': 'Mobile number is required',
      'ar': 'رقم الهاتف المحمول مطلوب',
    },
    '5tn12q4n': {
      'en': 'Pick one from the dropdown',
      'ar': 'اختَر من القائمة',
    },
    'c3vemma9': {
      'en': 'Edit Personal Info',
      'ar': 'تعديل المعلومات الشخصية',
    },
    'govfgvve': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // RoomCreate-S1
  {
    'rhrk21ho': {
      'en': 'Create Room',
      'ar': 'أنشاء غرفة',
    },
    'itnly8sq': {
      'en': 'Change icon',
      'ar': 'تغيير الرمز',
    },
    '1ji8v0ux': {
      'en': 'Name  your  Room',
      'ar': 'أسم غرفتك',
    },
    'y8xmxr0l': {
      'en': '',
      'ar': 'بريد إلكتروني',
    },
    '3n851b1h': {
      'en': 'eg., “Family Space”',
      'ar': 'على سبيل المثال، \"مساحة العائلة\"',
    },
    'ij27lhi3': {
      'en': 'Member Limits',
      'ar': 'عدد اللاعبين',
    },
    'wce7l26g': {
      'en': '0 to 5 Player',
      'ar': 'من ٠ إلى ٥ لاعبين',
    },
    'x5bwffts': {
      'en': 'Select...',
      'ar': 'اختَر...',
    },
    'v55vhi7r': {
      'en': 'Search...',
      'ar': 'أبحث...',
    },
    '0e3e6sbg': {
      'en': '0 to 5 Player',
      'ar': 'من ٠ إلى ٥ لاعبين',
    },
    '5lv7nruo': {
      'en': '5 to 25 Player',
      'ar': 'أكثر من ٢٥ لاعب',
    },
    'pia1did3': {
      'en': 'more than 25 Player',
      'ar': 'أكثر من 25 لاعبًا',
    },
    'ytmw1r7x': {
      'en': 'Please confirm if you are using a room wallet.',
      'ar': 'تأكد إذا كنت تريد استخدام محفظة الغرفة',
    },
    'd2s3mx9h': {
      'en': 'Create Room',
      'ar': 'إنشاء غرفة',
    },
    'revzkbwf': {
      'en': 'What should we call your room?',
      'ar': 'اسم الغرفة ولا يمكن تركه فارغًا',
    },
    'eq19g3d4': {
      'en': 'Pick one from the dropdown',
      'ar': 'اختَر من القائمة',
    },
    '1vv39wze': {
      'en': 'Member limit is require.',
      'ar': 'يجب تحدد عدد اللاعبين',
    },
    'ya6reu3a': {
      'en': 'Pick one from the dropdown',
      'ar': 'اختَر من القائمة',
    },
    '9ll6crr5': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // RoomSpace
  {
    '6ybj3krq': {
      'en': '0 Badges',
      'ar': '0 شارات',
    },
    'linhaktw': {
      'en': 'Players in Room',
      'ar': 'اللاعبون في الغرفة',
    },
    'syntk1gt': {
      'en': ' Joined',
      'ar': 'انضم',
    },
    'u422i1np': {
      'en': 'Invite players',
      'ar': 'قم بدعوة اللاعبين باستخدام معرف الغرفة الفريد الخاص بك',
    },
    '3et0n14o': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // RoomJoin
  {
    'v7552l9h': {
      'en': 'Enter Room ID',
      'ar': 'أدخل معرف الغرفة',
    },
    '4dpsqyha': {
      'en': 'You can join your leader space by entering the room ID',
      'ar': 'يمكنك الانضمام إلى الغرفة الخاصة بك عن طريق إدخال رقم الغرفة',
    },
    'm4fr3viz': {
      'en': 'Join Room',
      'ar': 'انضم إلى الغرفة',
    },
    'drjpy70c': {
      'en': 'Room ID is required and cannot be empty.',
      'ar': 'يجب إدخال رقم الغرفة ولا يمكن أن يكون فارغًا.',
    },
    'frcaca5h': {
      'en': 'Join Room',
      'ar': 'انضم إلى الغرفة',
    },
    'ib4ig5s5': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // MyFeshah
  {
    'vj1s00wk': {
      'en': 'Your',
      'ar': 'لك',
    },
    'dc6g3i75': {
      'en': 'Wallet Balance',
      'ar': 'رصيد محفظتك',
    },
    'pzaizia6': {
      'en': 'Your Room',
      'ar': 'غرفتك',
    },
    'ys97b8ea': {
      'en': 'Your Game History',
      'ar': 'تاريخ ألعابك',
    },
    'vku6mm4r': {
      'en': 'Play Again',
      'ar': 'أعد اللعب',
    },
    'u1yfuqe4': {
      'en': 'Your Transactions',
      'ar': 'تعاملاتك',
    },
    '4z0vb3l7': {
      'en': 'My Feshah',
      'ar': 'الفيش',
    },
    '1la5i55q': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // Notification
  {
    '4127qkj6': {
      'en': 'Clear All',
      'ar': 'مسح الكل',
    },
    'aztdjrbx': {
      'en': 'Notifications',
      'ar': 'إشعارات',
    },
    'molkj53r': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // Badges
  {
    'a2nifn9z': {
      'en': 'You Earned',
      'ar': 'لديك',
    },
    'wv1kafca': {
      'en': 'Level 3 Badge',
      'ar': '',
    },
    'mn7vm31q': {
      'en': 'Play more games to earn more badges',
      'ar': 'العب المزيد من الألعاب لكسب الشارات',
    },
    'y5c8ojwz': {
      'en': 'Badges You earned',
      'ar': 'اللاعبين',
    },
    '1xkk9go7': {
      'en': 'Level 1 – New Beginnings',
      'ar': '',
    },
    '2awfatkz': {
      'en': 'Awarded for creating a space and having at least 2 players join.',
      'ar': '',
    },
    'lfzwdw2r': {
      'en': '13 Mar 2025',
      'ar': '',
    },
    'w1zd6ew3': {
      'en': 'Level 1 – New Beginnings',
      'ar': '',
    },
    '8biktpn0': {
      'en': 'Awarded for creating a space and having at least 2 players join.',
      'ar': '',
    },
    'qkzd4fj9': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // Settings
  {
    '8mv2m705': {
      'en': 'Add Another Admin',
      'ar': '',
    },
    '58v9uj96': {
      'en': '',
      'ar': '',
    },
    '8t6l0fqt': {
      'en': 'Remove Player',
      'ar': 'إزالة اللاعب',
    },
    'qegkshd4': {
      'en': '',
      'ar': '',
    },
    't9pbrfd9': {
      'en': 'Pending Requests',
      'ar': 'الطلبات المعلقة',
    },
    'ysnkv74c': {
      'en': '',
      'ar': '',
    },
    'v6qvpj4i': {
      'en': 'Share Room Code',
      'ar': 'مشاركة رمز الغرفة',
    },
    'pljv97j1': {
      'en': '',
      'ar': '',
    },
    'cuclpa98': {
      'en': 'Exit Room',
      'ar': 'غرفة الخروج',
    },
    'c8u30fw0': {
      'en': '',
      'ar': '',
    },
    '74qyd2s1': {
      'en': 'App Version: 2.913',
      'ar': '',
    },
    'prjgxoji': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // GameOne
  {
    'cpvltc5a': {
      'en': 'Create Teams',
      'ar': 'إنشاء فرق',
    },
    'cgi3vp9o': {
      'en': '1',
      'ar': '1',
    },
    'os2khmsk': {
      'en': '2',
      'ar': '2',
    },
    'fo56w5rr': {
      'en': '3',
      'ar': '3',
    },
    '0hml601r': {
      'en': 'Delete',
      'ar': 'يمسح',
    },
    'cykn38wp': {
      'en': '',
      'ar': '',
    },
    '4okzfrmc': {
      'en': 'TeamA Name is required.',
      'ar': 'اسم الفريق A مطلوب.',
    },
    'o4iqjr5v': {
      'en': 'Requires atleast 2 characters',
      'ar': 'يتطلب حرفين على الأقل',
    },
    'se49s767': {
      'en': 'Maximum 20 characters are allowed',
      'ar': 'الحد الأقصى المسموح به هو 20 حرفًا',
    },
    'lor3nmmv': {
      'en': 'Please choose an option from the dropdown',
      'ar': 'اختَر من القائمة',
    },
    'n1ij271y': {
      'en': '',
      'ar': '',
    },
    'm8y31ywg': {
      'en': 'TeamB Name is required.',
      'ar': 'اسم الفريق B مطلوب.',
    },
    '2xxvd920': {
      'en': 'Requires atleast 2 characters',
      'ar': 'يتطلب حرفين على الأقل',
    },
    'tw39gpbx': {
      'en': 'Maximum 20 characters are allowed',
      'ar': 'الحد الأقصى المسموح به هو 20 حرفًا',
    },
    'tt28rcut': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'x44ha29l': {
      'en': '',
      'ar': '',
    },
    '83soh6rr': {
      'en': 'TeamC Name is required.',
      'ar': 'اسم الفريق C مطلوب.',
    },
    'ab9ib9fw': {
      'en': 'Requires atleast 2 characters',
      'ar': 'يتطلب حرفين على الأقل',
    },
    't80sxzlf': {
      'en': 'Maximum 20 characters are allowed',
      'ar': 'الحد الأقصى المسموح به هو 20 حرفًا',
    },
    '07y2qy3g': {
      'en': 'Please choose an option from the dropdown',
      'ar': 'اختَر من القائمة',
    },
    'm4noog32': {
      'en': 'Next',
      'ar': 'البدء',
    },
    'n6kkpgs6': {
      'en':
          'Players can play as one team against computer. if you give right answer you will get point or if its wrong the computer will get the point.',
      'ar':
          'يمكن للاعبين اللعب كفريق واحد ضد الكمبيوتر. إذا قدمت الإجابة الصحيحة فستحصل على نقطة وإذا كانت الإجابة خاطئة فسيحصل الكمبيوتر على نقطة.',
    },
    'xvl6qk6w': {
      'en': 'Choose Topic',
      'ar': 'اختر الموضوع',
    },
    'hmyfo33y': {
      'en': 'Choose ',
      'ar': 'يختار',
    },
    'v35mwhkx': {
      'en': ' Topics to start the game',
      'ar': 'مواضيع لبدء اللعبة',
    },
    'g2rler62': {
      'en': 'Random',
      'ar': 'عشوائيا',
    },
    'aj9eeebb': {
      'en': 'remaining',
      'ar': 'متبقي',
    },
    'nbwv9dd2': {
      'en': '3 Topics',
      'ar': '3 Topics',
    },
    'dlf437o3': {
      'en': '6 Topics',
      'ar': '6 Topics',
    },
    'nc6htsnx': {
      'en': '3 Topics',
      'ar': '3 Topics',
    },
    'qcbyogvs': {
      'en': 'Start the game',
      'ar': 'ابدأ اللعبة',
    },
    'txuf2z9p': {
      'en': 'Available teams',
      'ar': '',
    },
    '2b16cad4': {
      'en': '',
      'ar': 'اسم',
    },
    'mpgfkv5o': {
      'en': 'Team ‘B’ name here...',
      'ar': '',
    },
    'eehdijzz': {
      'en': 'Save',
      'ar': '',
    },
    'a32lzx1v': {
      'en': 'Start the game',
      'ar': 'البدء',
    },
    '27alt6eg': {
      'en': 'Players Info',
      'ar': 'اللاعبين',
    },
    'bfpvqqd5': {
      'en': 'Joined',
      'ar': 'انضم',
    },
    'vi69tf26': {
      'en': 'Invite players',
      'ar': 'دعوة اللاعبين',
    },
    't338brq8': {
      'en': 'Active',
      'ar': 'نشط حالياً',
    },
    'ak2m6gye': {
      'en': 'Viewer',
      'ar': 'مشاهد',
    },
    'f4wgqzme': {
      'en': 'Topics',
      'ar': 'المواضيع',
    },
    '6fyucz4d': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // GameOne-S2
  {
    'fqt0cv58': {
      'en': 'View Video',
      'ar': 'شاهد الفيديو',
    },
    '0efjodv4': {
      'en': 'View Answer',
      'ar': 'شاهد الإجابة',
    },
    'z29f309n': {
      'en': 'Tie Breaker Score',
      'ar': 'نتيجة كسر التعادل',
    },
    'o11acu9a': {
      'en': 'correct',
      'ar': 'صح',
    },
    '5y20g4xw': {
      'en': 'wrong',
      'ar': 'خطأ',
    },
    'ds4x8bbe': {
      'en': 'Topics',
      'ar': 'المواضيع',
    },
    '5x0ro4bk': {
      'en': 'Topics',
      'ar': 'المواضيع',
    },
    '35hm3zob': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // GameOne-S3
  {
    'lgmp4cu8': {
      'en': ' win the game',
      'ar': 'الفوز باللعبة',
    },
    'v288bsix': {
      'en': 'What year was Kuwait\'s independence from Britain?',
      'ar': '',
    },
    '6kx17662': {
      'en': 'A',
      'ar': 'أ',
    },
    'lx88p4gf': {
      'en': 'Score',
      'ar': 'نتيجة',
    },
    'oxod0a7q': {
      'en': '|',
      'ar': 'مقابل',
    },
    'ws5r8bek': {
      'en': 'B',
      'ar': 'ب',
    },
    '7s86chng': {
      'en': 'Score',
      'ar': 'نتيجة',
    },
    'cttostvf': {
      'en': '|',
      'ar': 'مقابل',
    },
    'hfwb1st7': {
      'en': 'C',
      'ar': 'ج',
    },
    'iy38zgly': {
      'en': 'Score',
      'ar': 'نتيجة',
    },
    't5qdsq7s': {
      'en': 'Share Result',
      'ar': 'مشاركة النتيجة',
    },
    'yx5z9z7m': {
      'en': 'Next Game',
      'ar': 'المباراة القادمة',
    },
    'yfr9f09g': {
      'en': 'A',
      'ar': 'أ',
    },
    'yxu54j9q': {
      'en': 'Score',
      'ar': 'نتيجة',
    },
    '3cxjlds5': {
      'en': 'VS',
      'ar': 'ضد',
    },
    'xsn8j6j4': {
      'en': 'B',
      'ar': 'ب',
    },
    'k1n29tsd': {
      'en': 'Score',
      'ar': 'نتيجة',
    },
    'u8qa8d4s': {
      'en': 'VS',
      'ar': 'ضد',
    },
    'ygl32nb6': {
      'en': 'C',
      'ar': 'ج',
    },
    's2h8dtc2': {
      'en': 'Score',
      'ar': 'نتيجة',
    },
    '12rlmve9': {
      'en': 'Play Tie Breaker',
      'ar': 'لعب كسر التعادل',
    },
    'lylg5ihz': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // GameTwo
  {
    'atna3qq0': {
      'en': 'Players info & Status',
      'ar': 'معلومات اللاعبين',
    },
    'ytlcvpoa': {
      'en': 'Joined',
      'ar': 'انضم',
    },
    'f3yoxl7h': {
      'en': 'Invite players',
      'ar': 'دعوة اللاعبين',
    },
    '7dqsx6fy': {
      'en': 'Choose Topic',
      'ar': 'اختر الموضوع',
    },
    'ibo152d2': {
      'en': 'Choose ',
      'ar': 'يختار',
    },
    'rkbcpeu7': {
      'en': ' Topics to start the game',
      'ar': 'مواضيع لبدء اللعبة',
    },
    'n1edt54a': {
      'en': 'Random',
      'ar': 'عشوائيا',
    },
    'ja27kzbs': {
      'en': 'remaining',
      'ar': 'متبقي',
    },
    'un3dp1bq': {
      'en': 'You are the',
      'ar': '',
    },
    'vav61e4t': {
      'en': 'Suspect',
      'ar': 'يشتبه',
    },
    'gkgtb3yc': {
      'en': 'Topic Screen',
      'ar': 'شاشة الموضوع',
    },
    '35kp4tk9': {
      'en': 'Voting',
      'ar': 'التصويت',
    },
    '5nry7y8y': {
      'en': 'Wanna see real suspect?',
      'ar': 'هل تريد رؤية المشتبه به الحقيقي؟',
    },
    'sln8umtq': {
      'en': 'Suspect',
      'ar': 'يشتبه',
    },
    'k79k4zhd': {
      'en': 'Result',
      'ar': 'نتيجة',
    },
    'gs7ow44q': {
      'en': 'Suspect',
      'ar': 'يشتبه',
    },
    'zmjd8qve': {
      'en': 'Result',
      'ar': '',
    },
    '8m5jdsrc': {
      'en': 'Tips',
      'ar': 'نصائح',
    },
    '4jn1lwl5': {
      'en': 'Invite players',
      'ar': 'دعوة اللاعبين',
    },
    'kuhz9yvs': {
      'en': 'Share the invite link or scan the QR to join this game ',
      'ar':
          'شارك رابط الدعوة أو امسح رمز الاستجابة السريعة للانضمام إلى هذه اللعبة',
    },
    '92hlxxbp': {
      'en': 'Players info & Status',
      'ar': 'معلومات اللاعبينمعلومات اللاعبين',
    },
    'xxo3kdhh': {
      'en': ' Joined',
      'ar': ' انضم',
    },
    'c089hqxw': {
      'en': 'Invite players',
      'ar': 'دعوة اللاعبين',
    },
    'e09rt564': {
      'en': 'Who is the suspect?',
      'ar': 'من هو المشتبه به؟',
    },
    'k517kfwh': {
      'en': 'Who is the suspect?',
      'ar': 'اللاعبين',
    },
    'unrokp18': {
      'en': 'Start the game',
      'ar': 'إنشاء غرفة',
    },
    'puf8pb40': {
      'en': ' is the real suspect! with ',
      'ar': 'هو المشتبه به الحقيقي!',
    },
    'l6chhjom': {
      'en': ' points',
      'ar': 'نقاط',
    },
    'ze5d94hw': {
      'en': 'What year was Kuwait\'s independence from Britain?',
      'ar': '',
    },
    '8wf8ppt5': {
      'en': 'Well played, no one guessed you',
      'ar': 'لقد لعبت بشكل جيد، لم يخمنك أحد',
    },
    'lb34w8a2': {
      'en':
          'if suspect guessed the word correctly they will get extra + 50 points',
      'ar':
          'إذا خمن المشتبه به الكلمة بشكل صحيح، فسوف يحصل على +50 نقطة إضافية',
    },
    'cs4duaq0': {
      'en': 'Suspect guessed the word',
      'ar': 'المشتبه به خمن الكلمة',
    },
    '8dz66itm': {
      'en': 'Share Result',
      'ar': 'البدء',
    },
    'i5k0bg8e': {
      'en': 'Who Guessed Correctly  ',
      'ar': 'من خمن بشكل صحيح',
    },
    'ix8hfses': {
      'en': 'Who is the suspect?',
      'ar': 'اللاعبين',
    },
    'qlbhb20k': {
      'en': 'Suspect',
      'ar': 'يشتبه',
    },
    'u6f6ifmh': {
      'en': ' is winner with ',
      'ar': 'هو الفائز مع',
    },
    'k04nl1k9': {
      'en': ' points',
      'ar': 'نقاط',
    },
    'idlpn7ez': {
      'en': 'What year was Kuwait\'s independence from Britain?',
      'ar': '',
    },
    'ycrosudy': {
      'en': 'Share Result',
      'ar': 'البدء',
    },
    '37jf7j6d': {
      'en': 'Final score of game',
      'ar': 'النتيجة النهائية للمباراة',
    },
    '24psnyfw': {
      'en': 'Who is the suspect?',
      'ar': 'اللاعبين',
    },
    '82l8ifj4': {
      'en': 'You',
      'ar': 'أنت',
    },
    '32x6puqf': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // Game3-RoomModeInvite
  {
    '48p85tzx': {
      'en': 'Players in space',
      'ar': 'اللاعبين',
    },
    '3uet7rn9': {
      'en': '5/12 People Available ',
      'ar': '',
    },
    'hnu3gava': {
      'en': '(last updated 2 min ago)',
      'ar': '',
    },
    'g4gcgs8l': {
      'en': '1',
      'ar': '',
    },
    '7a8eitg4': {
      'en': 'Anil',
      'ar': '',
    },
    'v52u80ll': {
      'en': 'Player ID: 223645',
      'ar': '',
    },
    'wdv6vu4r': {
      'en': 'You',
      'ar': '',
    },
    '40e0ikfv': {
      'en': 'Invite',
      'ar': '',
    },
    '3281gsm5': {
      'en': 'Start the game',
      'ar': 'إنشاء غرفة',
    },
    '1syqb6b5': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // Game3-AccountModeInvite
  {
    'wcbxsv99': {
      'en': 'Invite players',
      'ar': 'اللاعبين',
    },
    'lrhpc1h7': {
      'en': 'Share the invite link or scan the QR to join this game ',
      'ar': '',
    },
    '42zphm3k': {
      'en': 'www.feshahkw.com/',
      'ar': '',
    },
    'geecrote': {
      'en': 'Share',
      'ar': '',
    },
    '3ibmezuw': {
      'en': 'Players in space',
      'ar': 'اللاعبين',
    },
    'fmehehrz': {
      'en': '5/12 People Available ',
      'ar': '',
    },
    'hqm06kzj': {
      'en': '(last updated 2 min ago)',
      'ar': '',
    },
    'knt00f14': {
      'en': '1',
      'ar': '',
    },
    'd6lalxxe': {
      'en': 'Anil',
      'ar': '',
    },
    '2gbkyiiu': {
      'en': 'Invite',
      'ar': '',
    },
    'idmepdv7': {
      'en': 'Start the game',
      'ar': 'إنشاء غرفة',
    },
    'eswfmtk4': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // Game3-Round1
  {
    'ed6hl0dx': {
      'en': 'Sec',
      'ar': '',
    },
    '06vidgjw': {
      'en': 'History | Q02',
      'ar': '',
    },
    'mfuzl188': {
      'en': 'Round 1',
      'ar': '',
    },
    'zxmv53b0': {
      'en': 'If you could have any superpower for a day, what would it be?',
      'ar': '',
    },
    'ne6kx5si': {
      'en': '',
      'ar': 'اسم',
    },
    'kqct8mtn': {
      'en': 'Your answer here...',
      'ar': '',
    },
    '5avo58ld': {
      'en': 'Submit',
      'ar': 'البدء',
    },
    '1eo2cnmr': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // Game3-BlueThemeforvoting
  {
    '64vkm2a3': {
      'en': 'Your Answer',
      'ar': '',
    },
    've2n9wme': {
      'en': 'The power to make my boss disappear.',
      'ar': '',
    },
    'b4jjkmrl': {
      'en': 'The power to make my boss disappear.',
      'ar': '',
    },
    'uqzmzy9b': {
      'en': 'Like',
      'ar': '',
    },
    'x8sb9bbx': {
      'en': 'Voting',
      'ar': '',
    },
    '71vl7gw6': {
      'en': '4/6',
      'ar': '',
    },
    '399zideq': {
      'en': 'Voted',
      'ar': '',
    },
    'aog7tr4x': {
      'en': 'Sec',
      'ar': '',
    },
    'z7ffa2ek': {
      'en': 'Announce Result',
      'ar': 'البدء',
    },
    'qizt2wpa': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // GameOne-S1
  {
    'qz7um0sa': {
      'en': 'Topics',
      'ar': 'المواضيع',
    },
    '1nlw1967': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // Signin-phone
  {
    'dfdrsyws': {
      'en': 'Log in to FESHAH',
      'ar': 'تسجيل الدخول',
    },
    'q5kofnpf': {
      'en': 'Access your account to enjoy a seamless experience.',
      'ar': 'لنبدأ بتسجيل الدخول.',
    },
    'lzhgalc3': {
      'en': 'Log in to FESHAH',
      'ar': 'تسجيل الدخول',
    },
    'u0jx61dv': {
      'en': 'Mobile number',
      'ar': 'إنشاء حساب',
    },
    'tfjxloky': {
      'en': 'Enter mobile number',
      'ar': 'بريد إلكتروني',
    },
    'hrct6r2k': {
      'en': 'Get OTP',
      'ar': 'تسجيل الدخول',
    },
    'nge1c497': {
      'en': 'New here? Join FESHAH',
      'ar': 'أول مره؟ أنشئ حساب',
    },
    '0puw44i6': {
      'en': ' Sign Up',
      'ar': 'سجل هنا',
    },
    'fux81q23': {
      'en': 'Field is required',
      'ar': 'الحقل مطلوب',
    },
    'yah8pf7w': {
      'en': 'Check your email!',
      'ar': 'يجب أن يكون البريد الإلكتروني صالحًا!',
    },
    '8xmrzmen': {
      'en': 'Pick one from the dropdown',
      'ar': 'اختَر من القائمة',
    },
    '71wezi5q': {
      'en': 'Field is required',
      'ar': 'الحقل مطلوب',
    },
    '6dyp3wy8': {
      'en': 'Pick one from the dropdown',
      'ar': 'اختَر من القائمة',
    },
    'qgr466j2': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // Verify-mobile
  {
    '0zbo3gwy': {
      'en': 'Verify Your Mobile Number',
      'ar': 'مرحبًا بعودتك',
    },
    'jcxc3n6x': {
      'en': 'Enter the 4-digit code sent to your mobile to continue',
      'ar': 'لنبدأ بتسجيل الدخول.',
    },
    'q307rbli': {
      'en': '+965 1234 5678  ',
      'ar': 'ليس لديك حساب؟',
    },
    '0fkydbxa': {
      'en': 'Edit',
      'ar': 'سجل هنا',
    },
    '1z41p6ha': {
      'en': 'Confirm & Continue',
      'ar': 'تسجيل الدخول',
    },
    'pnadul7g': {
      'en': 'New here? Join FESHAH',
      'ar': 'أول مره؟ أنشئ حساب',
    },
    '8bfikcz1': {
      'en': ' Sign Up',
      'ar': 'سجل هنا',
    },
    'o6nmsaye': {
      'en': 'Field is required',
      'ar': 'الحقل مطلوب',
    },
    '1ye0v6jg': {
      'en': 'Check your email!',
      'ar': 'يجب أن يكون البريد الإلكتروني صالحًا!',
    },
    'jq4x6vnl': {
      'en': 'Pick one from the dropdown',
      'ar': 'اختَر من القائمة',
    },
    'k8i173bl': {
      'en': 'Field is required',
      'ar': 'الحقل مطلوب',
    },
    'kpeiyqjt': {
      'en': 'Pick one from the dropdown',
      'ar': 'اختَر من القائمة',
    },
    '52f4vg9o': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // Onboard
  {
    't5089mc5': {
      'en': 'Get Started',
      'ar': 'البدء',
    },
    'gfbc28ll': {
      'en': 'Login',
      'ar': 'تسجيل الدخول',
    },
    'pql33o79': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // AccountStats
  {
    'axpqctjj': {
      'en': 'Player ID',
      'ar': 'معرف اللاعب',
    },
    'wdaboszs': {
      'en': 'Joined On',
      'ar': 'انضم في',
    },
    '05alzsmi': {
      'en': 'Gender',
      'ar': 'إجمالي العملات المنفقة',
    },
    '1fvqlcy7': {
      'en': 'Date of Birth',
      'ar': 'إجمالي العملات المنفقة',
    },
    '22qfjudd': {
      'en': 'Total Coins Spent',
      'ar': 'إجمالي العملات المنفقة',
    },
    '3c6koaw9': {
      'en': 'Account Stats',
      'ar': 'إحصائيات الحساب',
    },
    'vvm7tywu': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // Payment
  {
    '9wvrdkm9': {
      'en': 'Copy & Paste',
      'ar': 'نسخ ولصق',
    },
    '9jjcgjv4': {
      'en': 'Processing Payment...',
      'ar': 'جاري معالجة الدفع...',
    },
    'xo7qndol': {
      'en': 'back',
      'ar': '',
    },
    'talij8er': {
      'en': 'Payment',
      'ar': 'قسط',
    },
    'x4s4eswt': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // verify
  {
    'h3rrws84': {
      'en': 'Verifying payment....\ndon\'t close the app',
      'ar': '',
    },
    'splhenvn': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // Success
  {
    '2iu5j3ql': {
      'en': 'Payment Success',
      'ar': 'نجاح الدفع',
    },
    'rnt3kf62': {
      'en': 'Thank You!',
      'ar': 'شكرًا لك!',
    },
    'p41u53jw': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // Failed
  {
    '49q5667a': {
      'en': 'Failed!',
      'ar': 'فشل!',
    },
    'bj59d9cr': {
      'en': 'Your Purchase was unsuccessful',
      'ar': 'لم تنجح عملية الشراء الخاصة بك',
    },
    'gqfb1jz4': {
      'en': 'Continue',
      'ar': 'يكمل',
    },
    'sffkkxan': {
      'en': 'Payment Failed',
      'ar': 'فشل الدفع',
    },
    'l69be8hx': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // Transaction
  {
    'iihfbvwp': {
      'en': 'Your  Wallet Balance',
      'ar': 'رصيد محفظتك',
    },
    'a0nrvg6w': {
      'en': ' Coins',
      'ar': 'عملات معدنية',
    },
    '75pv57ma': {
      'en': '150 ',
      'ar': '',
    },
    '4w1oaszb': {
      'en': 'Recharge now',
      'ar': 'اشحن الآن',
    },
    'loetk218': {
      'en': 'Recent Transactions',
      'ar': 'المعاملات الأخيرة',
    },
    '09rgifjc': {
      'en': 'View all',
      'ar': 'اللاعبين',
    },
    '5ouh31re': {
      'en': 'Wallet',
      'ar': 'محفظة',
    },
    'e3hqi2ib': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // TransactionRoom
  {
    '0n0mzwbv': {
      'en': 'You have',
      'ar': '',
    },
    '2z2ll10l': {
      'en': 'Level 3 Badge',
      'ar': '',
    },
    'ydwjvvnh': {
      'en': 'Play more games to earn more greater badges ',
      'ar': '',
    },
    'ok1c3aw8': {
      'en': 'Badges You earned',
      'ar': 'اللاعبين',
    },
    '1k8ewz27': {
      'en': 'Level 1 – New Beginnings',
      'ar': '',
    },
    'u4eqez7e': {
      'en': 'Awarded for creating a space and having at least 2 players join.',
      'ar': '',
    },
    'lgj7ruoc': {
      'en': '13 Mar 2025',
      'ar': '',
    },
    '7r9awnw5': {
      'en': 'Level 1 – New Beginnings',
      'ar': '',
    },
    '7ghoy2hq': {
      'en': 'Awarded for creating a space and having at least 2 players join.',
      'ar': '',
    },
    'bann411a': {
      'en': 'Your Wallet',
      'ar': '',
    },
    'psf1nw0s': {
      'en': 'Your  Wallet Balance',
      'ar': '',
    },
    'chtfnqby': {
      'en': ' Coins',
      'ar': '',
    },
    'uho3mlnh': {
      'en': '150 ',
      'ar': '',
    },
    '6l4csy5j': {
      'en': 'Recharge now',
      'ar': 'إنشاء غرفة',
    },
    'l9idi0ul': {
      'en': 'Recent Transactions',
      'ar': 'اللاعبين',
    },
    'etonyssk': {
      'en': 'View all',
      'ar': 'اللاعبين',
    },
    'jnrlyq6g': {
      'en': 'Spy among us',
      'ar': '',
    },
    'i5tkc6vi': {
      'en': '14 March  |  10:00AM',
      'ar': '',
    },
    'lz7tt0t0': {
      'en': '10',
      'ar': '',
    },
    '6r2wwp3b': {
      'en': 'Spy among us',
      'ar': '',
    },
    '4ibjmv4y': {
      'en': '14 March  |  10:00AM',
      'ar': '',
    },
    '5tlko8lt': {
      'en': '10',
      'ar': '',
    },
    'vlqtcnaf': {
      'en': 'Spy among us',
      'ar': '',
    },
    'gtyw5fr3': {
      'en': '14 March  |  10:00AM',
      'ar': '',
    },
    'yc2nb767': {
      'en': '10',
      'ar': '',
    },
    'hvxex9a4': {
      'en': 'Spy among us',
      'ar': '',
    },
    '570jx0mh': {
      'en': '14 March  |  10:00AM',
      'ar': '',
    },
    '1417bq9g': {
      'en': '10',
      'ar': '',
    },
    '75t006kv': {
      'en': 'Room Wallet',
      'ar': '',
    },
    '1bzn2dx7': {
      'en': 'Room Wallet Balance',
      'ar': '',
    },
    'dbbt86hl': {
      'en': '200 ',
      'ar': '',
    },
    'tlcbjee3': {
      'en': 'Coins',
      'ar': '',
    },
    'v55c1to3': {
      'en': '200 Coins',
      'ar': '',
    },
    'm2hksbsp': {
      'en': 'Recharge now',
      'ar': '',
    },
    'xnbriqle': {
      'en': 'Recent Transactions',
      'ar': 'اللاعبين',
    },
    'boy8lh04': {
      'en': 'View all',
      'ar': 'اللاعبين',
    },
    '885lbv3a': {
      'en': 'Spy among us',
      'ar': '',
    },
    'd8hpcq4j': {
      'en': ' | ',
      'ar': '',
    },
    'xet5k4mh': {
      'en': 'Think & Win',
      'ar': '',
    },
    'fiaode4c': {
      'en': 'Spy among us',
      'ar': '',
    },
    'x9dntok3': {
      'en': 'Split Pay ',
      'ar': '',
    },
    'skyrflo4': {
      'en': ' |  ',
      'ar': '',
    },
    '2g8lc960': {
      'en': '14 March ',
      'ar': '',
    },
    'enviom38': {
      'en': ' |  ',
      'ar': '',
    },
    's84rfyca': {
      'en': '10:00AM',
      'ar': '',
    },
    'bh9a8x5n': {
      'en': '14 March  |  10:00AM',
      'ar': '',
    },
    'rnbl7zzi': {
      'en': '10',
      'ar': '',
    },
    'vssvjl7j': {
      'en': 'Spy among us',
      'ar': '',
    },
    'vy3at27x': {
      'en': ' | ',
      'ar': '',
    },
    'r1yzo11e': {
      'en': 'Think & Win',
      'ar': '',
    },
    'uit79df4': {
      'en': 'Spy among us',
      'ar': '',
    },
    'cx57en8c': {
      'en': 'Split Pay ',
      'ar': '',
    },
    'oit9go3l': {
      'en': ' |  ',
      'ar': '',
    },
    '1x40kjuv': {
      'en': '14 March ',
      'ar': '',
    },
    'u8pm6kea': {
      'en': ' |  ',
      'ar': '',
    },
    'ql41allv': {
      'en': '10:00AM',
      'ar': '',
    },
    '800t0dth': {
      'en': '14 March  |  10:00AM',
      'ar': '',
    },
    'uw7oozba': {
      'en': '10',
      'ar': '',
    },
    't2gdw98s': {
      'en': 'Spy among us',
      'ar': '',
    },
    'giqxdo1x': {
      'en': ' | ',
      'ar': '',
    },
    'og08wcgk': {
      'en': 'Think & Win',
      'ar': '',
    },
    'cc2hyqka': {
      'en': 'Spy among us',
      'ar': '',
    },
    'gid5hor7': {
      'en': 'Split Pay ',
      'ar': '',
    },
    'feyjk0zb': {
      'en': ' |  ',
      'ar': '',
    },
    'irmaa2bp': {
      'en': '14 March ',
      'ar': '',
    },
    'lre8t621': {
      'en': ' |  ',
      'ar': '',
    },
    '8e345hlo': {
      'en': '10:00AM',
      'ar': '',
    },
    'ml2obh0t': {
      'en': '14 March  |  10:00AM',
      'ar': '',
    },
    'lgetaud2': {
      'en': '10',
      'ar': '',
    },
    'lg1yfzqn': {
      'en': 'Spy among us',
      'ar': '',
    },
    '7jhgnvx1': {
      'en': ' | ',
      'ar': '',
    },
    'on85dsbv': {
      'en': 'Think & Win',
      'ar': '',
    },
    'q3u6lpgt': {
      'en': 'Spy among us',
      'ar': '',
    },
    'ukhj226e': {
      'en': 'Split Pay ',
      'ar': '',
    },
    'hsmso9ue': {
      'en': ' |  ',
      'ar': '',
    },
    'uvmmyoeu': {
      'en': '14 March ',
      'ar': '',
    },
    'n7rcding': {
      'en': ' |  ',
      'ar': '',
    },
    '9jwyl27h': {
      'en': '10:00AM',
      'ar': '',
    },
    'jgajtttr': {
      'en': '14 March  |  10:00AM',
      'ar': '',
    },
    '0jfbivfo': {
      'en': '10',
      'ar': '',
    },
    'k8agipu8': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // TermsofService
  {
    'gz0wii87': {
      'en': 'Terms and Conditions',
      'ar': 'حول التطبيق',
    },
    'ob7xbgvy': {
      'en': '1. Introduction and Acceptance of Terms',
      'ar': '1. مقدمة وقبول الشروط',
    },
    'urqlnwmu': {
      'en': 'Preamble',
      'ar': 'المقدمة',
    },
    '8qgothvz': {
      'en':
          'These Terms of Service (“Terms”) govern your use of the FESHAH mobile application, website, and related services (collectively, the “Service”). FESHAH is a social gaming platform developed in Kuwait, designed to provide engaging, competitive, and fun multiplayer experiences.',
      'ar':
          'تُنظّم شروط الخدمة هذه (\"الشروط\") استخدامك لتطبيق FESHAH للجوال وموقعه الإلكتروني والخدمات ذات الصلة (يُشار إليها مجتمعةً باسم \"الخدمة\"). FESHAH هي منصة ألعاب اجتماعية طُوّرت في الكويت، وصُمّمت لتوفير تجارب لعب جماعية تفاعلية وممتعة.',
    },
    '9fgoh7zr': {
      'en': 'Agreement to Terms',
      'ar': 'الموافقة على الشروط',
    },
    '5rvmp88g': {
      'en':
          'By downloading, installing, creating an account, or otherwise accessing or using the Service, you confirm that you have read, understood, and agree to be legally bound by these Terms and our Privacy Policy. If you do not agree, do not access or use the Service.',
      'ar':
          'بتنزيل الخدمة أو تثبيتها أو إنشاء حساب عليها أو الوصول إليها أو استخدامها بأي طريقة أخرى، فإنك تؤكد أنك قرأتَ وفهمتَ ووافقتَ على الالتزام القانوني بهذه الشروط وسياسة الخصوصية الخاصة بنا. في حال عدم موافقتك، فلا تدخل إلى الخدمة أو تستخدمها.',
    },
    '8dqfo8xj': {
      'en': 'Eligibility and Age Restriction',
      'ar': 'الأهلية والقيود العمرية',
    },
    'auldm6c9': {
      'en':
          '• You must be at least 13 years old to use the Service.\n• Users between 13 and the age of majority in their jurisdiction must have parental or guardian consent.\n• We do not knowingly collect personal data from children under 13. Parents who believe their child has provided data may request deletion via the contact details below.\n• These Terms apply to all users worldwide, regardless of nationality or residence.',
      'ar':
          '• يجب أن يكون عمرك ١٣ عامًا على الأقل لاستخدام الخدمة.\n• يجب على المستخدمين الذين تتراوح أعمارهم بين ١٣ عامًا وسن الرشد في ولايتهم القضائية الحصول على موافقة الوالدين أو الوصي.\n• لا نجمع بيانات شخصية من الأطفال دون سن ١٣ عامًا عمدًا. يمكن للوالدين الذين يعتقدون أن طفلهم قد قدّم بيانات طلب حذفها عبر معلومات الاتصال أدناه.\n• تُطبق هذه الشروط على جميع المستخدمين حول العالم، بغض النظر عن جنسيتهم أو مكان إقامتهم.',
    },
    '7jil4zge': {
      'en': '2. Intellectual Property Rights',
      'ar': '2. حقوق الملكية الفكرية',
    },
    'ycua1s2p': {
      'en':
          '•  Ownership: All game content—including questions, design, software, code, text, graphics, sound, music, and logos—is the exclusive property of FESHAH’s developers and protected by copyright, trademark, and other applicable laws.\n•  Limited License: You are granted a personal, non-exclusive, non-transferable, revocable license to use the Service for non-commercial entertainment.\n•  Restrictions: You may not:\n    o Reverse engineer, decompile, disassemble, or modify the Service.\n    o Create derivative works, copy, or redistribute any part of the Service.\n    o Use our trademarks, trade dress, or branding without prior written permission.\n    o Use screenshots, gameplay, or recordings of FESHAH for commercial purposes without prior approval.',
      'ar':
          'الملكية: جميع محتويات اللعبة - بما في ذلك الأسئلة والتصميم والبرمجيات والأكواد والنصوص والرسومات والصوت والموسيقى والشعارات - هي ملكية حصرية لمطوري FESHAH ومحمية بموجب حقوق النشر والعلامات التجارية والقوانين الأخرى المعمول بها.\n\n• ترخيص محدود: يُمنح لك ترخيص شخصي، غير حصري، غير قابل للتحويل، وقابل للإلغاء لاستخدام الخدمة لأغراض ترفيهية غير تجارية.\n\n• القيود: لا يجوز لك:\n\n• إجراء هندسة عكسية للخدمة، أو فك تجميعها، أو تفكيكها، أو تعديلها.\n\n• إنشاء أعمال مشتقة، أو نسخ، أو إعادة توزيع أي جزء من الخدمة.\n\n• استخدام علاماتنا التجارية، أو مظهرنا التجاري، أو هويتنا التجارية دون إذن كتابي مسبق.\n\n• استخدام لقطات الشاشة، أو مقاطع اللعب، أو تسجيلات FESHAH لأغراض تجارية دون موافقة مسبقة.',
    },
    'wf3idl9t': {
      'en': '3. Accounts and Security',
      'ar': '3. الحسابات والأمان',
    },
    '1g189igk': {
      'en':
          '• You must provide accurate, current information when registering and keep it updated.\n• You are responsible for all activity under your account and for maintaining the confidentiality of your login credentials.\n• You must notify us immediately of unauthorized access or security breaches.\n• We reserve the right to reclaim usernames that are inactive, offensive, or infringe ontrademarks.',
      'ar':
          '• يجب عليك تقديم معلومات دقيقة وحديثة عند التسجيل، وتحديثها باستمرار.\n• أنت مسؤول عن جميع الأنشطة التي تتم في حسابك، وعن الحفاظ على سرية بيانات تسجيل الدخول الخاصة بك.\n• يجب عليك إخطارنا فورًا بأي وصول غير مصرح به أو أي خروقات أمنية.\n• نحتفظ بالحق في استعادة أسماء المستخدمين غير النشطة، أو المسيئة، أو التي تنتهك العلامات التجارية.',
    },
    'ibmjwkzw': {
      'en': '4. In-App Purchases & Virtual Currency',
      'ar': '4. عمليات الشراء داخل التطبيق والعملة الافتراضية',
    },
    '0s9gskuk': {
      'en':
          '•  Coins & Virtual Items: FESHAH may offer virtual currency (“Coins”) and other virtual items, which have no real-world value and cannot be redeemed for cash.\n• Finality: All purchases are final and non-refundable except as required by law or app-store policy.\n• Account Linkage: Coins and items are tied to your account and cannot be transferred, gifted, or sold.\n• Payment Processing: All purchases are processed through Apple/Google systems; we do not store your payment card details.\n• Game Economy: We may modify, regulate, suspend, or remove virtual items, currency, or features at any time without liability.',
      'ar':
          '• العملات والعناصر الافتراضية: قد تقدم FESHAH عملات افتراضية (\"عملات\") وعناصر افتراضية أخرى، والتي ليس لها قيمة حقيقية ولا يمكن استبدالها نقدًا.\n• نهائية: جميع المشتريات نهائية وغير قابلة للاسترداد إلا وفقًا لما يقتضيه القانون أو سياسة متجر التطبيقات.\n• ربط الحساب: العملات والعناصر مرتبطة بحسابك ولا يمكن نقلها أو إهداؤها أو بيعها.\n• معالجة الدفع: تتم معالجة جميع المشتريات عبر أنظمة Apple/Google؛ ولا نخزن بيانات بطاقة الدفع الخاصة بك.\n• اقتصاد اللعبة: يحق لنا تعديل أو تنظيم أو تعليق أو إزالة العناصر أو العملات أو الميزات الافتراضية في أي وقت دون أي مسؤولية.',
    },
    'ro1otgm5': {
      'en': '5. Prohibited Conduct',
      'ar': '5. السلوك المحظور',
    },
    'dclu1n17': {
      'en':
          'You agree not to:\n•  Cheat, exploit bugs, use bots, or automate gameplay.\n•  Harass, impersonate, threaten, or abuse other users.\n•  Upload or share offensive, illegal, or infringing content.\n•  Attempt to gain unauthorized access to systems or disrupt the Service.\n•  Engage in commercial activities (advertising, selling items/accounts) without written consent.\n•  Share personal information of others without permission.\n\nViolation may result in warnings, suspension, account termination, and/or legal action.',
      'ar':
          'أنت توافق على عدم:\n• الغش، أو استغلال الأخطاء البرمجية، أو استخدام الروبوتات، أو أتمتة اللعب.\n• مضايقة المستخدمين الآخرين، أو انتحال شخصياتهم، أو تهديدهم، أو إساءة معاملتهم.\n• تحميل أو مشاركة محتوى مسيء، أو غير قانوني، أو منتهك.\n• محاولة الوصول غير المصرح به إلى الأنظمة أو تعطيل الخدمة.\n• المشاركة في أنشطة تجارية (مثل الإعلان، أو بيع المنتجات/الحسابات) دون موافقة كتابية.\n• مشاركة المعلومات الشخصية للآخرين دون إذن.\n\nقد يؤدي أي انتهاك إلى تحذيرات، أو تعليق، أو إنهاء الحساب، أو اتخاذ إجراءات قانونية.',
    },
    'iele5rti': {
      'en': '6. User-Generated Content (If Enabled)',
      'ar': '6. المحتوى الذي ينشئه المستخدم (إذا تم تمكينه)',
    },
    'nqzxc2c4': {
      'en':
          '• You retain ownership of content you submit (e.g., custom questions) but grant FESHAH a worldwide, royalty-free, transferable license to use, reproduce, modify, and display it for operation, marketing, or promotion of the Service.\n• You confirm that you own or control all rights to content you provide and that it does not infringe third-party rights.\n• We are not obligated to monitor all user content but reserve the right to review and remove content at our discretion.',
      'ar':
          'تحتفظ بملكية المحتوى الذي تُرسله (مثل الأسئلة المُخصصة)، ولكنك تمنح FESHAH ترخيصًا عالميًا، معفيًا من حقوق الملكية، وقابلًا للتحويل، لاستخدامه وإعادة إنتاجه وتعديله وعرضه لأغراض التشغيل أو التسويق أو الترويج للخدمة.\n\nتؤكد ملكيتك أو تحكمك في جميع حقوق المحتوى الذي تُرسله، وأنه لا ينتهك حقوق أي طرف ثالث.\n\nلسنا مُلزمين بمراقبة جميع محتوى المستخدم، ولكننا نحتفظ بالحق في مراجعة المحتوى وإزالته وفقًا لتقديرنا.',
    },
    'p10pcdk7': {
      'en': '7. Privacy and Data Usage',
      'ar': '7. الخصوصية واستخدام البيانات',
    },
    'i45zlncn': {
      'en': 'Data Collected',
      'ar': 'البيانات التي تم جمعها',
    },
    'j9kcjbcm': {
      'en':
          '• Personally identifiable information (e.g., name, email, user ID).\n• Device and technical data (e.g., device type, OS, IP address, cookies).\n• Gameplay and interaction data (e.g., scores, in-app purchases, progress).\n• Advertising and analytics data (e.g., ad views, clicks, demographics).',
      'ar':
          '• معلومات تعريف شخصية (مثل الاسم، والبريد الإلكتروني، ومعرف المستخدم).\n• بيانات الجهاز والبيانات التقنية (مثل نوع الجهاز، ونظام التشغيل، وعنوان IP، وملفات تعريف الارتباط).\n• بيانات اللعب والتفاعل (مثل النتائج، وعمليات الشراء داخل التطبيق، والتقدم).\n• بيانات الإعلانات والتحليلات (مثل مشاهدات الإعلانات، والنقرات، والبيانات الديموغرافية).',
    },
    '3kdcbrhq': {
      'en': 'Purpose of Collection',
      'ar': 'غرض التجميع',
    },
    'j24y9wxj': {
      'en':
          '• Provide and improve gameplay features.\n• Personalize content and recommendations.\n• Enable purchases and account management.\n• Marketing and targeted advertising (inside and outside the app).\n• Prevent fraud and ensure security.',
      'ar':
          '• توفير وتحسين ميزات اللعب.\n• تخصيص المحتوى والتوصيات.\n• تفعيل عمليات الشراء وإدارة الحسابات.\n• التسويق والإعلانات الموجهة (داخل التطبيق وخارجه).\n• منع الاحتيال وضمان الأمان.',
    },
    'cr8bo0f7': {
      'en': 'Third-Party Sharing',
      'ar': 'المشاركة مع طرف ثالث',
    },
    'ltjtrzxz': {
      'en':
          'We may share data with trusted providers (hosting, analytics, ad networks, payment processors) solely to perform services on our behalf, under contractual safeguards. We do not sell personal data to third parties.',
      'ar':
          'يجوز لنا مشاركة البيانات مع جهات موثوقة (مثل الاستضافة، والتحليلات، وشبكات الإعلانات، ومعالجات الدفع) فقط لتقديم خدمات نيابةً عنا، بموجب ضمانات تعاقدية. لا نبيع البيانات الشخصية لأطراف ثالثة.',
    },
    'heqt2ybl': {
      'en': 'Data Security & Retention',
      'ar': 'أمن البيانات والاحتفاظ بها',
    },
    'dqw2vafa': {
      'en':
          'We use reasonable security measures but cannot guarantee complete protection. Data is retained only as long as necessary for operational or legal reasons.',
      'ar':
          'نستخدم إجراءات أمنية معقولة، ولكن لا يمكننا ضمان الحماية الكاملة. نحتفظ بالبيانات فقط للمدة اللازمة لأسباب تشغيلية أو قانونية.',
    },
    'n8er330g': {
      'en': 'User Rights',
      'ar': 'حقوق المستخدم',
    },
    '1p4f80ga': {
      'en':
          'Where applicable by law, you may request access, correction, or deletion of your data. Contact details are provided below.',
      'ar':
          'يحق لك، بموجب القانون، طلب الوصول إلى بياناتك أو تصحيحها أو حذفها. تجد بيانات الاتصال أدناه.',
    },
    'm63r6hy3': {
      'en': '8. Disclaimers and Limitation of Liability',
      'ar': '8. إخلاء المسؤولية والحد منها',
    },
    'p57teb02': {
      'en':
          '• The Service is provided “as is” and “as available,” without warranties of any kind.\n• We do not guarantee that the Service will be uninterrupted, error-free, or secure.\n• To the fullest extent permitted by law, FESHAH and its affiliates are not liable for indirect, incidental, or consequential damages.\n• Some jurisdictions may not allow certain disclaimers. In such cases, our liability is limited to the extent permitted by law.',
      'ar':
          'تُقدم الخدمة \"كما هي\" و\"كما هي متاحة\"، دون أي ضمانات من أي نوع.\n\nلا نضمن أن تكون الخدمة متواصلة أو خالية من الأخطاء أو آمنة.\n\nإلى أقصى حد يسمح به القانون، لا تتحمل شركة FESHAH والشركات التابعة لها مسؤولية أي أضرار غير مباشرة أو عرضية أو تبعية.\n\nقد لا تسمح بعض الولايات القضائية ببعض إخلاءات المسؤولية. في مثل هذه الحالات، تقتصر مسؤوليتنا على الحد الذي يسمح به القانون.',
    },
    '664hhjss': {
      'en': '9. Indemnification',
      'ar': '9. التعويض',
    },
    'fjlqi64m': {
      'en':
          'You agree to indemnify and hold harmless FESHAH, its developers, officers, and partners from any claims, damages, or expenses (including attorney’s fees) arising from your misuse of the Service or violation of these Terms.',
      'ar':
          'أنت توافق على تعويض وحماية FESHAH ومطوريها ومسؤوليها وشركائها من أي مطالبات أو أضرار أو نفقات (بما في ذلك أتعاب المحاماة) الناشئة عن سوء استخدامك للخدمة أو انتهاك هذه الشروط.',
    },
    '3vc4joqk': {
      'en': '10. Suspension and Termination',
      'ar': '10. التعليق والإنهاء',
    },
    'jhc9ocov': {
      'en':
          'We may suspend or terminate accounts, remove content, and restrict access for violations of these Terms or any reason at our discretion, with or without notice. Account data may be preserved for a limited time for legal or security purposes.',
      'ar':
          'يجوز لنا تعليق أو إنهاء الحسابات، وإزالة المحتوى، وتقييد الوصول في حال انتهاك هذه الشروط أو لأي سبب آخر، وفقًا لتقديرنا، سواءً بإشعار أو بدونه. قد يتم الاحتفاظ ببيانات الحساب لفترة محدودة لأغراض قانونية أو أمنية.',
    },
    '284ui2vs': {
      'en': '11. Governing Law and Dispute Resolution',
      'ar': '11. القانون الحاكم وحل النزاعات',
    },
    'ntya8usk': {
      'en':
          '• These Terms are governed by the laws of the State of Kuwait (or another jurisdiction if specified).\n• Disputes will first be addressed through good-faith negotiation. If unresolved, disputes shall be settled by binding arbitration or through the competent courts of Kuwait, unless prohibited by law.',
      'ar':
          'تخضع هذه الشروط لقوانين دولة الكويت (أو أي سلطة قضائية أخرى إن وُجدت).\n\nتُعالج النزاعات أولًا من خلال التفاوض بحسن نية. في حال عدم التوصل إلى حل، تُسوّى النزاعات عن طريق التحكيم المُلزم أو من خلال المحاكم المختصة في الكويت، ما لم يُحظر القانون ذلك.',
    },
    '1d71y5u6': {
      'en': '12. Changes to Terms',
      'ar': '12. تغييرات على الشروط',
    },
    'ajj5dcom': {
      'en':
          'We may modify these Terms at any time. Material changes will be communicated via in-app notice or email. Continued use of the Service after changes constitutes acceptance. If you do not agree, you must stop using the Service.',
      'ar':
          'يجوز لنا تعديل هذه الشروط في أي وقت. سيتم إبلاغك بأي تغييرات جوهرية عبر إشعار داخل التطبيق أو البريد الإلكتروني. يُعدّ استمرار استخدامك للخدمة بعد التغييرات موافقةً منك. في حال عدم موافقتك، يجب عليك التوقف عن استخدام الخدمة.',
    },
    'zgpzsqtb': {
      'en': '13. Contact Information',
      'ar': '13. معلومات الاتصال',
    },
    '22opl5yt': {
      'en':
          'For questions or requests regarding these Terms or our privacy practices:\nEmail: connect@feshah.com\nAddress: Kuwait',
      'ar':
          'للاستفسارات أو الطلبات المتعلقة بهذه الشروط أو ممارسات الخصوصية لدينا:\nالبريد الإلكتروني: connect@feshah.com\nالعنوان: الكويت',
    },
    '6mw6mm7y': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // CompleteProfile
  {
    'zvg6h9xl': {
      'en': 'Email',
      'ar': 'البريد إلكتروني',
    },
    '9i9eb5mh': {
      'en': '',
      'ar': '',
    },
    '3zld6fk9': {
      'en': 'Enter your email address',
      'ar': 'أدخل عنوان بريدك الإلكتروني',
    },
    'qv2pxmbf': {
      'en': 'First Name',
      'ar': 'اسم',
    },
    '7awpz2km': {
      'en': '',
      'ar': '',
    },
    'mrfvuw4v': {
      'en': 'Enter your first name',
      'ar': 'أدخل اسمك الأول',
    },
    'afi8zmie': {
      'en': 'Date of Birth',
      'ar': 'رقم التليفون',
    },
    'lhtfidv8': {
      'en': 'Phone Number',
      'ar': 'رقم التليفون',
    },
    's8j68tkm': {
      'en': 'Kuwait',
      'ar': 'الكويت',
    },
    '3fa5m1wy': {
      'en': 'Please select...',
      'ar': '',
    },
    'x8cj3ztv': {
      'en': 'Search...',
      'ar': '',
    },
    '8j1rquoz': {
      'en': 'Enter your mobile number',
      'ar': 'أدخل رقم هاتفك المحمول',
    },
    '0zwda8a9': {
      'en': 'An OTP will be sent to Whatsapp of the entered phone number.',
      'ar': 'سيتم إرسال OTP إلى WhatsApp برقم الهاتف المدخل.',
    },
    'tipsbyvg': {
      'en': 'Gender (optional)',
      'ar': 'الجنس (اختياري)',
    },
    '3d0oe4bm': {
      'en': 'Male',
      'ar': 'ذكر',
    },
    'x5qsl77x': {
      'en': 'Female',
      'ar': 'أنثى',
    },
    'bq0jjl20': {
      'en': 'Prefer not to say',
      'ar': 'أفضل عدم القول',
    },
    'e04i1f6w': {
      'en': 'Yes, I want to receive offers & discounts',
      'ar': 'نعم أريد الحصول على العروض والخصومات',
    },
    'o1asyixc': {
      'en': 'Subscribe to newsletter',
      'ar': 'اشترك في النشرة الإخبارية',
    },
    'nl9a566h': {
      'en': 'Save',
      'ar': 'يحفظ',
    },
    'yjfdjcd4': {
      'en': 'Field is required',
      'ar': 'الحقل مطلوب',
    },
    'j2n11ei0': {
      'en': 'Pick one from the dropdown',
      'ar': 'اختَر من القائمة',
    },
    'pfulqcz4': {
      'en': 'Don\'t forget to tell us your name!',
      'ar': 'الاسم مطلوب ولا يمكن تركه فارغًا',
    },
    'sx6zdx7d': {
      'en': 'Maximum characters exceded',
      'ar': '',
    },
    'g07ktqx5': {
      'en': 'Pick one from the dropdown',
      'ar': 'اختَر من القائمة',
    },
    '4zxeqwpf': {
      'en': 'Enter your mobile number is required',
      'ar': 'أدخل رقم هاتفك المحمول مطلوب',
    },
    'ixioov2a': {
      'en': 'Pick one from the dropdown',
      'ar': 'اختَر من القائمة',
    },
    'j1egmc3g': {
      'en': 'Complete Your Profile',
      'ar': 'تعديل المعلومات الشخصية',
    },
    '2xn5ptui': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // GameFour
  {
    'jdeadgf1': {
      'en': 'Create Teams',
      'ar': 'إنشاء فرق',
    },
    'e92sxsry': {
      'en': 'Delete',
      'ar': 'يمسح',
    },
    'g1nvv0pc': {
      'en': '',
      'ar': '',
    },
    'ezgkbhjg': {
      'en': '',
      'ar': '',
    },
    'b0jvmm3u': {
      'en': 'Team A Name is required.',
      'ar': 'اسم الفريق أ مطلوب.',
    },
    'in83gz0y': {
      'en': 'Requires atleast 2 characters',
      'ar': 'يتطلب حرفين على الأقل',
    },
    'mpdjibce': {
      'en': 'Maximum 20 characters are allowed',
      'ar': 'الحد الأقصى المسموح به هو 20 حرفًا',
    },
    'btk2ug7b': {
      'en': 'Please choose an option from the dropdown',
      'ar': 'اختَر من القائمة',
    },
    'k6h53mep': {
      'en': 'Team B Name is required.',
      'ar': 'اسم الفريق ب مطلوب.',
    },
    'b7c4za5q': {
      'en': 'Requires atleast 2 characters',
      'ar': 'يتطلب حرفين على الأقل',
    },
    'u4lrmn54': {
      'en': 'Maximum 20 characters are allowed',
      'ar': 'الحد الأقصى المسموح به هو 20 حرفًا',
    },
    'vn9dbcru': {
      'en': 'Please choose an option from the dropdown',
      'ar': 'اختَر من القائمة',
    },
    'wn0s224h': {
      'en': 'Start Game',
      'ar': 'ابدأ اللعبة',
    },
    'etazct7l': {
      'en': 'Pick a style',
      'ar': 'اختر أسلوبًا',
    },
    'v1e3ej0l': {
      'en': 'Questions',
      'ar': 'أسئلة',
    },
    'vfmn8xda': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // GameFour-S1
  {
    '8e4mo9yc': {
      'en': 'Questions',
      'ar': 'أسئلة',
    },
    'bn0m2gi8': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // GameFour-S3
  {
    'ihgm7ege': {
      'en': 'Team ',
      'ar': '',
    },
    'q6905pv3': {
      'en': ' won the game',
      'ar': 'فاز باللعبة',
    },
    '9wovgwx6': {
      'en': 'What year was Kuwait\'s independence from Britain?',
      'ar': '',
    },
    '1ymb6w0k': {
      'en': 'A',
      'ar': 'أ',
    },
    'du4repkp': {
      'en': 'Score',
      'ar': 'نتيجة',
    },
    'zuz4z9y3': {
      'en': '|',
      'ar': 'مقابل',
    },
    'lxg40nqj': {
      'en': 'B',
      'ar': 'ب',
    },
    'ayyks36j': {
      'en': 'Score',
      'ar': 'نتيجة',
    },
    'su499dh7': {
      'en': '|',
      'ar': 'مقابل',
    },
    '58iak7xv': {
      'en': 'C',
      'ar': 'ج',
    },
    '2is697gb': {
      'en': 'Score',
      'ar': 'نتيجة',
    },
    '0rrvc6ra': {
      'en': 'Share Result',
      'ar': 'مشاركة النتيجة',
    },
    'c754wtri': {
      'en': 'Next Game',
      'ar': 'المباراة القادمة',
    },
    'sdpqdaq8': {
      'en': 'Team ',
      'ar': '',
    },
    '236dnqkv': {
      'en': ' won the game',
      'ar': 'فاز باللعبة',
    },
    '1jw6qblg': {
      'en': 'What year was Kuwait\'s independence from Britain?',
      'ar': '',
    },
    'tq5oe74f': {
      'en': 'A',
      'ar': 'أ',
    },
    'brlmb6wd': {
      'en': 'Score',
      'ar': 'نتيجة',
    },
    'cnzjs55g': {
      'en': '|',
      'ar': 'مقابل',
    },
    '1pidlwyb': {
      'en': 'B',
      'ar': 'ب',
    },
    'fxzzmcuc': {
      'en': 'Score',
      'ar': 'نتيجة',
    },
    'mspm5bfm': {
      'en': '|',
      'ar': 'مقابل',
    },
    'vwqtljoy': {
      'en': 'C',
      'ar': 'ج',
    },
    'w50l0r32': {
      'en': 'Score',
      'ar': 'نتيجة',
    },
    '7gv0se9e': {
      'en': 'A',
      'ar': 'أ',
    },
    'hl1wa96m': {
      'en': 'Score',
      'ar': 'نتيجة',
    },
    '7opv6kbs': {
      'en': 'VS',
      'ar': 'ضد',
    },
    'c0htuba7': {
      'en': 'B',
      'ar': 'ب',
    },
    'yusuiq5x': {
      'en': 'Score',
      'ar': 'نتيجة',
    },
    '5faz53zr': {
      'en': 'VS',
      'ar': 'ضد',
    },
    'uzoknigt': {
      'en': 'C',
      'ar': 'ج',
    },
    'yb99gevn': {
      'en': 'Score',
      'ar': 'نتيجة',
    },
    'hg4p0pqz': {
      'en': 'Even after the tie breaker, we still have no winner!',
      'ar': 'حتى بعد التعادل، لا يزال ليس لدينا فائز!',
    },
    '0txzr9kw': {
      'en': 'Play Tie Breaker',
      'ar': 'لعب كسر التعادل',
    },
    '5ek4gzlr': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // GameFour-S2
  {
    'k2j3vqdo': {
      'en': 'View Answer',
      'ar': 'شاهد الإجابة',
    },
    '8126de2i': {
      'en': 'Questions',
      'ar': 'أسئلة',
    },
    'wh3be2vg': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // AboutApp
  {
    'gjsjgj7a': {
      'en': 'About App',
      'ar': 'حول التطبيق',
    },
    'tsduz17t': {
      'en': 'Feshah – All your party games in one place 🎮',
      'ar': 'فيشة – كل ألعاب الجَمعات في مكان واحد 🎮',
    },
    'daqi8ozr': {
      'en':
          'Experience the challenge and laughter with a collection of party games designed for parties and outings!\nFrom questions and guessing to acting and speed, each game has its own unique atmosphere and challenge.\n\nEverything is in one app, from your phone or TV, and the ease of play lets the excitement begin immediately! ✨',
      'ar':
          'عيش أجواء التحدي والضحك مع مجموعة ألعاب جماعية مصمّمة للجمعات والطلعات!\nمن الأسئلة والتخمين إلى التمثيل والسرعة، كل لعبة لها جوّها الخاص وتحدّيها المختلف.\n\nكل شي في تطبيق واحد، من تليفونك أو على التلفزيون، وسهولة اللعب تخلي الحماس يبدأ فورًا! ✨',
    },
    '108x0uw7': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // GameOneCopy
  {
    '9qlmwt1t': {
      'en': 'Create Teams',
      'ar': 'إنشاء فرق',
    },
    'p3ngenkw': {
      'en': '1',
      'ar': '1',
    },
    'mwpok757': {
      'en': '2',
      'ar': '2',
    },
    '1qphk54k': {
      'en': '3',
      'ar': '3',
    },
    'xydp2fi3': {
      'en': '2',
      'ar': '2',
    },
    '5l4lverp': {
      'en': 'Delete',
      'ar': 'يمسح',
    },
    '1hpvdt63': {
      'en': 'Next',
      'ar': 'البدء',
    },
    'xyadhkfp': {
      'en':
          'Players can play as one team against computer. if you give right answer you will get point or if its wrong the computer will get the point.',
      'ar':
          'يمكن للاعبين اللعب كفريق واحد ضد الكمبيوتر. إذا قدمت الإجابة الصحيحة فستحصل على نقطة وإذا كانت الإجابة خاطئة فسيحصل الكمبيوتر على نقطة.',
    },
    'puuwwqoc': {
      'en': 'Choose Topic',
      'ar': 'اختر الموضوع',
    },
    '7bi25ttd': {
      'en': 'Choose ',
      'ar': 'يختار',
    },
    '2t98int0': {
      'en': ' Topics to start the game',
      'ar': 'مواضيع لبدء اللعبة',
    },
    'jp0g7mp3': {
      'en': 'Random',
      'ar': 'عشوائيا',
    },
    '8pp40n36': {
      'en': 'remaining',
      'ar': 'متبقي',
    },
    'vlrjwjug': {
      'en': '3 Topics',
      'ar': '3 Topics',
    },
    'weaxqgxp': {
      'en': '6 Topics',
      'ar': '6 Topics',
    },
    'ycnro8r3': {
      'en': '3 Topics',
      'ar': '3 Topics',
    },
    'na7wv1xz': {
      'en': 'Start the game',
      'ar': 'ابدأ اللعبة',
    },
    's33aoh1r': {
      'en': 'Available teams',
      'ar': '',
    },
    'ia8627up': {
      'en': '',
      'ar': 'اسم',
    },
    'jyhif53w': {
      'en': 'Team ‘B’ name here...',
      'ar': '',
    },
    'zzw1w8rz': {
      'en': 'Save',
      'ar': '',
    },
    'dqo6443w': {
      'en': 'Start the game',
      'ar': 'البدء',
    },
    'brhaoc2g': {
      'en': 'Players Info',
      'ar': 'اللاعبين',
    },
    'ux7g7kgr': {
      'en': 'Joined',
      'ar': 'انضم',
    },
    'iipg6pww': {
      'en': 'Invite players',
      'ar': 'دعوة اللاعبين',
    },
    'sktboya0': {
      'en': 'Active',
      'ar': 'نشط حالياً',
    },
    'getc8whw': {
      'en': 'Viewer',
      'ar': 'مشاهد',
    },
    'x6ubljwy': {
      'en': 'Topics',
      'ar': 'خلف',
    },
    '4bkbehij': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // GameFour-S1Copy
  {
    'spzpv1mu': {
      'en': 'Questions',
      'ar': 'أسئلة',
    },
    'fwobnsa9': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // GameFive
  {
    'lfu46ktw': {
      'en': 'Add players in space',
      'ar': 'أضف لاعبين في المساحة',
    },
    '8x1fnz04': {
      'en': ' People Available',
      'ar': 'الأشخاص المتاحون',
    },
    'jgsur45n': {
      'en': 'Invite players',
      'ar': 'دعوة اللاعبين',
    },
    'grk3mrdj': {
      'en': 'Manual player',
      'ar': 'مشغلات يدوية',
    },
    'q0x13ub6': {
      'en': 'Team A Name is required.',
      'ar': 'اسم الفريق أ مطلوب.',
    },
    'r4djnd2n': {
      'en': 'Requires atleast 2 characters',
      'ar': 'يتطلب حرفين على الأقل',
    },
    'fma0mmor': {
      'en': 'Maximum 20 characters are allowed',
      'ar': 'الحد الأقصى المسموح به هو 20 حرفًا',
    },
    '2zhvtiec': {
      'en': 'Please choose an option from the dropdown',
      'ar': 'اختَر من القائمة',
    },
    'sjfmw1vd': {
      'en': 'Team B Name is required.',
      'ar': 'اسم الفريق ب مطلوب.',
    },
    'cbh3bi33': {
      'en': 'Requires atleast 2 characters',
      'ar': 'يتطلب حرفين على الأقل',
    },
    'h1xhaics': {
      'en': 'Maximum 20 characters are allowed',
      'ar': 'الحد الأقصى المسموح به هو 20 حرفًا',
    },
    '9a2y2fu3': {
      'en': 'Please choose an option from the dropdown',
      'ar': 'اختَر من القائمة',
    },
    'mucv66vx': {
      'en':
          'Need 2 - 10 players to play this game if the player is not in room you can add manually by entering the name to add',
      'ar':
          'تحتاج هذه اللعبة إلى ما بين 2 إلى 10 لاعبين. إذا لم يكن اللاعب موجودًا في الغرفة، يمكنك إضافته يدويًا بإدخال اسمه.',
    },
    'uc1qg55i': {
      'en':
          'Need 2 - 10 players to play this game if the player is not in room you can add manually by entering the name to add',
      'ar':
          'تحتاج هذه اللعبة إلى ما بين 2 إلى 10 لاعبين. إذا لم يكن اللاعب موجودًا في الغرفة، يمكنك إضافته يدويًا بإدخال اسمه.',
    },
    'cgs9ve9c': {
      'en': 'Invite players',
      'ar': 'دعوة اللاعبين',
    },
    'dn8o807j': {
      'en': 'Share the invite link or scan the QR to join this game ',
      'ar':
          'شارك رابط الدعوة أو امسح رمز الاستجابة السريعة للانضمام إلى هذه اللعبة',
    },
    'dnjwtq8h': {
      'en': 'Add players in space',
      'ar': 'أضف لاعبين في المساحة',
    },
    'l3yxw3kn': {
      'en': ' Players',
      'ar': 'اللاعبون',
    },
    'u0exs1q9': {
      'en': 'Invite players',
      'ar': 'دعوة اللاعبين',
    },
    'gjs356kt': {
      'en': 'Players Info',
      'ar': 'معلومات اللاعبين',
    },
    '8a9slwsa': {
      'en': 'Who is the suspect?',
      'ar': 'اللاعبين',
    },
    'j6pshwpi': {
      'en': 'Start the game',
      'ar': 'ابدأ اللعبة',
    },
    'zjnlfaib': {
      'en': 'Round',
      'ar': 'دائري',
    },
    'jwhofi8j': {
      'en': 'Category  ',
      'ar': 'فئة  ',
    },
    '1spcbxya': {
      'en': 'For',
      'ar': 'ل',
    },
    'lby46oej': {
      'en': 'Score',
      'ar': 'نتيجة',
    },
    'qszo9mt2': {
      'en': 'is the winner now! with ',
      'ar': 'هو الفائز الآن! ',
    },
    'usgswag3': {
      'en': ' points',
      'ar': ' نقاط',
    },
    'ilnq96ti': {
      'en': 'What year was Kuwait\'s independence from Britain?',
      'ar': '',
    },
    'w394j0z1': {
      'en': 'Share Result',
      'ar': 'مشاركة النتيجة',
    },
    '9f5tyrl2': {
      'en': 'Scores',
      'ar': 'النتائج',
    },
    'y2t0cpqj': {
      'en': 'Who is the suspect?',
      'ar': 'اللاعبين',
    },
    'uxarr5on': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // GameSix
  {
    'ate0e3dq': {
      'en': 'Add players in space',
      'ar': 'أضف لاعبين في المساحة',
    },
    'kdt55syz': {
      'en': ' People Available',
      'ar': 'الأشخاص المتاحون',
    },
    '0nm7ab5o': {
      'en': 'Invite players',
      'ar': 'دعوة اللاعبين',
    },
    'qcpztst3': {
      'en': 'Game Settings',
      'ar': 'مشغلات يدوية',
    },
    '04eh89ye': {
      'en': '3–10 players required to start',
      'ar': 'تمت إضافة 3 لاعبين',
    },
    'nonwekqj': {
      'en': 'Round Time',
      'ar': 'تمت إضافة 3 لاعبين',
    },
    'u6mftwjm': {
      'en': 'Total Rounds',
      'ar': 'تمت إضافة 3 لاعبين',
    },
    'x1uehjgq': {
      'en': 'Power-Ups',
      'ar': 'تمت إضافة 3 لاعبين',
    },
    'w64fnlef': {
      'en': 'Start the game',
      'ar': 'ابدأ اللعبة',
    },
    'njqitkmr': {
      'en': 'Invite players',
      'ar': 'دعوة اللاعبين',
    },
    'trudhbxv': {
      'en': 'Share the invite link or scan the QR to join this game ',
      'ar':
          'شارك رابط الدعوة أو امسح رمز الاستجابة السريعة للانضمام إلى هذه اللعبة',
    },
    'gn48qu5g': {
      'en': 'Add players in space',
      'ar': 'أضف لاعبين في المساحة',
    },
    'j2imwxdj': {
      'en': ' Players',
      'ar': 'اللاعبون',
    },
    'v328544s': {
      'en': 'Invite players',
      'ar': 'دعوة اللاعبين',
    },
    'xi4atqit': {
      'en': 'Players Info',
      'ar': 'معلومات اللاعبين',
    },
    'yebwmfjc': {
      'en': 'Who is the suspect?',
      'ar': 'اللاعبين',
    },
    'n7ovbpze': {
      'en': '',
      'ar': '',
    },
    'phiobbr7': {
      'en': 'is the winner now! with ',
      'ar': 'هو الفائز الآن! ',
    },
    'eamacrdp': {
      'en': ' points',
      'ar': ' نقاط',
    },
    'n03n851c': {
      'en': 'What year was Kuwait\'s independence from Britain?',
      'ar': '',
    },
    '5w7rqq0r': {
      'en': 'Share Result',
      'ar': 'مشاركة النتيجة',
    },
    'mxsmueyh': {
      'en': 'Scores',
      'ar': 'النتائج',
    },
    'i7g2tdky': {
      'en': 'Who is the suspect?',
      'ar': 'اللاعبين',
    },
    'qeg1jpud': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // home_roomjoin
  {
    '04hkkxmf': {
      'en': 'Join Room',
      'ar': 'انضم إلى الغرفة',
    },
    'r7kgx365': {
      'en': 'You can join your leader room by entering the room id',
      'ar':
          'يمكنك الانضمام إلى غرفة القائد الخاصة بك عن طريق إدخال معرف الغرفة',
    },
    'fjw6ffr5': {
      'en': 'Join Now',
      'ar': 'انضم الان',
    },
    'uujnc8k1': {
      'en': 'Field is required',
      'ar': 'الحقل مطلوب',
    },
  },
  // AppBar-Room
  {
    '7y52pz6m': {
      'en': 'Exit Room',
      'ar': 'غرفة الخروج',
    },
  },
  // ForgotPassword
  {
    '34l9jwto': {
      'en': 'Password Reset',
      'ar': 'إعادة تعيين كلمة المرور',
    },
    'ueeeq6tf': {
      'en':
          'Enter the email linked to your account, and we’ll send you a password reset link.',
      'ar':
          'أدخل البريد الإلكتروني المرتبط بحسابك، وسنرسل إليك رابط إعادة تعيين كلمة المرور.',
    },
    '46jgflng': {
      'en': 'Email',
      'ar': 'الإيميل',
    },
    'ufg4x4fc': {
      'en': '',
      'ar': '',
    },
    'gxt6tcfu': {
      'en': 'Email',
      'ar': 'الإيميل',
    },
    '2s0yozaa': {
      'en': 'Please enter a valid email address.',
      'ar': 'يرجى إدخال عنوان بريد إلكتروني صالح.',
    },
    '7yax0ahh': {
      'en': 'Pick one from the dropdown',
      'ar': 'اختَر من القائمة',
    },
    'viokls2h': {
      'en': 'Send',
      'ar': 'يرسل',
    },
  },
  // Social
  {
    'e7rike0j': {
      'en': 'Google',
      'ar': 'جوجل',
    },
    'u5bi46yl': {
      'en': 'Apple',
      'ar': 'أبل',
    },
  },
  // SideBar
  {
    'yra39lrl': {
      'en': 'Earn your first badge by spending 100 coins',
      'ar': 'احصل على شارتك الأولى عن طريق إنفاق 100 قطعة نقدية',
    },
    'vel40kf6': {
      'en': 'Account',
      'ar': 'حساب',
    },
    'ulh4oojz': {
      'en': 'Your profile',
      'ar': 'معلوماتك الشخصيه',
    },
    '3i3q5uie': {
      'en': '',
      'ar': '',
    },
    '6bowqaix': {
      'en': 'Account Stats',
      'ar': 'إحصائيات الحساب',
    },
    'snjpdeg4': {
      'en': '',
      'ar': '',
    },
    'f3bdajmi': {
      'en': 'Badges',
      'ar': '',
    },
    'nm8me7q1': {
      'en': '',
      'ar': '',
    },
    '2wwit842': {
      'en': 'Account',
      'ar': 'حساب',
    },
    'ep7ni5nr': {
      'en': 'Personal Info',
      'ar': 'المعلومات الشخصية',
    },
    '6zllpf8d': {
      'en': '',
      'ar': '',
    },
    'vowotvf5': {
      'en': 'Account Stats',
      'ar': 'إحصائيات الحساب',
    },
    '3lqp5o1k': {
      'en': '',
      'ar': '',
    },
    'masvkbp7': {
      'en': 'Badges',
      'ar': '',
    },
    '11erpez9': {
      'en': '',
      'ar': '',
    },
    'ypz9519e': {
      'en': 'Account',
      'ar': '',
    },
    '9mjnta5x': {
      'en': '',
      'ar': '',
    },
    'ey98xjgj': {
      'en': 'Transactions',
      'ar': 'محفظة',
    },
    'v5sloqls': {
      'en': '',
      'ar': '',
    },
    'd3zltrub': {
      'en': 'Settings',
      'ar': '',
    },
    'a9lij9p9': {
      'en': '',
      'ar': '',
    },
    'pkcw4axh': {
      'en': 'Logout',
      'ar': 'تسجيل الخروج',
    },
    's7j2j8u5': {
      'en': '',
      'ar': '',
    },
  },
  // Navbar
  {
    'ibn23fig': {
      'en': 'Home',
      'ar': '',
    },
  },
  // GameGrid
  {
    'vxrw3hlx': {
      'en': 'How to play',
      'ar': 'كيفية اللعب',
    },
    '88ia49c0': {
      'en': 'Start  >',
      'ar': 'يبدأ  >',
    },
  },
  // home_widget2
  {
    '3z6e1j3y': {
      'en': 'Please choose an option',
      'ar': 'الرجاء الاختيار..',
    },
    'r5ooxb93': {
      'en': 'Your Rooms',
      'ar': 'غرفك',
    },
    'tahj3bkw': {
      'en': 'View all',
      'ar': '',
    },
    '7yfqdoiu': {
      'en': 'Field is required',
      'ar': 'الحقل مطلوب',
    },
    'jg671w80': {
      'en': 'Create a Room',
      'ar': 'إنشاء غرفة',
    },
    'tiz10epu': {
      'en': 'create',
      'ar': 'create',
    },
    '1pl3j0ge': {
      'en': 'Join a Room',
      'ar': 'انضم إلى غرفة',
    },
    'uc18yjz4': {
      'en': 'join',
      'ar': 'join',
    },
  },
  // empty_widget_room
  {
    'pit1x6gq': {
      'en': 'No one joined the room yet',
      'ar': 'لم ينضم أحد إلى الغرفة بعد',
    },
    '8hjamshv': {
      'en':
          'Try sharing your space ID to the user you want to join the space or try sharing in social media.',
      'ar':
          'حاول مشاركة معرف المساحة الخاص بك مع المستخدم الذي تريد الانضمام إلى المساحة أو حاول المشاركة على وسائل التواصل الاجتماعي.',
    },
    'fhhte50k': {
      'en': 'Refresh',
      'ar': '',
    },
  },
  // notfy_room_request_accept
  {
    'w5qm450j': {
      'en': 'Congratulations now you are a member of \n',
      'ar': 'مبروك الآن أصبحت عضوًا',
    },
    'n61ff2ej': {
      'en': 'Your request has been accepted',
      'ar': 'لدى المشرف فقط السيطرة الكاملة على المساحة.',
    },
  },
  // AppBar-Game
  {
    'wr50ze25': {
      'en': 'Back',
      'ar': 'خلف',
    },
    '298i7q6b': {
      'en': 'Back',
      'ar': 'خلف',
    },
    'p8b5o3y1': {
      'en': 'Back',
      'ar': 'خلف',
    },
    '8bvqvhib': {
      'en': 'Back',
      'ar': 'خلف',
    },
    'z33lbpp4': {
      'en': 'Back',
      'ar': 'خلف',
    },
    '9srytt6t': {
      'en': '\'s',
      'ar': '\'s',
    },
    'iruzyday': {
      'en': ' turn',
      'ar': 'دور',
    },
    'uodcig6l': {
      'en': 'Exit Game',
      'ar': 'الخروج',
    },
  },
  // GameTeam-User
  {
    'dtbnq1a0': {
      'en': 'Score',
      'ar': 'نتيجة',
    },
    '58cn4lxp': {
      'en': 'Call',
      'ar': 'يتصل',
    },
    '9wzpdl4v': {
      'en': 'Double',
      'ar': 'مزدوج',
    },
    'eja4lspy': {
      'en': 'Swap',
      'ar': 'تبديل',
    },
  },
  // GameTeam-Computer
  {
    'xblv68be': {
      'en': 'B',
      'ar': '',
    },
    'r5p5ztkg': {
      'en': 'Team B',
      'ar': '',
    },
    'nmrrcusb': {
      'en': 'Champions',
      'ar': '',
    },
    '96w4osqf': {
      'en': 'Score',
      'ar': '',
    },
    'yl8xvo0r': {
      'en': '1800',
      'ar': '',
    },
  },
  // GameExit
  {
    'xlaqjnq2': {
      'en': 'Are you sure?',
      'ar': 'هل أنت متأكد؟',
    },
    'ym79ln7r': {
      'en': 'are you sure you want to cancel the game?',
      'ar': 'هل أنت متأكد أنك تريد إلغاء اللعبة؟',
    },
    '4ikmqcw5': {
      'en': 'Yes',
      'ar': 'نعم',
    },
    '4lee7d2n': {
      'en': 'No',
      'ar': 'لا',
    },
  },
  // notfy_game_request
  {
    'dunk7f7e': {
      'en': ' has invited to',
      'ar': 'وقد دعا إلى',
    },
    'ncwmc49a': {
      'en': 'Accept',
      'ar': 'يقبل',
    },
    'kh89uzcm': {
      'en': 'Decline',
      'ar': 'انضم إلى غرفة',
    },
  },
  // App_Updater_Popup_Android
  {
    'ju8gzxmv': {
      'en': 'Update Required!',
      'ar': 'التحديث مطلوب!',
    },
    '0hs5bvk9': {
      'en': 'Feshah',
      'ar': '',
    },
    'k2pudqja': {
      'en':
          'We have launched a new and improved app. Please update to continue shopping.',
      'ar':
          'لقد أطلقنا تطبيقًا جديدًا ومُحسّنًا. يُرجى التحديث لمواصلة التسوق.',
    },
    'h2fx74iz': {
      'en': 'Release Notes',
      'ar': 'ملاحظات الإصدار',
    },
    '8a1wpy1g': {
      'en': 'Update',
      'ar': 'تحديث',
    },
  },
  // App_Updater_Popup_IOS
  {
    'fb1oua55': {
      'en': 'Update Required!',
      'ar': 'التحديث مطلوب!',
    },
    '60zazqzb': {
      'en': 'Feshah',
      'ar': '',
    },
    'a4rxxo82': {
      'en':
          'We have launched a new and improved app. Please update to continue shopping.',
      'ar':
          'لقد أطلقنا تطبيقًا جديدًا ومُحسّنًا. يُرجى التحديث لمواصلة التسوق.',
    },
    'fxq1veu6': {
      'en': 'Release Notes',
      'ar': 'ملاحظات الإصدار',
    },
    'kcizrlso': {
      'en': 'Install Now',
      'ar': 'التثبيت الآن',
    },
  },
  // PointList-PrivateWallet
  {
    '0otnulfu': {
      'en': 'Balance: ',
      'ar': 'توازن:',
    },
    '00i9651g': {
      'en': ' Coins',
      'ar': 'عملات معدنية',
    },
    't1slb9f5': {
      'en': 'Balance: 45 Coins',
      'ar':
          'يمكنك الانضمام إلى غرفة القائد الخاصة بك عن طريق إدخال معرف الغرفة',
    },
    'xfjiq1zy': {
      'en': 'COINS',
      'ar': 'عملات معدنية',
    },
    'irnw52ri': {
      'en': 'Make payment',
      'ar': 'إنشاء غرفة',
    },
    'rn7zw8vv': {
      'en': 'Direct pay',
      'ar': 'الدفع المباشر',
    },
    'jk915l9c': {
      'en': 'There are no payment methods detected.',
      'ar': 'خادم دفع TAP مشغول. يُرجى المحاولة مرة أخرى.',
    },
    '52mvtgq1': {
      'en': 'Split pay',
      'ar': 'انضم إلى غرفة',
    },
    '8s4zkbk2': {
      'en': 'Your Wallet Balance',
      'ar': 'رصيد محفظتك',
    },
    '8wyk7kv0': {
      'en': 'Transfer To Room Wallet',
      'ar': 'نقل إلى محفظة الغرفة',
    },
    'fszxgmwv': {
      'en': '',
      'ar': '',
    },
    'k5fg5ww7': {
      'en': 'Enter value',
      'ar': 'أدخل القيمة',
    },
    'g446ciav': {
      'en': 'Transfer',
      'ar': 'تحويل',
    },
    'iyno7awt': {
      'en': 'How do you pay',
      'ar': '',
    },
    'bm3lc40g': {
      'en': 'Pay with K-Net',
      'ar': 'ادفع باستخدام K-Net',
    },
    'h28qy0m4': {
      'en': 'Pay with Card',
      'ar': 'الدفع بالبطاقة',
    },
    '71prieuz': {
      'en': 'Pay with G-Pay',
      'ar': '',
    },
    '1mzzwdv3': {
      'en': 'Pay with Apple Pay',
      'ar': '',
    },
    'u6yi98qd': {
      'en': 'Proceed to Pay',
      'ar': 'انتقل إلى الدفع',
    },
  },
  // WalletRecharge
  {
    '8pc99dbu': {
      'en': 'Recharge wallet',
      'ar': 'انضم إلى الغرفة',
    },
    'fa7mnkjy': {
      'en': 'Balance: ',
      'ar': '',
    },
    'c2j4bps0': {
      'en': ' Coins',
      'ar': '',
    },
    'n47le40x': {
      'en': 'Balance: 45 Coins',
      'ar':
          'يمكنك الانضمام إلى غرفة القائد الخاصة بك عن طريق إدخال معرف الغرفة',
    },
    'nsw5rwhx': {
      'en': '25 Coins',
      'ar': '',
    },
    '8tfjcvks': {
      'en': '10 KD',
      'ar': '',
    },
    'rso67y5b': {
      'en': '25 Coins',
      'ar': '',
    },
    'qnnigdr7': {
      'en': '10 KD',
      'ar': '',
    },
    'ybdbvih4': {
      'en': '',
      'ar': '',
    },
    '4xt0vogi': {
      'en': 'Enter discount code...',
      'ar': '',
    },
    'ajfo97vu': {
      'en': 'Apply',
      'ar': '',
    },
    'ivzrs289': {
      'en': 'Select payment method',
      'ar': '',
    },
    'xkqg5nfi': {
      'en': 'Option 1',
      'ar': '',
    },
    '1tafd5ne': {
      'en': 'Option 1',
      'ar': '',
    },
    '1zigqwki': {
      'en': 'Search...',
      'ar': '',
    },
    'krzyygqd': {
      'en': 'Option 1',
      'ar': '',
    },
    '77sdm1pt': {
      'en': 'Option 2',
      'ar': '',
    },
    '97iprd5d': {
      'en': 'Option 3',
      'ar': '',
    },
    'ys8yb6qa': {
      'en': 'Make payment',
      'ar': 'إنشاء غرفة',
    },
    'sj4gosqi': {
      'en': 'Direct pay',
      'ar': 'إنشاء غرفة',
    },
    'kozbrv7u': {
      'en': 'Split pay',
      'ar': 'انضم إلى غرفة',
    },
  },
  // empty_widget_game
  {
    '19dzyyic': {
      'en': 'No games available yet, Please wait a moment',
      'ar': 'لا توجد ألعاب متاحة بعد. يُرجى الانتظار قليلاً.',
    },
    'j1fwa143': {
      'en': 'We’re updating your game list - this won’t take long.',
      'ar':
          'نقوم بتحديث قائمة الألعاب الخاصة بك - وهذا لن يستغرق وقتًا طويلاً.',
    },
    'qm9bkbzn': {
      'en': 'Refresh',
      'ar': '',
    },
  },
  // home_roomlist
  {
    '2ysvxkxx': {
      'en': 'View',
      'ar': '',
    },
  },
  // GameOne_User
  {
    'd8onspya': {
      'en': 'You',
      'ar': 'أنت',
    },
    'dc9a0sgv': {
      'en': 'Invite',
      'ar': 'يدعو',
    },
    'prop9l9n': {
      'en': 'Invite',
      'ar': 'مشاهد',
    },
    '2o0fuuru': {
      'en': 'Game Invite',
      'ar': 'دعوة للعبة',
    },
    '71dfqcgx': {
      'en': '+ Invite',
      'ar': '+ دعوة',
    },
    'dfekx10q': {
      'en': 'Invite',
      'ar': 'يدعو',
    },
    'smtb5iel': {
      'en': '+ Invite',
      'ar': '+ دعوة',
    },
  },
  // user_request_widget
  {
    'b0qk5rpl': {
      'en': 'Accept',
      'ar': 'يقبل',
    },
    '2m69jflt': {
      'en': 'Decline',
      'ar': 'رفض',
    },
  },
  // user_new_widget
  {
    'gnztyxnr': {
      'en': '+ Add',
      'ar': '+ أضف',
    },
  },
  // empty_widget_transaction
  {
    'h820a8q3': {
      'en': 'No transactions found. Start by making your first one!',
      'ar': 'لم يتم العثور على أي معاملات. ابدأ بإجراء أول معاملة لك!',
    },
    'z8fic294': {
      'en':
          'Start using the FESHAH, and your transaction history will show up here.',
      'ar': 'ابدأ باستخدام فيشة، وسيظهر سجل معاملاتك هنا.',
    },
    '0ffpcrdv': {
      'en': 'Refresh',
      'ar': '',
    },
  },
  // notfy_room_request_notification
  {
    '62u3o69i': {
      'en': 'You have asked to join',
      'ar': 'لقد طلبت الانضمام',
    },
    '4w4ff3wz': {
      'en': 'Your request has been accepted',
      'ar': 'لقد تم قبول طلبك',
    },
    'kyok0a46': {
      'en': 'Accept',
      'ar': 'يقبل',
    },
    'zei7s4ky': {
      'en': 'Decline',
      'ar': 'انخفاض',
    },
  },
  // notfy_room_request_joinroom
  {
    'yj9kj4im': {
      'en': 'You have requested to join  ',
      'ar': ' لقد طلبت الانضمام ',
    },
    'k4t6ryhd': {
      'en': 'Only admin can accept the request',
      'ar': 'يمكن للمسؤول فقط قبول الطلب',
    },
  },
  // empty_widget_notification
  {
    '1z3oh3p3': {
      'en': 'You currently have no notifications',
      'ar': 'ليس لديك أي إشعارات حاليًا',
    },
    'j704kgyg': {
      'en': 'Your notifications will show up here once there’s activity.',
      'ar': 'ستظهر إشعاراتك هنا بمجرد حدوث أي نشاط.',
    },
    '1t9sy6kd': {
      'en': 'Refresh',
      'ar': '',
    },
  },
  // GameOne_Timer
  {
    'rdb2ex0p': {
      'en': 'Sec',
      'ar': '',
    },
  },
  // Alert_Information
  {
    'philyi1d': {
      'en': 'Okay',
      'ar': 'تمام',
    },
  },
  // Alert_Logout
  {
    'yb4bmo76': {
      'en': 'Are you sure?',
      'ar': 'هل أنت متأكد؟',
    },
    '854urwlu': {
      'en': 'are you sure you want to logout?',
      'ar': 'هل أنت متأكد أنك تريد تسجيل الخروج؟',
    },
    'osnyfht1': {
      'en': 'Yes',
      'ar': 'نعم',
    },
    'e9empqoa': {
      'en': 'No',
      'ar': 'لا',
    },
  },
  // Alert_Confirmation
  {
    'ob7uvj6t': {
      'en': 'Yes',
      'ar': 'نعم',
    },
    'sg9kt8qs': {
      'en': 'No',
      'ar': 'لا',
    },
  },
  // coming_soon
  {
    '0g6r6v53': {
      'en': 'New Games Coming Soon!',
      'ar': 'ألعاب جديدة قادمة قريبا!',
    },
    'vkxg4fio': {
      'en':
          'Stay tuned and check back regularly — the fun is just getting started!',
      'ar': 'تابعونا وتابعونا بانتظام - فالمتعة بدأت للتو!',
    },
  },
  // GameZone_Team
  {
    'a006tfdj': {
      'en': '',
      'ar': '',
    },
    'dlsdmnjf': {
      'en': 'Save',
      'ar': 'يحفظ',
    },
    'v11tc98z': {
      'en': 'Team Name is required.',
      'ar': 'اسم الفريق مطلوب.',
    },
    'hz3wwul7': {
      'en': 'Requires atleast 2 characters',
      'ar': 'يتطلب حرفين على الأقل',
    },
    'rp4p6uf0': {
      'en': 'Maximum 20 characters are allowed',
      'ar': 'الحد الأقصى المسموح به هو 20 حرفًا',
    },
    'u5vbpchc': {
      'en': 'Please choose an option from the dropdown',
      'ar': 'اختَر من القائمة',
    },
  },
  // GameOne-Toss
  {
    'w44rxnym': {
      'en': 'Click the button to flip the coin and decide whose turn it is.',
      'ar': 'انقر على الزر لقلب العملة وتحديد دور من سيأتي.',
    },
    '6db7wv8p': {
      'en': '[Team A] wins the toss!',
      'ar': 'ألعاب جديدة قادمة قريبا!',
    },
    'l0mneerr': {
      'en': 'Toss the coin',
      'ar': 'رمي العملة المعدنية',
    },
    'jagrq08a': {
      'en': ' wins the toss!',
      'ar': 'يفوز بالقرعة!',
    },
    'ku6msw86': {
      'en': '[Team A] wins the toss!',
      'ar': 'ألعاب جديدة قادمة قريبا!',
    },
    'dn3w6pqv': {
      'en': 'Continue',
      'ar': 'يكمل',
    },
  },
  // GameOne_TieStart
  {
    'gv71ubzl': {
      'en': 'Tie Breaker',
      'ar': 'كاسر التعادل',
    },
    'gbxc7ldr': {
      'en':
          'Answer 10 rapid-fire questions in 60 seconds. Get +100 for each correct answer, -100 for each wrong. Speed and accuracy decide the winner!',
      'ar':
          'أجب عن ١٠ أسئلة سريعة في ٦٠ ثانية. احصل على +١٠٠ لكل إجابة صحيحة، و-١٠٠ لكل إجابة خاطئة. السرعة والدقة هما اللذان يحددان الفائز!',
    },
    'pxjb5ofd': {
      'en': '[Team A] wins the toss!',
      'ar': 'ألعاب جديدة قادمة قريبا!',
    },
    'a0ltk6s3': {
      'en': ' now your turn',
      'ar': 'الآن دورك',
    },
    '1zidkktp': {
      'en': '[Team A] wins the toss!',
      'ar': 'ألعاب جديدة قادمة قريبا!',
    },
    'killujuq': {
      'en': 'Start the game',
      'ar': 'ابدأ اللعبة',
    },
  },
  // GameTwo_Timer
  {
    'z3dbzp8h': {
      'en': 'Sec',
      'ar': '',
    },
  },
  // GameTwo_User
  {
    '2e50hk6r': {
      'en': 'You',
      'ar': 'أنت',
    },
    'lm72tgbf': {
      'en': 'Vote',
      'ar': 'تصويت',
    },
    'ihm3zvrc': {
      'en': 'You Voted',
      'ar': 'لقد صوتت',
    },
  },
  // empty_widget_gamehistory
  {
    'c4f0z9da': {
      'en': 'No Games Played Yet',
      'ar': 'لا توجد ألعاب متاحة بعد. يُرجى الانتظار قليلاً.',
    },
    '0331vckl': {
      'en': 'Your game history will show up here once you start playing.',
      'ar':
          'نقوم بتحديث قائمة الألعاب الخاصة بك - وهذا لن يستغرق وقتًا طويلاً.',
    },
    'smisutfm': {
      'en': 'Refresh',
      'ar': '',
    },
  },
  // home_resume
  {
    '87m5grfv': {
      'en': 'Resume Your Game?',
      'ar': 'استئناف لعبتك؟',
    },
    '7j3gs4xk': {
      'en':
          'You were in the middle of a game when you exited the app. Would you like to continue where you left off?',
      'ar':
          'كنتَ في منتصف اللعبة عندما خرجتَ من التطبيق. هل ترغب في المتابعة من حيث توقفت؟',
    },
    'ultamev2': {
      'en': 'Continue Game',
      'ar': 'متابعة اللعبة',
    },
  },
  // Room_QRscanner
  {
    'ivti1hj0': {
      'en': 'Cancel',
      'ar': '',
    },
    '0sal2b9p': {
      'en': 'Tap the QR image to scan.',
      'ar': '',
    },
  },
  // coupon
  {
    'vzsk63cz': {
      'en': '',
      'ar': '',
    },
    'zhf020mg': {
      'en': 'Enter discount code...',
      'ar': 'أدخل رمز الخصم...',
    },
    '8ikaqakj': {
      'en': '*code is required',
      'ar': '',
    },
    'mcpy6p82': {
      'en': 'Please choose an option from the dropdown',
      'ar': 'اختَر من القائمة',
    },
  },
  // Notification-popup
  {
    'dkr2e67k': {
      'en': 'Notifications',
      'ar': 'الرجاء اختيار خيار',
    },
  },
  // Sound-popup
  {
    'rc0ihdt5': {
      'en': 'Sound',
      'ar': 'الرجاء اختيار خيار',
    },
  },
  // Language-popup
  {
    '8enseq5l': {
      'en': 'Language',
      'ar': 'الرجاء اختيار خيار',
    },
    'vnv3zycc': {
      'en': 'Select...',
      'ar': '',
    },
    '5bpukriu': {
      'en': 'Search...',
      'ar': '',
    },
    'jpn0xxk1': {
      'en': 'English',
      'ar': 'English',
    },
    'vqrk7w5w': {
      'en': 'Arabic',
      'ar': 'Arabic',
    },
  },
  // Address-popup
  {
    's1fhhzhn': {
      'en': 'Address',
      'ar': 'الرجاء اختيار خيار',
    },
    'f2plalmd': {
      'en': 'Street Name',
      'ar': 'اسم',
    },
    'es7zsf2h': {
      'en': '',
      'ar': 'اسم',
    },
    'rirmrv24': {
      'en': 'Street Name',
      'ar': 'اسم الشارع',
    },
    '5rqau593': {
      'en': 'Building Number',
      'ar': 'بريد إلكتروني',
    },
    'wmn950xq': {
      'en': '',
      'ar': 'بريد إلكتروني',
    },
    'kvzb6sqo': {
      'en': 'Building number',
      'ar': 'رقم المبنى',
    },
    'wabvml7n': {
      'en': 'Area',
      'ar': 'كلمة المرور',
    },
    '0xjv7ed9': {
      'en': '',
      'ar': 'كلمة المرور',
    },
    'uo1mqpaq': {
      'en': 'Area',
      'ar': 'منطقة',
    },
    '25vwdr1k': {
      'en': 'City',
      'ar': 'تأكيد كلمة المرور',
    },
    '8e11zm5q': {
      'en': '',
      'ar': 'تأكيد كلمة المرور',
    },
    '390ka3f1': {
      'en': 'City',
      'ar': 'مدينة',
    },
    'btx50qpm': {
      'en': 'Country',
      'ar': 'تأكيد كلمة المرور',
    },
    'stllbk2t': {
      'en': '',
      'ar': 'تأكيد كلمة المرور',
    },
    'xcl855cl': {
      'en': 'Country',
      'ar': 'دولة',
    },
    's0mz7x7k': {
      'en': 'Save',
      'ar': 'يحفظ',
    },
    'bysymna7': {
      'en': 'Street name is required',
      'ar': 'اسم الشارع مطلوب',
    },
    '5qz8pa3q': {
      'en': 'Minimum 2 charcters are required',
      'ar': 'يجب أن يكون هناك حرفين على الأقل',
    },
    'kcojrv62': {
      'en': 'Maximum 30 charcters are required',
      'ar': 'الحد الأقصى المطلوب هو 30 حرفًا',
    },
    '4le64np2': {
      'en': 'Please enter a valid street name (min. 2 characters).',
      'ar': 'الرجاء إدخال اسم الشارع صالحًا (2 حرف على الأقل).',
    },
    'iic2ouo5': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'nu68rbjx': {
      'en': 'Building number is required',
      'ar': 'مطلوب رقم مسطح',
    },
    'g27julso': {
      'en': 'Please enter a valid building number.',
      'ar': 'الرجاء إدخال رقم المبنى الصحيح.',
    },
    'da8k1fcf': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'u4c2d65e': {
      'en': 'Area is required',
      'ar': 'street2 مطلوب',
    },
    'uaibvg1l': {
      'en': 'Minimum 2 charcters are required',
      'ar': 'يجب أن يكون هناك حرفين على الأقل',
    },
    'udjfpozg': {
      'en': 'Maximum 20 charcters are required',
      'ar': 'الحد الأقصى المطلوب هو 20 حرفًا',
    },
    'e2aqh058': {
      'en': 'Please enter a valid area name.',
      'ar': 'الرجاء إدخال اسم منطقة صالح.',
    },
    'l3n1r784': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'xc5fkfrd': {
      'en': 'City is required',
      'ar': 'المدينة مطلوبة',
    },
    'zckie9gj': {
      'en': 'Minimum 2 charcters are required',
      'ar': 'يجب أن يكون هناك حرفين على الأقل',
    },
    'rb3txu99': {
      'en': 'Maximum 2 charcters are required',
      'ar': 'الحد الأقصى المطلوب هو حرفين',
    },
    'g0358rb8': {
      'en': 'Please enter a valid city name.',
      'ar': 'الرجاء إدخال اسم مدينة صالح.',
    },
    'px840k9w': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'z91nohtc': {
      'en': 'Country is required',
      'ar': 'البلد مطلوب',
    },
    'ebj11s65': {
      'en': 'Minimum 2 charcters are required',
      'ar': 'يجب أن يكون هناك حرفين على الأقل',
    },
    'spak6la1': {
      'en': 'Maximum 2 charcters are required',
      'ar': 'الحد الأقصى المطلوب هو حرفين',
    },
    'jryizibj': {
      'en': 'Please enter a valid country name.',
      'ar': 'الرجاء إدخال اسم البلد الصحيح.',
    },
    '8p37koav': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
  },
  // Country-popup
  {
    'efc75ntc': {
      'en': 'Country',
      'ar': 'الرجاء اختيار خيار',
    },
    'yxo53hu2': {
      'en': 'Please select...',
      'ar': '',
    },
    'e7zryddu': {
      'en': 'Search...',
      'ar': 'أبحث...',
    },
  },
  // Verification
  {
    'j9fnztc0': {
      'en': 'Enter the verification code',
      'ar': 'بريد إلكتروني',
    },
    'pade8ewm': {
      'en': 'Verify',
      'ar': 'يحفظ',
    },
    'qk04hk5b': {
      'en': 'PIN code is required',
      'ar': '',
    },
  },
  // home_QR
  {
    'okbpmh49': {
      'en': 'Cancel',
      'ar': '',
    },
  },
  // home_widget2_landscape
  {
    'vqawzta5': {
      'en': 'Please choose an option',
      'ar': 'الرجاء الاختيار..',
    },
    've6e3xh6': {
      'en': 'Your Rooms',
      'ar': 'غرفك',
    },
    '1pe6mfio': {
      'en': 'View all',
      'ar': '',
    },
    'pk33ua2b': {
      'en': 'Create a Room',
      'ar': 'إنشاء غرفة',
    },
    'shhsk47y': {
      'en': 'create',
      'ar': 'create',
    },
    'i05l9oqx': {
      'en': 'Join a Room',
      'ar': 'انضم إلى غرفة',
    },
    'ryex0wfy': {
      'en': 'join',
      'ar': 'join',
    },
    'm83lcq4r': {
      'en': 'Field is required',
      'ar': 'الحقل مطلوب',
    },
  },
  // Walkthrough1
  {
    'nx83yw9n': {
      'en':
          '🚀 Let’s Begin! : Select a game from the list and start playing right away.',
      'ar': '🚀 لنبدأ! اختر لعبة من القائمة وابدأ اللعب فورًا.',
    },
  },
  // Walkthrough2
  {
    'pt1yv0ec': {
      'en':
          '🏠 Create or Join a Room : Start a private match with friends or join an existing room to play together!',
      'ar':
          '🏠 أنشئ غرفة أو انضم إليها: ابدأ غرفة خاصة مع أصدقائك أو انضم إلى غرفة موجودة لتلعبوا معًا!',
    },
  },
  // Walkthrough3
  {
    '3l8b4k3k': {
      'en':
          '💰 Get More Coins  : Buy coins to unlock matches, join rooms, and keep playing without interruptions!',
      'ar':
          '💰 احصل على المزيد من العملات: اشترِ العملات لفتح الألعاب، والاستمرار في اللعب بلا انقطاع!',
    },
  },
  // Walkthrough4
  {
    'zb7pv8l5': {
      'en':
          '🎮 Quick Join  : Use the QR scanner to jump straight into a game with friends.',
      'ar':
          '🎮 انضمام سريع: استخدم الماسح الضوئي للرموز (QR) للدخول مباشرة إلى اللعبة مع أصدقائك.',
    },
  },
  // Walkthrough5
  {
    'crzlcam2': {
      'en':
          '📍 Easy Navigation : Use the bottom menu to quickly switch between Home, My Feshah & Profile.',
      'ar':
          '📍 تصفّح بسهولة: استخدم القائمة السفلية للتنقل بسرعة بين الصفحة الرئيسية، و”الفيشة الخاصة بي”، والملف الشخصي',
    },
  },
  // Terms-popup
  {
    'mm98kl9p': {
      'en': 'Terms and Conditions',
      'ar': 'الشروط والأحكام',
    },
    'oj84odji': {
      'en': 'By using FESHAH, you agree to the following:',
      'ar': 'عند استخدامك لتطبيق FESHAH فإنك توافق على ما يلي:',
    },
    'x891vqhf': {
      'en': '1. Eligibility – ',
      'ar': '1. الأهلية -',
    },
    'ngxss8bh': {
      'en':
          'You must be 13+ (with parental consent if under the age of majority).',
      'ar':
          'يجب أن يكون عمرك 13 عامًا أو أكثر (مع موافقة الوالدين إذا كنت دون سن الرشد).',
    },
    'hjdh44kw': {
      'en': '2. Account –',
      'ar': '2. الحساب –',
    },
    '6c2qarq6': {
      'en':
          ' Keep your login secure. You are responsible for all activity under your account.',
      'ar':
          'حافظ على أمان تسجيل دخولك. أنت مسؤول عن جميع الأنشطة التي تتم على حسابك.',
    },
    'yfpn4532': {
      'en': '3. Coins & Purchases – ',
      'ar': '3. العملات والمشتريات -',
    },
    'alo72gb6': {
      'en':
          'Coins are virtual only, have no cash value, and all purchases are final.',
      'ar':
          'العملات المعدنية افتراضية فقط، وليس لها قيمة نقدية، وجميع المشتريات نهائية.',
    },
    'mado2u8x': {
      'en': '4. Fair Play – ',
      'ar': '4. اللعب النظيف –',
    },
    'dtr55lmr': {
      'en':
          'No cheating, abuse, or harassment. Violations may lead to suspension or account termination.',
      'ar':
          'ممنوع الغش أو الإساءة أو المضايقة. قد تؤدي المخالفات إلى تعليق الحساب أو إغلاقه.',
    },
    'bnaod8d3': {
      'en': '5. Content – ',
      'ar': '5. المحتوى –',
    },
    'wkmbtjr4': {
      'en':
          'Content you submit may be used by FESHAH for gameplay, marketing, or improvement.',
      'ar':
          'يجوز لشركة FESHAH استخدام المحتوى الذي ترسله لأغراض اللعب أو التسويق أو التحسين.',
    },
    'grlh4qvq': {
      'en': '6. Privacy – ',
      'ar': '6. الخصوصية –',
    },
    'h4fsws10': {
      'en':
          'We collect gameplay, device, and limited personal data to improve your experience and prevent fraud. We do not sell your data.',
      'ar':
          'نجمع بيانات اللعب والجهاز وبيانات شخصية محدودة لتحسين تجربتك ومنع الاحتيال. لا نبيع بياناتك.',
    },
    '40fqzk68': {
      'en': '7. Liability – ',
      'ar': '7. المسؤولية -',
    },
    '2tyfv5ih': {
      'en':
          'The service is provided “as is.” We are not liable for outages or indirect damages.',
      'ar':
          'يتم تقديم الخدمة \"كما هي\". نحن لسنا مسؤولين عن أي انقطاع أو أضرار غير مباشرة.',
    },
    'y85v15ma': {
      'en': '8. Changes – ',
      'ar': '8. التغييرات –',
    },
    'e9ikziv7': {
      'en':
          'Terms may be updated from time to time. Continued use means acceptance of changes.',
      'ar':
          'قد تُحدَّث الشروط من وقت لآخر. الاستمرار في الاستخدام يعني قبول التغييرات.',
    },
    'rih8zjp4': {
      'en': 'Read the full Terms & Privacy Policy ',
      'ar': 'اقرأ الشروط وسياسة الخصوصية الكاملة ',
    },
    'q5yhrtmu': {
      'en': 'here',
      'ar': 'هنا',
    },
  },
  // GameFour-User2
  {
    'd7pb2lrw': {
      'en': 'Score',
      'ar': 'نتيجة',
    },
  },
  // GameFour_TieStart
  {
    'mckgz2n4': {
      'en': 'Tie Breaker',
      'ar': 'كاسر التعادل',
    },
    'mvj7ehno': {
      'en':
          '1 Questions in 60 seconds. Get +1 for correct answer, -1 for wrong. Speed and accuracy decide the winner!',
      'ar':
          'سؤال واحد في 60 ثانية. احصل على +1 للإجابة الصحيحة، و-1 للإجابة الخاطئة. السرعة والدقة تحددان الفائز!',
    },
    'n9a9l9tf': {
      'en': '[Team A] wins the toss!',
      'ar': 'ألعاب جديدة قادمة قريبا!',
    },
    'xeiu8p1t': {
      'en': ' now your turn',
      'ar': 'الآن دورك',
    },
    'acu845m8': {
      'en': '[Team A] wins the toss!',
      'ar': 'ألعاب جديدة قادمة قريبا!',
    },
    'fvsyefrt': {
      'en': 'Start the game',
      'ar': 'ابدأ اللعبة',
    },
  },
  // GameFour-User1
  {
    'a8cztwjy': {
      'en': 'Score',
      'ar': 'نتيجة',
    },
  },
  // GameFour_Timer
  {
    'hvrceqcu': {
      'en': 'Sec',
      'ar': 'ثانية',
    },
  },
  // QR_question
  {
    '051dn96b': {
      'en': 'Are you sure?',
      'ar': 'هل أنت متأكد؟',
    },
    '106fukfc': {
      'en': 'Yes',
      'ar': 'نعم',
    },
    '8d3zq3dy': {
      'en': 'Okay',
      'ar': 'لا',
    },
  },
  // notfy_room_request_decline
  {
    'pncn6dtg': {
      'en': 'Sorry, you are not  a member of \n',
      'ar': 'مبروك الآن أصبحت عضوًا',
    },
    '31t8br3w': {
      'en': 'Your request has been declined',
      'ar': 'لدى المشرف فقط السيطرة الكاملة على المساحة.',
    },
  },
  // GameHintVideo
  {
    'z7bl8fk1': {
      'en': 'How to Play',
      'ar': 'كيفية اللعب',
    },
  },
  // GameFive_Players
  {
    '6yc55e4n': {
      'en': 'You',
      'ar': 'أنت',
    },
    '3ethgslp': {
      'en': 'Vote',
      'ar': 'تصويت',
    },
    'k8w10afb': {
      'en': 'You Voted',
      'ar': 'لقد صوتت',
    },
  },
  // GameFive_Input
  {
    'pmjrr2ji': {
      'en': '',
      'ar': '',
    },
    'h10mwjku': {
      'en': 'Player name here...',
      'ar': 'أدخل اسم اللاعب',
    },
    '2lxyseiz': {
      'en': 'Add',
      'ar': 'يضيف',
    },
    '0hi2l1y0': {
      'en': 'Player name is required',
      'ar': 'اسم اللاعب مطلوب',
    },
    'xpuans24': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
  },
  // GameFive_Timer
  {
    'snb2dwdo': {
      'en': 'Sec',
      'ar': 'ثانية',
    },
  },
  // hot_potato
  {
    'u1oolaqz': {
      'en': '',
      'ar': '',
    },
    'qizbt1y1': {
      'en': 'Abdullaziz',
      'ar': '',
    },
    '3fpuaaku': {
      'en': 'Pass it!',
      'ar': '',
    },
  },
  // Hotpotatotimer
  {
    'fo93111a': {
      'en': 'Round',
      'ar': '',
    },
    'cduc34qs': {
      'en': '1/3',
      'ar': '',
    },
    'f277irdn': {
      'en': 'Time',
      'ar': '',
    },
    'tghjs7mt': {
      'en': '00:56',
      'ar': '',
    },
    '2dxcbwyk': {
      'en': 'Player',
      'ar': '',
    },
    '3jygvw8a': {
      'en': '5/5',
      'ar': '',
    },
  },
  // Powerups
  {
    'f0ac99zz': {
      'en': '1',
      'ar': '',
    },
    '1kgnxjkr': {
      'en': '1',
      'ar': '',
    },
  },
  // Changeavatar
  {
    '6dui0ctt': {
      'en': 'Change avatar',
      'ar': 'استئناف لعبتك؟',
    },
    '00i2wbbb': {
      'en': 'Save',
      'ar': 'متابعة اللعبة',
    },
  },
  // minutes
  {
    'rncz2mrj': {
      'en': '1 Min',
      'ar': '',
    },
    '8l74s050': {
      'en': '2 Min',
      'ar': '',
    },
    'ohbx0c3d': {
      'en': '3 Min',
      'ar': '',
    },
  },
  // Rounds
  {
    '15xq953g': {
      'en': '1 Rounds',
      'ar': '',
    },
    '5kdnk6ql': {
      'en': '3 Rounds',
      'ar': '',
    },
    'fn0g6abd': {
      'en': '5 Rounds',
      'ar': '',
    },
  },
  // Powerups1
  {
    'b924flxn': {
      'en': 'Speed',
      'ar': '',
    },
    'fkir30xm': {
      'en': 'Freeze',
      'ar': '',
    },
    'w9a3mbj2': {
      'en': 'Shield',
      'ar': '',
    },
    'ia2lpufv': {
      'en': 'Unseen',
      'ar': '',
    },
  },
  // Miscellaneous
  {
    'fg2azqwq': {
      'en':
          'In order to scan QR codes, app requires permission to access the camera.',
      'ar': 'من أجل مسح رموز QR، يتطلب التطبيق إذنًا للوصول إلى الكاميرا.',
    },
    'q1ba7sq4': {
      'en':
          'In order to upload data, app requires permission to access the photo library.',
      'ar': '',
    },
    'g5yoa07m': {
      'en': 'This app needs image library access to select QR code images',
      'ar': '',
    },
    'pb5ci1wv': {
      'en': 'This app requires camera access for QR code scanning.',
      'ar': 'يتطلب هذا التطبيق الوصول إلى الكاميرا لمسح رمز الاستجابة السريعة.',
    },
    'hijx52x2': {
      'en':
          'In order to scan QR codes, app requires permission to access the microphone.',
      'ar': '',
    },
    '0mof7hhc': {
      'en': 'Get new notification to keep in loop',
      'ar': '',
    },
    't26jznom': {
      'en': '',
      'ar': 'خطأ: [خطأ]',
    },
    'qq23c0ew': {
      'en': 'Your password reset email has been sent!',
      'ar': 'لقد تم إرسال بريدك الإلكتروني لإعادة تعيين كلمة المرور!',
    },
    'tqdsl3zr': {
      'en': 'Email required!',
      'ar': 'البريد الإلكتروني (مطلوب!',
    },
    'oot7mufh': {
      'en': '',
      'ar': '',
    },
    'uki5hzex': {
      'en': 'Passwords don\'t match',
      'ar': 'كلمات المرور غير متطابقة',
    },
    'i09c4dmx': {
      'en': '',
      'ar': '',
    },
    'ns6glbg0': {
      'en': '',
      'ar': '',
    },
    'd8iad25q': {
      'en': '',
      'ar': '',
    },
    'e0drijut': {
      'en': '',
      'ar': '',
    },
    'qgyw43me': {
      'en': 'The email is already in use by another account.',
      'ar': 'البريد الإلكتروني قيد الاستخدام بالفعل من قبل حساب آخر',
    },
    'fkdizkp0': {
      'en': 'The credentials entered do not match any account in the system.',
      'ar': 'البيانات المدخلة لا تتطابق مع أي حساب في النظام.',
    },
    'jgtdgyoz': {
      'en': '',
      'ar': '',
    },
    'q40m3s8w': {
      'en': '',
      'ar': '',
    },
    'dpxa7zhx': {
      'en': '',
      'ar': '',
    },
    'bocrsvvz': {
      'en': '',
      'ar': '',
    },
    'dwyeom5i': {
      'en': '',
      'ar': '',
    },
    'wzyhnspi': {
      'en': '',
      'ar': 'اختر المصدر',
    },
    'gyxc81t4': {
      'en': '',
      'ar': '',
    },
    'x1pty62b': {
      'en': '',
      'ar': '',
    },
    'k3z8i5gl': {
      'en': '',
      'ar': '',
    },
    'heorrhfn': {
      'en': '',
      'ar': 'آلة تصوير',
    },
    'k0nfi7df': {
      'en': '',
      'ar': '',
    },
    '8kh0sopy': {
      'en': '',
      'ar': '',
    },
    'wzhowyux': {
      'en': '',
      'ar': '',
    },
    'w9tyqpwk': {
      'en': '',
      'ar': '',
    },
  },
  // Hot Potato — Flame arena HUD
  {
    'hp2r0u1d': {
      'en': 'Round',
      'ar': 'جولة',
    },
    'hp3t1m3': {
      'en': 'Time',
      'ar': 'الوقت',
    },
    'hp4p1c': {
      'en': 'Player',
      'ar': 'لاعب',
    },
    'hp5s1t': {
      'en': 'Pass it!',
      'ar': 'مرّرها!',
    },
    'hp6y0u': {
      'en': 'You',
      'ar': 'أنت',
    },
    'hp7t1t': {
      'en': 'Hot Potato',
      'ar': 'البطاطا الساخنة',
    },
  },
].reduce((a, b) => a..addAll(b));
