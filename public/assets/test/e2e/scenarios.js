'use strict';

/* https://github.com/angular/protractor/blob/master/docs/getting-started.md */

describe('photo-challenges-ui', function() {

  browser.get('/');

  it('should automatically redirect to /daily-challenges when location hash/fragment is empty', function() {
    expect(browser.getLocationAbsUrl()).toMatch("/daily-challenges");
  });
});
