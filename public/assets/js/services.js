'use strict';

var services = angular.module('photoChallenges.services', ['ngResource']);
var API_URL = 'http://localhost\\:3000';

services.value('version', '0.1.0');

services.factory('Challenge', ['$resource',
  function ($resource) {
    return $resource(API_URL + '/challenges/:id/:action.json',
      { id: '@id' }, {
        vote: {
          method: 'PUT',
          params: {
            action: 'vote'
          }
        }
      }
    );
  }
]);


services.factory('DailyChallenge', ['$resource',
  function ($resource) {
    return $resource(API_URL + '/daily-challenges/:id.json');
  }
]);

services.factory('Photo', ['$resource',
  function ($resource) {
    return $resource(API_URL + '/photos/:id.json', {}, {'query': {method: 'GET', isArray: false}, 'get': {method: 'GET'} });
  }
]);

services.factory('User', ['$resource',
  function ($resource) {
    return $resource(API_URL + '/users/:id.json');
  }
]);
