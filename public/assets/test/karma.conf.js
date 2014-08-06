module.exports = function (config) {
  config.set({

    basePath: '../',

    files: [
      'components/jquery/dist/jquery.min.js',
      'components/angular/angular.js',
      'components/angular-route/angular-route.js',
      'components/angular-mocks/angular-mocks.js',
      'components/angular-resource/angular-resource.js',
      'components/angular-strap/dist/angular-strap.min.js',
      'components/angular-strap/dist/angular-strap.tpl.min.js',
      'components/angular-devise/lib/devise-min.js',
      'components/angular-gravatar/build/md5.js',
      'components/angular-gravatar/build/angular-gravatar.js',
      'components/angular-bootstrap/ui-bootstrap.min.js',
      'js/**/*.js',
      'partials/**/*.html',
      'test/unit/**/*.js'
    ],

    reporters: ['progress', 'coverage', 'junit'],

    preprocessors: {
      'partials/**/*.html': 'ng-html2js',
      'js/*.js': ['coverage']
    },

    ngHtml2JsPreprocessor: {
      prependPrefix: 'assets/'
    },

    autoWatch: true,

    frameworks: ['jasmine'],

    browsers: ['Chrome'],

    plugins: [
      'karma-chrome-launcher',
      'karma-firefox-launcher',
      'karma-phantomjs-launcher',
      'karma-jasmine',
      'karma-junit-reporter',
      'karma-ng-html2js-preprocessor',
      'karma-coverage'
    ],

    junitReporter: {
      outputFile: '.test_out/unit.xml',
      suite: 'unit'
    },
    coverageReporter: {
      type: 'html',
      dir: '.test_out/coverage/'
    }

  });
};
