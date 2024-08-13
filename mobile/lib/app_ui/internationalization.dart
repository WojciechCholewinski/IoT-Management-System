import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class ShteyLocalizations {
  ShteyLocalizations(this.locale);

  final Locale locale;

  static ShteyLocalizations of(BuildContext context) =>
      Localizations.of<ShteyLocalizations>(context, ShteyLocalizations)!;

  static List<String> languages() => ['en', 'pl'];

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
    String? plText = '',
  }) =>
      [enText, plText][languageIndex] ?? '';

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

class ShteyLocalizationsDelegate
    extends LocalizationsDelegate<ShteyLocalizations> {
  const ShteyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return ShteyLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<ShteyLocalizations> load(Locale locale) =>
      SynchronousFuture<ShteyLocalizations>(ShteyLocalizations(locale));

  @override
  bool shouldReload(ShteyLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // LoginPage
  {
    '47qkwvd2': {
      'en': 'WoIT',
      'pl': 'WoIT',
    },
    '54zbvivd': {
      'en': 'Byte into Comfort!',
      'pl': 'Byte into Comfort!',
    },
    'dmahbs2t': {
      'en': 'E-mail',
      'pl': 'E-mail',
    },
    'fdv4wylj': {
      'en': 'E-mail',
      'pl': 'Adres e-mail',
    },
    'lnaj13zk': {
      'en': 'Password',
      'pl': 'Password',
    },
    '42qk7ncf': {
      'en': '••••••••',
      'pl': '••••••••',
    },
    'e2ncoote': {
      'en': 'Email is required.',
      'pl': 'Podaj adres email.',
    },
    'z5newg0r': {
      'en': 'Please choose an option from the dropdown',
      'pl': 'Wybierz opcję z listy.',
    },
    '70kzte5o': {
      'en': 'Password is required.',
      'pl': 'Podaj hasło.',
    },
    'z1igambh': {
      'en': 'Please choose an option from the dropdown',
      'pl': 'Wybierz opcję z listy.',
    },
    'ivvfx7ad': {
      'en': 'Forgot password?',
      'pl': 'Nie pamiętasz hasła?',
    },
    '9hrm2ep9': {
      'en': 'Sign in',
      'pl': 'Zaloguj się',
    },
    'xzl4oow9': {
      'en': 'Sign in with Google',
      'pl': 'Zaloguj się przez Google',
    },
    'rzhq191w': {
      'en': 'Don\'t have an account?',
      'pl': 'Nie masz konta?',
    },
    'vkwuasvj': {
      'en': 'Sign up',
      'pl': 'Zarejestruj się',
    },
    '739g4swx': {
      'en': 'Home',
      'pl': 'Strona główna',
    },
  },
  // ScenesandAutomations
  {
    '9bfk1yj7': {
      'en': 'Typ akcji',
      'pl': 'Typ akcji',
    },
    'opo3f2y4': {
      'en': 'Wybierz',
      'pl': 'Wybierz',
    },
    'r1h7izzx': {
      'en': 'Scena',
      'pl': 'Scena',
    },
    '5cz301xj': {
      'en': 'Film',
      'pl': 'Film',
    },
    'qdfa3e53': {
      'en': 'ON',
      'pl': 'ON',
    },
    'du5oa7fg': {
      'en': 'Scena',
      'pl': 'Scena',
    },
    '4gtc7jyb': {
      'en': 'Noc',
      'pl': 'Noc',
    },
    'lglza26m': {
      'en': 'OFF',
      'pl': 'OFF',
    },
    'dl0rseez': {
      'en': 'Automatyzacja',
      'pl': 'Automatyzacja',
    },
    'c9isfkq2': {
      'en': 'Poranek',
      'pl': 'Poranek',
    },
    'pj9nmc76': {
      'en': 'OFF',
      'pl': 'OFF',
    },
    'y7assae8': {
      'en': 'IoT menager',
      'pl': 'IoT menager',
    },
    'f2ogag63': {
      'en': 'Home',
      'pl': 'Home',
    },
  },
  // RegisterPage
  {
    'v104at02': {
      'en': 'WoIT',
      'pl': 'WoIT',
    },
    'o5c5ko9i': {
      'en': 'Byte into Comfort!',
      'pl': 'Byte into Comfort!',
    },
    'fidrdtzw': {
      'en': 'Email',
      'pl': 'Email',
    },
    'e27ubjzv': {
      'en': 'E-mail',
      'pl': 'Adres e-mail',
    },
    'u60wusr5': {
      'en': 'Password',
      'pl': 'Hasło',
    },
    'c2e92mn2': {
      'en': '••••••••',
      'pl': '••••••••',
    },
    'pm08xcwv': {
      'en': 'Confirm password',
      'pl': 'Powtórz hasło',
    },
    'm1n98yx6': {
      'en': '••••••••',
      'pl': '••••••••',
    },
    'fs4z6stm': {
      'en': 'Email is required.',
      'pl': 'Podaj adres email.',
    },
    'h9wfxp6z': {
      'en': 'Please choose an option from the dropdown',
      'pl': 'Wybierz opcję z listy.',
    },
    'fmero5q1': {
      'en': 'Password is required.',
      'pl': 'Podaj hasło.',
    },
    '9b35mbe0': {
      'en': 'Please choose an option from the dropdown',
      'pl': 'Wybierz opcję z listy.',
    },
    '9gw170iv': {
      'en': 'Sign up',
      'pl': 'Zarejestruj się',
    },
    'whvx2see': {
      'en': 'Already have an account?',
      'pl': 'Masz już konto?',
    },
    'mjxxmjno': {
      'en': 'Sign in',
      'pl': 'Zaloguj się',
    },
    'gb0u42ny': {
      'en': 'Home',
      'pl': 'Home',
    },
  },
  // Settings
  {
    's8y4qas9': {
      'en': 'Michał Kowalski',
      'pl': 'Michał Kowalski',
    },
    'fuxxrqyb': {
      'en': 'michal@domainname.com',
      'pl': 'michal@domainname.com',
    },
    'c0nxkpd6': {
      'en': 'Change Name',
      'pl': 'Zmień nazwę',
    },
    '302zxkxl': {
      'en': 'Change Password',
      'pl': 'Zmień hasło',
    },
    'kgk1oke7': {
      'en': 'Account Settings',
      'pl': 'Ustawienia konta',
    },
    'mptimmco': {
      'en': 'Light ',
      'pl': 'Jasny',
    },
    'rv4mlumu': {
      'en': 'Dark',
      'pl': 'Ciemny',
    },
    'syhnp2eh': {
      'en': 'Follow us on',
      'pl': 'Zaobserwuj nas na',
    },
    's7fufo0f': {
      'en': 'App Version',
      'pl': 'Wersja aplikacji',
    },
    '83pndnwh': {
      'en': 'v0.0.1',
      'pl': 'v0.0.1',
    },
    'gr0jjko0': {
      'en': 'Log Out',
      'pl': 'Wyloguj',
    },
    'kn4hai48': {
      'en': 'Account',
      'pl': 'Konto',
    },
  },
  // Miscellaneous
  {
    'knrdk3vc': {
      'en': '',
      'pl': '',
    },
    'fdbdicqi': {
      'en': '',
      'pl': '',
    },
    '5xfzcoqm': {
      'en': '',
      'pl': '',
    },
    '9f20knwx': {
      'en': '',
      'pl': '',
    },
    'fs395hwm': {
      'en': '',
      'pl': '',
    },
    'xyay4gib': {
      'en': '',
      'pl': '',
    },
    'icx3ccl9': {
      'en': '',
      'pl': '',
    },
    'n2bhlw7s': {
      'en': '',
      'pl': '',
    },
    'he85t38o': {
      'en': '',
      'pl': '',
    },
    'n6z8leq2': {
      'en': '',
      'pl': '',
    },
    '2j3udxa0': {
      'en': '',
      'pl': '',
    },
    'iul8e0wu': {
      'en': '',
      'pl': '',
    },
    'ypnyxy8z': {
      'en': '',
      'pl': '',
    },
    'd55zy9pz': {
      'en': '',
      'pl': '',
    },
    'yqu1jse0': {
      'en': '',
      'pl': '',
    },
    'bl1ifgsk': {
      'en': '',
      'pl': '',
    },
    'rw5gt3cl': {
      'en': '',
      'pl': '',
    },
    'avpaajgd': {
      'en': '',
      'pl': '',
    },
    'pfymta3y': {
      'en': '',
      'pl': '',
    },
    't8fg7zc9': {
      'en': '',
      'pl': '',
    },
    'b5u851uq': {
      'en': '',
      'pl': '',
    },
    'qtv9jqti': {
      'en': '',
      'pl': '',
    },
    'ftpvjoa1': {
      'en': '',
      'pl': '',
    },
    'qbkg1158': {
      'en': '',
      'pl': '',
    },
    '8tox9yh2': {
      'en': '',
      'pl': '',
    },
  },
].reduce((a, b) => a..addAll(b));
