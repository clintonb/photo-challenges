photoChallengeControllers = angular.module('photoChallengeControllers', []);

photoChallengeControllers.controller('ChallengeListCtrl', ['$scope', 'API', ($scope, API) ->

]);

photoChallengeControllers.controller('ChallengeDetailCtrl', ['$scope', 'API', ($scope, API) ->
  $scope.init = (id, votes=0, voted=false) ->
    $scope.id = id
    $scope.votes = votes
    $scope.voted = voted

  $scope.vote = () ->
    unless $scope.voted
      API.Challenges.vote(id: $scope.id)
      $scope.voted = true
      $scope.votes++
]);
