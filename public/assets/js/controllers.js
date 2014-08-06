'use strict';

/* Controllers */

var controllers = angular.module('photoChallenges.controllers', []);

controllers.controller('ChallengeListCtrl', ['$scope', 'Challenge', function ($scope, Challenge) {
  $scope.challenges = Challenge.query();
  $scope.orderProp = '-created_at';
}]);

controllers.controller('ChallengeDetailCtrl', ['$scope', '$routeParams', 'Challenge', function ($scope, $routeParams, Challenge) {
  $scope.init = function(challenge) {
    $scope.challenge = challenge;
    $scope.votes = challenge.likes;
    $scope.voted = challenge.liked
  };

  $scope.challenge = $scope.challenge || Challenge.get({id: $routeParams.id}, function (challenge) {
  });

  $scope.vote = function () {
    Challenge.vote({id: $scope.challenge.id});
  };
}]);

controllers.controller('ChallengeCreateCtrl', ['$scope', '$routeParams', 'Challenge', function ($scope, $routeParams, Challenge) {
}]);

controllers.controller('DailyChallengeDetailCtrl', ['$scope', '$routeParams', 'DailyChallenge', function ($scope, $routeParams, DailyChallenge) {
  $scope.daily_challenge = DailyChallenge.get({id: $routeParams.id || 'latest'}, function (daily_challenge) {
    $scope.challenge = daily_challenge.challenge;
  });
}]);

controllers.controller('DailyChallengeListCtrl', ['$scope', 'DailyChallenge', function ($scope, DailyChallenge) {
  $scope.daily_challenges = DailyChallenge.query();
}]);

controllers.controller('PhotoListCtrl', ['$scope', 'Photo', function ($scope, Photo) {
  $scope.photos = Photo.query();
}]);

controllers.controller('PhotoDetailCtrl', ['$scope', '$routeParams', 'Photo', function ($scope, $routeParams, Photo) {
  $scope.photo = Photo.get({id: $routeParams.id}, function (photo) {
  });
}]);

controllers.controller('UserDetailCtrl', ['$scope', '$routeParams', 'User', function ($scope, $routeParams, User) {
  $scope.user = User.get({id: $routeParams.id}, function (User) {
  });
}]);

controllers.controller('NavBarCtrl', ['$scope', '$location', 'Auth', function ($scope, $location, Auth) {
  $scope.isCollapsed = true;
  $scope.user = null;

  $scope.isActive = function (viewLocation) {
    return viewLocation === $location.path();
  };

  // Get the current user and set the scope variable
  Auth.currentUser().then(function (user) {
    $scope.user = user;
  }, function (error) {
    $scope.user = null;
  });

  // Logout
  $scope.logout = function () {
    Auth.logout().then(function (oldUser) {
      $scope.user = null;

      // TODO: Display message
    });
  };
}]);
