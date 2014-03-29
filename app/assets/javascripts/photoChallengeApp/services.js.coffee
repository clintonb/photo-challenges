photoChallengeServices = angular.module('photoChallengeServices', ['ngResource']);

photoChallengeServices.factory('API', ['$resource', ($resource) ->
  {
    Challenges: $resource('/challenges/:id/:action.json', {id: '@id'}, {'vote':   {method:'PUT', params: {action: 'vote'}}})
  }
])
