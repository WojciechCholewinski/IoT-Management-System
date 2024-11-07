# Aplikacja mobilna

## Konfiguracja

Po pobraniu repozytorium wykonaj następujące kroki, aby skonfigurować URL do backendu:

1. Skopiuj plik `lib/config_example.dart` jako `lib/config.dart`.
2. Edytuj `lib/config.dart` i zmień wartość `backendUrl` na adres URL swojego backendu.

   ```dart
   class Config {
     static const String backendUrl = 'https://https://example.com';
   }
   ```

3. Zapisz zmiany. Aplikacja będzie teraz korzystać z nowego endpointu do łączenia się z backendem.

## Uruchomienie aplikacji

1.  Upewnij się, że Twój backend jest uruchomiony i dostępny pod skonfigurowanym adresem URL.

2.  W terminalu, w głównym katalogu projektu mobilnego(`IoT-MANAGEMENT-SYSTEM/mobile`), uruchom następujące polecenie, aby zainstalować wymagane zależności:

    ```bash
    flutter pub get
    ```

3.  Aby uruchomić aplikację na emulatorze lub fizycznym urządzeniu, użyj polecenia:

    ```bash
    flutter run
    ```

4.  Aplikacja powinna się uruchomić i nawiązać połączenie z backendem zgodnie z ustawieniami w pliku `config.dart`.

## Struktura projektu

Poniżej szczegółowy opis struktury katalogów projektu mobilnego, który ułatwi orientację w poszczególnych komponentach:

- `android/`: Katalog z plikami konfiguracyjnymi i zasobami specyficznymi dla systemu Android.
  - `app/src/main/res/`: Folder z zasobami graficznymi dla Androida (ikony aplikacji, tła itp.).
- `assets/`: Katalog z zasobami używanymi w aplikacji jak np. obrazy które powinny być przechowywane lokalnie na urządzeniu, a nie pobierane z API.
- `ios/`: Katalog z plikami konfiguracyjnymi i zasobami specyficznymi dla systemu iOS.

  - `Runner/Assets.xcassets/`: Ikony i zasoby graficzne dla iOS (np. AppIcon).

- `lib/`: Główny katalog kodu źródłowego aplikacji Flutter.

  - `app_ui/`: Komponenty związane z interfejsem użytkownika (UI).

    - `nav/`: Nawigacja w aplikacji, np. `nav.dart`.
    - `internationalization.dart`: zestaw zmiennych zawierających dwie wersje językowe aplikacji.
    - `change_name_popup.dart`: widget do wyświetlania okienka do zmiany imienia i nazwiska użytkownika.
    - `change_password_popup.dart`: widget do wyświetlania okienka do zmiany hasła użytkownika.
    - `custom_rect_tween.dart`, `hero_dialog_route`: animacja do płynnego wyświetlania change_name_popup i change_password_popup.
    - `button_tabbar.dart`, `icon_button.dart`, itp.: Komponenty przycisków i elementów UI.
    - `theme.dart`: Definicje głównych motywów (theme) aplikacji.

  - `models/`: Modele danych (data models) reprezentujące struktury danych używanych w aplikacji.
    - `automation/`, `device/`, `user/`: Podfoldery organizujące modele związane z automatyzacją, urządzeniami i użytkownikami.
    - `auth_service.dart`, `automation_service.dart`, itp.: Pliki serwisów do komunikacji z backendem.
  - `pages/`: Ekrany aplikacji.
    - `logo_page/`: Splash screen.
    - `login_page/`: Ekran logowania.
    - `register_page/`: Ekran rejestracji.
    - `dashboard_page/`: Ekran główny do zarządzania zarówno urządzeniami indywidualnie jak i grupującymi je automatyzacjami.
    - `automation_details/`: Ekran do ustawiania szczegółów automatyzacji.
    - `settings_page/`: Ekran ustawień aplikacji i profilu.
  - `app_state.dart`: Zarządzanie stanem aplikacji. Plik ten obsługuje zarządzanie lokalnym stanem aplikacji i aktualizację na podstawie danych z backendu.
  - `config.dart`: Plik konfiguracyjny z ustawieniami URL backendu. Należy skopiować `config_example.dart` jako `config.dart` i zdefiniować URL w tym pliku.
  - `index.dart`: Zawiera zależności ekranów aplikacji z ich aliasami.
  - `main.dart`: Główny plik aplikacji.

- `linux/`, `macos/`, `windows/`: Katalogi specyficzne dla różnych systemów operacyjnych, zawierające pliki konfiguracyjne i zasoby do uruchomienia aplikacji na tych platformach.

- `web/`: Pliki konfiguracyjne i zasoby umożliwiające uruchomienie aplikacji jako aplikacji webowej (w przeglądarce).

## Uwagi Bezpieczeństwa

Pamiętaj, aby nie umieszczać rzeczywistych URL-i do produkcyjnego backendu w repozytorium publicznym. W pliku `config_example.dart` znajduje się placeholder URL (`https://example.com`), który służy jako wzór do konfiguracji backendu. Użytkownik powinien skopiować `config_example.dart` jako `config.dart` i wprowadzić własny URL backendu.

## Licencja

Projekt jest dostępny na licencji [Custom License: Attribution-NonCommercial with Trademark Restrictions](../LICENSE.md).
Można korzystać z kodu do celów niekomercyjnych, z uwzględnieniem restrykcji związanych z nazwą handlową (trademark) projektu.
Szczegóły licencji znajdują się w pliku `LICENSE.md` w nadrzędnyum folderze repozytorium.
