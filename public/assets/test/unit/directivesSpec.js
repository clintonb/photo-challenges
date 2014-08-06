'use strict';

/* jasmine specs for directives go here */

describe('directives', function () {
  beforeEach(module('photoChallenges.directives'));

  describe('app-version', function () {
    it('should print current version', function () {
      module(function ($provide) {
        $provide.value('version', 'TEST_VER');
      });
      inject(function ($compile, $rootScope) {
        var element = $compile('<span app-version></span>')($rootScope);
        expect(element.text()).toEqual('TEST_VER');
      });
    });
  });

  describe('challenge-header', function () {
        beforeEach(module('assets/partials/challenge-header.html'));
        var scope, $compile, element;

        function sharedBehaviorForChallengeHeader(context) {
          beforeEach(inject(function ($rootScope, _$compile_) {

            scope = $rootScope;
            $compile = _$compile_;

            element = angular.element('<challenge-header challenge="challenge"></challenge-header>');

            scope.challenge = context.challenge;

            // Compile the element
            $compile(element)(scope);
            scope.$digest();
          }));

          it('should print the id', function () {
            expect(element.find('h1').text()).toBe('Challenge #1')
          });

          it('should print the submitter', function () {
            element = element.find('a.submitter');
            expect(element.text()).toBe('ccb621');
            expect(element.attr('href')).toBe('#/users/1');
          });

          it('should print the description', function () {
            expect(element.find('.description').text()).toBe("Photograph an interesting cloud.");
          });
        }

        var _challenge = {"id": 1, "created_at": "2014-04-19T00:03:47.631Z", "description": "Photograph an interesting cloud.", "daily_challenge_date": "2014-04-18T04:00:00.000Z", "user": {"id": 1, "display_name": "ccb621"},
          "photos": {"count": 0, "links": []}};

        sharedBehaviorForChallengeHeader({challenge: _challenge});

        describe('without challenge date', function () {
          var challenge = jQuery.extend({}, _challenge);
          challenge.daily_challenge_date = null;
          var context = {
            challenge: challenge
          };

          sharedBehaviorForChallengeHeader(context);

          it('does not display a daily challenge date', function () {
            expect(element.find('.daily-challenge-date').length).toBe(0);
          });
        });

        describe('with challenge date', function () {
          var challenge = jQuery.extend({}, _challenge);
          challenge.daily_challenge_date = "2014-04-18T04:00:00.000Z";
          var context = {
            challenge: challenge
          };

          sharedBehaviorForChallengeHeader(context);

          it('displays a daily challenge date', function () {
            expect(element.find('.daily-challenge-date').text()).toBe('2014 Apr 18');
          });
        });

        describe('with 1 photo', function () {
          var challenge = jQuery.extend({}, _challenge);
          challenge.photos = {"count": 1, "links": [
            {"id": 4, "url": "http://lorempixel.com/640/480/?3860", "user": {"id": 10, "display_name": "litzy.hegmann"}}
          ]};
          var context = {
            challenge: challenge
          };

          sharedBehaviorForChallengeHeader(context);

          it('the number of photos should be singular', function () {
            expect(element.find('.photo-count').text()).toBe('1 photo');
          });
        });

        describe('with multiple photos', function () {
          var challenge = jQuery.extend({}, _challenge);
          challenge.photos = {"count": 2, "links": [
            {"id": 4, "url": "http://lorempixel.com/640/480/?3860", "user": {"id": 10, "display_name": "litzy.hegmann"}},
            {"id": 5, "url": "http://lorempixel.com/640/480/?7719", "user": {"id": 13, "display_name": "carey"}}
          ]};
          var context = {
            challenge: challenge
          };

          sharedBehaviorForChallengeHeader(context);

          it('the number of photos should be plural', function () {
            expect(element.find('.photo-count').text()).toBe('2 photos');
          });
        });
      }
  )
  ;
  describe('photo-grid', function () {


    beforeEach(module('assets/partials/photo-grid.html'));

    function createGrid(photos) {
      var scope, $compile, element;

      inject(function ($rootScope, _$compile_) {
        scope = $rootScope;
        $compile = _$compile_;

        element = angular.element('<photo-grid photos="photos"></photo-grid>');

        scope.photos = photos;
      });

      $compile(element)(scope);
      scope.$digest();

      return element;
    }

    describe('with photos', function () {
      var photos = [
        {"id": 27, "url": "http://lorempixel.com/640/480/?9391", "user": {"id": 8, "display_name": "justus"}},
        {"id": 394, "url": "http://lorempixel.com/640/480/?5305", "user": {"id": 16, "display_name": "maryjane"}}
      ];


      it('displays links and photos', function () {
        var element = createGrid(photos);
        var thumbnails = element.find('.thumbnail');
        expect(thumbnails.length).toEqual(2);
        expect(thumbnails.eq(0).attr('href')).toEqual('#/photos/27');
        expect(thumbnails.eq(0).find('img').attr('src')).toEqual('http://lorempixel.com/640/480/?9391');

        expect(thumbnails.eq(1).attr('href')).toEqual('#/photos/394');
        expect(thumbnails.eq(1).find('img').attr('src')).toEqual('http://lorempixel.com/640/480/?5305');
      });
    });

    describe('without photos', function () {
      it('displays an empty alert', function () {
        var element = createGrid([]).find('.alert-info');
        expect(element.text().trim()).toEqual('No photos have been posted.');
      });
    });
  });
});
