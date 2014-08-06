'use strict';


// Declare app level module which depends on filters, and services
angular.module('photoChallenges', [
  'ui.bootstrap',
  'Devise',
  'ui.gravatar',
  'ngRoute',
  'photoChallenges.filters',
  'photoChallenges.services',
  'photoChallenges.directives',
  'photoChallenges.controllers'
]).config([
  'gravatarServiceProvider', function(gravatarServiceProvider) {
    gravatarServiceProvider.defaults = {
      size     : 30,
      "default": 'mm'  // Mystery man as default for missing avatars
    };

    // Use https endpoint
    gravatarServiceProvider.secure = true;
  }
]).config(['$routeProvider', function ($routeProvider) {
  $routeProvider.when('/challenges', {templateUrl: 'assets/partials/challenge-list.html', controller: 'ChallengeListCtrl'});
  $routeProvider.when('/challenges/new', {templateUrl: 'assets/partials/challenge-create.html', controller: 'ChallengeCreateCtrl'});
  $routeProvider.when('/challenges/:id', {templateUrl: 'assets/partials/challenge-detail.html', controller: 'ChallengeDetailCtrl'});
  $routeProvider.when('/daily-challenges', {templateUrl: 'assets/partials/challenge-detail.html', controller: 'DailyChallengeDetailCtrl'});
  $routeProvider.when('/daily-challenges/all', {templateUrl: 'assets/partials/daily_challenge-list.html', controller: 'DailyChallengeListCtrl'});
  $routeProvider.when('/daily-challenges/:id', {templateUrl: 'assets/partials/challenge-detail.html', controller: 'DailyChallengeDetailCtrl'});
  $routeProvider.when('/photos', {templateUrl: 'assets/partials/photo-list.html', controller: 'PhotoListCtrl'});
  $routeProvider.when('/photos/:id', {templateUrl: 'assets/partials/photo-detail.html', controller: 'PhotoDetailCtrl'});
  $routeProvider.when('/users/:id', {templateUrl: 'assets/partials/user-detail.html', controller: 'UserDetailCtrl'});
  $routeProvider.when('/', {redirectTo: '/daily-challenges'});
  $routeProvider.otherwise({templateUrl:'assets/partials/404.html'});
}]);
