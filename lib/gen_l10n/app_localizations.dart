import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

abstract class AppLocalizations {
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  String get appName;
  String get appDescription;
  String get loginTitle;
  String get registerTitle;
  String get emailLabel;
  String get passwordLabel;
  String get displayNameLabel;
  String get loginButton;
  String get registerButton;
  String get guestButton;
  String get homeTitle;
  String get addTripTitle;
  String get tripNameLabel;
  String get tripDescriptionLabel;
  String get tripImageLabel;
  String get saveButton;
  String get cancelButton;
  String get deleteButton;
  String get undoButton;
  String get settingsTitle;
  String get themeTitle;
  String get languageTitle;
  String get aboutTitle;
  String get versionLabel;
  String get logoutButton;
  String get errorGeneric;
  String get errorNoInternet;
  String get errorInvalidEmail;
  String get errorInvalidPassword;
  String get errorRequiredField;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es', 'fr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(_AppLocalizationsImpl(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

class _AppLocalizationsImpl extends AppLocalizations {
  _AppLocalizationsImpl(this.locale);

  final Locale locale;

  @override
  String get appName {
    switch (locale.languageCode) {
      case 'es':
        return 'Diario de Viaje';
      case 'fr':
        return 'Journal de Voyage';
      default:
        return 'Travel Diary';
    }
  }

  @override
  String get appDescription {
    switch (locale.languageCode) {
      case 'es':
        return 'Tu compañero personal de viaje';
      case 'fr':
        return 'Votre compagnon de voyage personnel';
      default:
        return 'Your personal travel companion';
    }
  }

  @override
  String get loginTitle {
    switch (locale.languageCode) {
      case 'es':
        return 'Bienvenido de nuevo';
      case 'fr':
        return 'Bienvenue';
      default:
        return 'Welcome Back';
    }
  }

  @override
  String get registerTitle {
    switch (locale.languageCode) {
      case 'es':
        return 'Crear cuenta';
      case 'fr':
        return 'Créer un compte';
      default:
        return 'Create Account';
    }
  }

  @override
  String get emailLabel {
    switch (locale.languageCode) {
      case 'es':
        return 'Correo electrónico';
      case 'fr':
        return 'Email';
      default:
        return 'Email';
    }
  }

  @override
  String get passwordLabel {
    switch (locale.languageCode) {
      case 'es':
        return 'Contraseña';
      case 'fr':
        return 'Mot de passe';
      default:
        return 'Password';
    }
  }

  @override
  String get displayNameLabel {
    switch (locale.languageCode) {
      case 'es':
        return 'Nombre para mostrar';
      case 'fr':
        return "Nom d'affichage";
      default:
        return 'Display Name';
    }
  }

  @override
  String get loginButton {
    switch (locale.languageCode) {
      case 'es':
        return 'Iniciar sesión';
      case 'fr':
        return 'Se connecter';
      default:
        return 'Login';
    }
  }

  @override
  String get registerButton {
    switch (locale.languageCode) {
      case 'es':
        return 'Registrarse';
      case 'fr':
        return "S'inscrire";
      default:
        return 'Register';
    }
  }

  @override
  String get guestButton {
    switch (locale.languageCode) {
      case 'es':
        return 'Continuar como invitado';
      case 'fr':
        return "Continuer en tant qu'invité";
      default:
        return 'Continue as Guest';
    }
  }

  @override
  String get homeTitle {
    switch (locale.languageCode) {
      case 'es':
        return 'Mis viajes';
      case 'fr':
        return 'Mes voyages';
      default:
        return 'My Trips';
    }
  }

  @override
  String get addTripTitle {
    switch (locale.languageCode) {
      case 'es':
        return 'Añadir viaje';
      case 'fr':
        return 'Ajouter un voyage';
      default:
        return 'Add Trip';
    }
  }

  @override
  String get tripNameLabel {
    switch (locale.languageCode) {
      case 'es':
        return 'Nombre del viaje';
      case 'fr':
        return 'Nom du voyage';
      default:
        return 'Trip Name';
    }
  }

  @override
  String get tripDescriptionLabel {
    switch (locale.languageCode) {
      case 'es':
        return 'Descripción';
      case 'fr':
        return 'Description';
      default:
        return 'Description';
    }
  }

  @override
  String get tripImageLabel {
    switch (locale.languageCode) {
      case 'es':
        return 'URL de la imagen';
      case 'fr':
        return "URL de l'image";
      default:
        return 'Image URL';
    }
  }

  @override
  String get saveButton {
    switch (locale.languageCode) {
      case 'es':
        return 'Guardar';
      case 'fr':
        return 'Enregistrer';
      default:
        return 'Save';
    }
  }

  @override
  String get cancelButton {
    switch (locale.languageCode) {
      case 'es':
        return 'Cancelar';
      case 'fr':
        return 'Annuler';
      default:
        return 'Cancel';
    }
  }

  @override
  String get deleteButton {
    switch (locale.languageCode) {
      case 'es':
        return 'Eliminar';
      case 'fr':
        return 'Supprimer';
      default:
        return 'Delete';
    }
  }

  @override
  String get undoButton {
    switch (locale.languageCode) {
      case 'es':
        return 'Deshacer';
      case 'fr':
        return 'Annuler';
      default:
        return 'Undo';
    }
  }

  @override
  String get settingsTitle {
    switch (locale.languageCode) {
      case 'es':
        return 'Ajustes';
      case 'fr':
        return 'Paramètres';
      default:
        return 'Settings';
    }
  }

  @override
  String get themeTitle {
    switch (locale.languageCode) {
      case 'es':
        return 'Tema';
      case 'fr':
        return 'Thème';
      default:
        return 'Theme';
    }
  }

  @override
  String get languageTitle {
    switch (locale.languageCode) {
      case 'es':
        return 'Idioma';
      case 'fr':
        return 'Langue';
      default:
        return 'Language';
    }
  }

  @override
  String get aboutTitle {
    switch (locale.languageCode) {
      case 'es':
        return 'Acerca de';
      case 'fr':
        return 'À propos';
      default:
        return 'About';
    }
  }

  @override
  String get versionLabel {
    switch (locale.languageCode) {
      case 'es':
        return 'Versión';
      case 'fr':
        return 'Version';
      default:
        return 'Version';
    }
  }

  @override
  String get logoutButton {
    switch (locale.languageCode) {
      case 'es':
        return 'Cerrar sesión';
      case 'fr':
        return 'Se déconnecter';
      default:
        return 'Logout';
    }
  }

  @override
  String get errorGeneric {
    switch (locale.languageCode) {
      case 'es':
        return 'Algo salió mal';
      case 'fr':
        return "Une erreur s'est produite";
      default:
        return 'Something went wrong';
    }
  }

  @override
  String get errorNoInternet {
    switch (locale.languageCode) {
      case 'es':
        return 'Sin conexión a Internet';
      case 'fr':
        return 'Pas de connexion Internet';
      default:
        return 'No internet connection';
    }
  }

  @override
  String get errorInvalidEmail {
    switch (locale.languageCode) {
      case 'es':
        return 'Dirección de correo electrónico inválida';
      case 'fr':
        return 'Adresse email invalide';
      default:
        return 'Invalid email address';
    }
  }

  @override
  String get errorInvalidPassword {
    switch (locale.languageCode) {
      case 'es':
        return 'La contraseña debe tener al menos 6 caracteres';
      case 'fr':
        return 'Le mot de passe doit contenir au moins 6 caractères';
      default:
        return 'Password must be at least 6 characters';
    }
  }

  @override
  String get errorRequiredField {
    switch (locale.languageCode) {
      case 'es':
        return 'Este campo es obligatorio';
      case 'fr':
        return 'Ce champ est obligatoire';
      default:
        return 'This field is required';
    }
  }
}
