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
  // Dashboard
  {
    'knrdk3vc': {
      'en': 'Dashboard',
      'pl': 'Panel główny',
    },
    'bu43kf6r': {
      'en': 'Devices',
      'pl': 'Urządzenia',
    },
    '93rethis': {
      'en': 'Items',
      'pl': 'Przykłady',
    },
    'plzrdals': {
      'en': 'Desk Lighting',
      'pl': 'Oświetlenie biurka',
    },
    '3zxte3fr': {
      'en': 'Hallway Lighting',
      'pl': 'Oświetlenie korytarza',
    },
    'p4qmuu1o': {
      'en': 'Under Lighting',
      'pl': 'Podświetlenie',
    },
    'g6pnozgc': {
      'en': 'Kitchen Lighting',
      'pl': 'Oświetlenie - kuchnia',
    },
    '6mf7cfze': {
      'en': 'Drawer Lock',
      'pl': 'Zamek',
    },
    'qlnw92vr': {
      'en': 'Roller Blinds - W',
      'pl': 'Rolety - W',
    },
    'c8yobyvg': {
      'en': 'Roller Blinds - M',
      'pl': 'Rolety - M',
    },
    'f71vzcfj': {
      'en': 'Roller Blinds - D',
      'pl': 'Rolety - D',
    },
    '7vcccpii': {
      'en': 'Air Conditioner',
      'pl': 'Klimatyzacja',
    },
    'bxfg1fql': {
      'en': 'Air Purifier',
      'pl': 'Oczyszczacz powietrza',
    },
    '7b571fjt': {
      'en': 'Soil Moisture',
      'pl': 'Wilgotność gleby',
    },
    'v57gv5ne': {
      'en': 'Temperature',
      'pl': 'Temperatura',
    },
    'jt4uj0mr': {
      'en': 'Automations',
      'pl': 'Automatyzacje',
    },
    '549pvf1t': {
      'en': 'Categories',
      'pl': 'Kategorie',
    },
    'wuotgig8': {
      'en': 'Morning',
      'pl': 'Poranek',
    },
    '4wlnwox5': {
      'en': 'Night',
      'pl': 'Noc',
    },
    'maf2os6u': {
      'en': 'Plants',
      'pl': 'Rośliny',
    },
    '8x0mj5ui': {
      'en': 'Welcome Home',
      'pl': 'Witaj w domu',
    },
    'ehhwxzv4': {
      'en': 'Wardrobe Lighting',
      'pl': 'Oświetlenie szafy',
    },
    'fsep9m08': {
      'en': 'Kitchen Lighting',
      'pl': 'Oświetlenie -kuchnia',
    },
    'erg0mogz': {
      'en': 'Scenes',
      'pl': 'Sceny',
    },
    'i6bei8ge': {
      'en': 'Categories',
      'pl': 'Kategorie',
    },
    'migymr3q': {
      'en': 'Movie',
      'pl': 'Film',
    },
    '4gx722hc': {
      'en': 'Study Mode',
      'pl': 'Tryb nauki',
    },
    'ullzwey1': {
      'en': 'All Blinds',
      'pl': 'Wszystkie rolety',
    },
    'min55hm8': {
      'en': 'Devices',
      'pl': 'Urządzenia',
    },
    'goel5txg': {
      'en': 'Menu',
      'pl': 'Menu',
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
  // AutomationDetails
  {
    'd3t1dj3t': {
      'en': 'Automation Details',
      'pl': 'Szczegóły automatyzacji',
    },
    '98r4z6ug': {
      'en': 'Automation Name',
      'pl': 'Nazwa automatyzacji',
    },
    'g9h4mc3r': {
      'en': 'Active',
      'pl': 'Aktywna',
    },
    'usbnwlnd': {
      'en': 'Select days:',
      'pl': 'Wybierz dni:',
    },
    'm9miabzw': {
      'en': 'Mon',
      'pl': 'Pon',
    },
    '0fmj2kgr': {
      'en': 'Tue',
      'pl': 'Wt',
    },
    '0c7mmagq': {
      'en': 'Wed',
      'pl': 'Śr',
    },
    '84ff23w4': {
      'en': 'Thu',
      'pl': 'Czw',
    },
    'ky402mn0': {
      'en': 'Fri',
      'pl': 'Pt',
    },
    '9wuxhajc': {
      'en': 'Sat',
      'pl': 'Sob',
    },
    'ayddrvfp': {
      'en': 'Sun',
      'pl': 'Nd',
    },
    'uybdasex': {
      'en': 'Set Time:',
      'pl': 'Ustaw czas:',
    },
    'ki34z6bq': {
      'en': 'Included Devices',
      'pl': 'Połączone urządzenia',
    },
    'lzgzah3i': {
      'en': 'Desk Lighting',
      'pl': 'Oświetlenie biurka',
    },
    '4neufju5': {
      'en': 'Hallway Lighting',
      'pl': 'Oświetlenie korytarza',
    },
    '0jp8ufnw': {
      'en': 'Under Lighting',
      'pl': 'Podświetlenie',
    },
    'hj7cn8k3': {
      'en': 'Kitchen Lighting',
      'pl': 'Oświetlenie - kuchnia',
    },
    'vreqovho': {
      'en': 'Drawer Lock',
      'pl': 'Zamek',
    },
    'o12qfnsn': {
      'en': 'Roller Blinds W',
      'pl': 'Rolety - W',
    },
    'bhgq8iyc': {
      'en': 'Air Conditioner',
      'pl': 'Klimatyzacja',
    },
    'rq1mzqny': {
      'en': 'Save',
      'pl': 'Zapisz',
    },
  },
  // Miscellaneous
  {
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
