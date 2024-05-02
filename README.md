# Ma METEO

![Logo de l'application](/assets/logo.png)

Démo technique répondant à un énoncé qui m'a été demandé pour une candidature.

## Description

Application Flutter mobile et web reposant sur une architecture proposée par le framework [Stacked](https://stacked.filledstacks.com/).

## Composition de l'application

### Ecrans

- Splash : écran de lancement de l'application
  - gère la redirection pour un accès à l'écran de login ou directement à la home selon si l'utilisateur s'est déjà connecté précédement

- Login : écran de connexion permettant l'authentification de l'utilisateur
  - présence d'une vérification de saisie s'assurant de la validité de l'adresse e-mail et de la conformité de la composition du mot de passe
  - affichage d'une alerte et la surbrillance des champs invalides après tentative de connexion en cas d'erreur de saisie
  - présence d'un tooltip pour donner une indication sur la composition du mot de passe à respecter
  - présence une icône pour afficher en clair ou masquer le mot de passe saisi
  - sélection automatique du champs suivant après validation de l'email via le clavier et fin de saisie pour le mot de passe 

- Home : écran principal affichant la météo sur 5 jours glissants
  - Affichage du prénom et nom de l'utilisateur en toolbar
  - Affichage de la météo pour les 5 prochains jours par tranche de 3 heures via une API [^1]
    - Affichage des prévisions sous forme d'une liste groupée avec le nom des jours en sticky header
    - Affichage de l'heure, de l'icône relative à la prévision, de la température en celsius et de la description du temps
  - Selection du lieu : Paris ou géolocalisation du mobile
    - Une demande de permission est déclenchée pour obtenir la localisation
  - Pull to refresh : Rafraîchissement des données en tirant le volet vers le bas
  - Déconnexion depuis l'icône en haut à droite avec une dialog custom de confirmation

### Drawables 
- App icon : génération d'une icône native pour le launcher Android et le store Google Play

### Mockito[^2]
- Unit tests : implémentation de tests unitaires
  - API : vérification du bon traitement du retour du web service météo
    - test/services/forecast_service_test.dart
  - UI : vérification du bon affichage de la dialog de confirmation à la demande de déconnexion
    - test/viewmodels/home_viewmodel_test.dart

- Fake class : Model FakeBearer utilisé pour la connexion en dur via un faux access token

## Envie de tester ?
Télécharger l'[APK](/apk/ma_meteo.apk)

[^1]:La récupération des données se fait via l'API d'[Openweathermap](https://openweathermap.org/forecast5)
[^2]:Framework populaire de mock [Mockito](https://pub.dev/packages/mockito) inspiré de la version [Java](https://github.com/mockito/mockito)

![Screenshot of the login screen from android](/screenshots/login.png)
![Screenshot of the home screen from android](/screenshots/home.png)
![Screenshot of the home screen from web browser](/screenshots/web.png)