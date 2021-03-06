// Generated on 2015-04-03 using generator-jekyllrb 1.4.1
'use strict';

// Directory reference:
//   css: css
//   sass: _scss
//   javascript: js
//   coffeescript: _js
//   images: img
//   fonts: fonts

module.exports = function (grunt) {
  // Show elapsed time after tasks run
  require('time-grunt')(grunt);
  // Load all Grunt tasks
  require('load-grunt-tasks')(grunt);
  
  var modRewrite  = require('connect-modrewrite');
  var fbConfig = grunt.file.readJSON('.auth-fb.json');

  grunt.initConfig({
    // Configurable paths
    yeoman: {
      app: 'app',
      dist: 'dist'
    },
    fbConfig: fbConfig,
    watch: {
      sass: {
        files: ['<%= yeoman.app %>/_scss/**/*.{scss,sass}'],
        tasks: ['sass:server', 'autoprefixer:stage', 'penthouse', 'cssmin:critical'],
        options: {
          interrupt: true
        }
      },
      autoprefixer: {
        files: ['<%= yeoman.app %>/css/**/*.css'],
        tasks: ['copy:stageCss', 'autoprefixer:stage']
      },
      coffee: {
        files: ['<%= yeoman.app %>/**/*.coffee'],
        tasks: ['coffee:dist']
      },
      js: {
        files: ['<%= yeoman.app %>/_src/**/*.js'],
        tasks: ['copy:stageJs']
      },
      angularJS: {
        files: ['.tmp/js/{playlist,photos}/**/*.js'],
        tasks: ['injectAngular']
      },
      coffeeTest: {
        files: ['test/spec/**/*.coffee'],
        tasks: ['coffee:test']
      },
      svg_sprite: {
        files: ['<%= yeoman.app %>/img/**/*.svg'],
        tasks: ['svg_sprite:stage']
      },
      angularTemplates: {
        files: [
          '<%= yeoman.app %>/_src/{playlist,photos}/**/*.html'
        ],
        tasks: ['copy:stageTemplates']
      },
      jekyll: {
        files: [
          '<%= yeoman.app %>/**/*.{html,yml,md,mkd,markdown}',
          '!<%= yeoman.app %>/_src/**/*.html',
          '!<%= yeoman.app %>/_bower_components/**/*'
        ],
        tasks: ['jekyll:server', 'injectAngular']
      }
    },
    browserSync: {
      server: {
        bsFiles: {
          src: [
            '.jekyll/**/*.html',
            '.tmp/js/**/*.html',
            '.tmp/css/**/*.css',
            '{.tmp,<%= yeoman.app %>}/js/**/*.js',
            '{<%= yeoman.app %>}/_bower_components/**/*.js',
            '<%= yeoman.app %>/img/**/*.{gif,jpg,jpeg,png,webp}',
            '.tmp/img/**/*.svg'
          ]
        },
        options: {
          server: {
            baseDir: [
              '.jekyll',
              '.tmp',
              '<%= yeoman.app %>'
            ],
            middleware: [
                modRewrite([
                    '^/photos/(.*) /photos/index.html [L]'
                ])
            ]
          },
          port: 3000,
          watchTask: true
        }
      },
      dist: {
        options: {
          server: {
            baseDir: '<%= yeoman.dist %>',
            middleware: [
                modRewrite([
                    '^/photos/(.*) /photos/index.html [L]'
                ])
            ]
          },
          open: false
        }
      },
      test: {
        bsFiles: {
          src: [
            '.jekyll/**/*.html',
            '.tmp/css/**/*.css',
            '{.tmp,<%= yeoman.app %>}/js/**/*.js',
            '{<%= yeoman.app %>}/_bower_components/**/*.js',
            '<%= yeoman.app %>/img/**/*.{gif,jpg,jpeg,png,svg,webp}'
          ]
        },
        options: {
          server: {
            baseDir: [
              '.jekyll',
              '.tmp',
              '<%= yeoman.app %>'
            ]
          },
          watchTask: true
        }
      }
    },
    clean: {
      dist: {
        files: [{
          dot: true,
          src: [
            '.tmp/*',
            '!.tmp/img',
            '.tmp/img/*',
            '!.tmp/img/gallery',
            '<%= yeoman.dist %>/*',
            '!<%= yeoman.dist %>/.git*'
          ]
        }]
      },
      server: [
        '.tmp/*',
        '.jekyll',
        '!.tmp/img'
      ],
      serverReset: [
        '.tmp',
        '.jekyll'
      ]
    },
    sass: {
      options: {
        debugInfo: false,
        lineNumbers: false,
        loadPath: 'app/_bower_components'
      },
      dist: {
        files: [{
          expand: true,
          cwd: '<%= yeoman.app %>/_scss',
          src: '**/*.{scss,sass}',
          dest: '.tmp/css',
          ext: '.css'
        }]
      },
      server: {
        options: {
          debugInfo: true,
          lineNumbers: true
        },
        files: [{
          expand: true,
          cwd: '<%= yeoman.app %>/_scss',
          src: '**/*.{scss,sass}',
          dest: '.tmp/css',
          ext: '.css'
        }]
      }
    },
    autoprefixer: {
      options: {
        browsers: ['last 2 versions', '> 5%']
      },
      stage: {
        expand: true,
        cwd: '.tmp',
        src: 'css/*.css',
        dest: '.tmp'
      },
      dist: {
        expand: true,
        cwd: '.tmp/concat/',
        src: 'css/*.css',
        dest: '.tmp'
      }
    },
    coffee: {
      dist: {
        options: {
          bare: true
        },
        files: [{
          expand: true,
          cwd: '<%= yeoman.app %>/_src',
          src: '**/*.coffee',
          dest: '.tmp/js',
          ext: '.js'
        }]
      },
      test: {
        options: {
          bare: true
        },
        files: [{
          expand: true,
          cwd: 'test/spec',
          src: '**/*.coffee',
          dest: '.tmp/spec',
          ext: '.js'
        }]
      }
    },
    angularFileLoader: {
      options: {
        scripts: ['.tmp/js/{playlist,photos}/**/*.js', '!.tmp/js/{playlist,photos}/index.js'],
        relative: '.tmp',
        html: {recipe:  '<script src="/%" type="text/javascript"></script>'},
      },
      server: {
        src: '.jekyll/{playlist,photos}/index.html'
      },
      dist: {
        src: '<%= yeoman.dist %>/{playlist,photos}/index.html'
      }
    },
    jekyll: {
      options: {
        config: '_config.yml,_config.build.yml',
        src: '<%= yeoman.app %>'
      },
      dist: {
        options: {
          dest: '<%= yeoman.dist %>',
        }
      },
      server: {
        options: {
          config: '_config.yml',
          dest: '.jekyll'
        }
      },
      check: {
        options: {
          doctor: true
        }
      }
    },
    replace: {
      server: {
        src: '.jekyll/**/index.html',
        overwrite: true, 
        replacements: [{
          from: '<script src="js', 
          to: '<script src="/js'
        }]
      },
      dist: {
        src: '<%= yeoman.dist %>/**/index.html',
        overwrite: true, 
        replacements: [{
          from: '<script src="js', 
          to: '<script src="/js'
        }]
      }
    },
    useminPrepare: {
      options: {
        dest: '<%= yeoman.dist %>'
      },
      dist: {
        src: ['<%= yeoman.dist %>/index.html', '<%= yeoman.dist %>/playlist/index.html', '<%= yeoman.dist %>/photos/index.html']
      }
    },
    usemin: {
      options: {
        assetsDirs: ['<%= yeoman.dist %>', '<%= yeoman.dist %>/img'],
        patterns: {
          html: [
            [/<(?:img|source)[^\>]*[^\>\S]+srcset=['"]([^"'\s]+)/gm,
              'Update the HTML with the new image filenames for srcset links'
            ],
            [/<(?:img|source)[^\>]*[^\>\S]+srcset=['"](?:(?:[^"'\s]+)\s*?(?:\s\d*?[w])?(?:\s\d*?[x])?\s*?,\s*?){1}([^"'\s]+)/gm,
              'Update the HTML with the new image filenames for srcset links'
            ],
            [/<(?:img|source)[^\>]*[^\>\S]+srcset=['"](?:(?:[^"'\s]+)\s*?(?:\s\d*?[w])?(?:\s\d*?[x])?\s*?,\s*?){2}([^"'\s]+)/gm,
              'Update the HTML with the new image filenames for srcset links'
            ],
            [/<(?:img|source)[^\>]*[^\>\S]+srcset=['"](?:(?:[^"'\s]+)\s*?(?:\s\d*?[w])?(?:\s\d*?[x])?\s*?,\s*?){3}([^"'\s]+)/gm,
              'Update the HTML with the new image filenames for srcset links'
            ],
            [/<(?:img|source)[^\>]*[^\>\S]+srcset=['"](?:(?:[^"'\s]+)\s*?(?:\s\d*?[w])?(?:\s\d*?[x])?\s*?,\s*?){4}([^"'\s]+)/gm,
              'Update the HTML with the new image filenames for srcset links'
            ],
            [/loadCSS\(['"]([^"']+)['"]\)/gm, 'Replacing reference to CSS within loadCSS']
          ]
        }
      },
      html: ['<%= yeoman.dist %>/**/*.html'],
      css: ['<%= yeoman.dist %>/css/**/*.css'],
    },
    htmlmin: {
      dist: {
        options: {
          collapseWhitespace: true,
          collapseBooleanAttributes: true,
          removeAttributeQuotes: true,
          removeRedundantAttributes: true
        },
        files: [{
          expand: true,
          cwd: '<%= yeoman.dist %>',
          src: '**/*.html',
          dest: '<%= yeoman.dist %>'
        }]
      }
    },
    // Usemin adds files to concat
    concat: {},
    // Usemin adds files to uglify
    uglify: {},
    // Usemin adds files to cssmin
    cssmin: {
      dist: {
        options: {
          check: 'gzip'
        },
        expand: true,
				cwd: '.tmp/concat',
				src: 'css/*.css',
				dest: '<%= yeoman.dist %>'
      },
      critical: {
        expand: true,
				cwd: '<%= yeoman.app %>',
				src: ['_includes/**/_*.css'],
				dest: '<%= yeoman.app %>',
      }
      
    },
    penthouse: {
      homepage : {
        outfile: '<%= yeoman.app %>/_includes/_critical_homepage.css',
        css: '.tmp/css/style.css',
        url: 'http://localhost:3000',
        width: 1280,
        height: 800
      },
      posts: {
        outfile: '<%= yeoman.app %>/_includes/_critical_posts.css',
        css: '.tmp/css/style.css',
        url: 'http://localhost:3000/story/',
        width: 1280,
        height: 800
      }
    },
    responsive_images: {
      options: {
        sizes: [{
          name: 'small',
          width: 480,
          quality: 80
        },{
          name: 'medium',
          width: 768,
          quality: 80
        },{
          name: 'large',
          width: 1200,
          quality: 80
        },{
          name: 'xlarge',
          width: 2000,
          quality: 80
        }],
        newFilesOnly: true
      },
      site: {
        expand: true,
        cwd: '<%= yeoman.app %>',
        src: ['img/**/*.{jpg,gif,png}','!img/gallery/**/*'],
        dest: '.tmp'
      },
      gallery: {
        expand: true,
        cwd: '<%= yeoman.app %>',
        src: ['img/gallery/**/*.{jpg,gif,png}'],
        dest: '.tmp'
      }
    },
    imagemin: {
      dist: {
        options: {
          progressive: true
        },
        files: [{
          expand: true,
          cwd: '.tmp',
          src: '**/*.{jpg,jpeg,png}',
          dest: '<%= yeoman.dist %>'
        }]
      }
    },
    svg_sprite: {
      options: {
        mode: {
          symbol: {
            dest: 'img',
            sprite: 'sprite.symbol.svg'
          } 
        }
      },
      stage: {
        expand: true,
        cwd: '<%= yeoman.app %>/img',
        src: ['**/*.svg'],
        dest: '.tmp',
      },
      dist: {
        expand: true,
        cwd: '<%= yeoman.app %>/img',
        src: ['**/*.svg'],
        dest: '<%= yeoman.dist %>',
      },
      
    },
    copy: {
      dist: {
        files: [{
          expand: true,
          dot: true,
          cwd: '<%= yeoman.app %>',
          src: [
            // Jekyll processes and moves HTML and text files.
            // Usemin moves CSS and javascript inside of Usemin blocks.
            // Copy moves asset files and directories.
            'spotify-callback.html',
            'fonts/**/*',
            '!**/_*{,/**}',
            'favicon.{ico,png}',
            'apple-touch*.png'
          ],
          dest: '<%= yeoman.dist %>'
        },{
          expand: true,
          dot: true,
          cwd: '<%= yeoman.app %>/_bower_components/normalize-css/',
          src: 'normalize.css',
          dest: '.tmp/css'
        },{
          expand: true,
          dot: true,
          cwd: '<%= yeoman.app %>/_src',
          src: '**/*.js',
          dest: '.tmp/js'
        },{
          expand: true,
          dot: true,
          cwd: '<%= yeoman.app %>/_src',
          src: '{playlist,photos}/**/*.html',
          dest: '<%= yeoman.dist %>/js'
        }]
      },
      // Copy CSS into .tmp directory for Autoprefixer processing
      stageCss: {
        files: [{
          expand: true,
          dot: true,
          cwd: '<%= yeoman.app %>/css',
          src: '**/*.css',
          dest: '.tmp/css'
        },
        {
          expand: true,
          dot: true,
          cwd: '<%= yeoman.app %>/_bower_components/normalize-css/',
          src: 'normalize.css',
          dest: '.tmp/css'
        }]
      },
      stageJs: {
        files: [{
          expand: true,
          dot: true,
          cwd: '<%= yeoman.app %>/_src',
          src: '**/*.js',
          dest: '.tmp/js'
        },{
          expand: true,
          dot: true,
          cwd: '<%= yeoman.app %>/_bower_components/modernizr/',
          src: 'modernizr.js',
          dest: '.tmp/js'
        }]
      },
      stageTemplates: {
        files: [{
          expand: true,
          dot: true,
          cwd: '<%= yeoman.app %>/_src',
          src: '{playlist,photos}/**/*.html',
          dest: '.tmp/js'
        }]
      }
    },
    filerev: {
      options: {
        length: 4
      },
      dist: {
        files: [{
          src: [
            '<%= yeoman.dist %>/js/**/*.js',
            '<%= yeoman.dist %>/css/**/*.css',
            '<%= yeoman.dist %>/img/**/*.{gif,jpg,jpeg,png,svg,webp}',
            '<%= yeoman.dist %>/fonts/**/*.{eot*,otf,svg,ttf,woff}',
            '!<%= yeoman.dist %>/img/gallery/**/*',
          ]
        }]
      }
    },
    buildcontrol: {
      dist: {
        options: {
          remote: 'git@github.com:michaeldfoley/wedding.git',
          branch: 'gh-pages',
          commit: true,
          push: true
        }
      }
    },
    coffeelint: {
      options: {
        'max_line_length': {
          'level': 'ignore'
        }
      },
      check: ['<%= yeoman.app %>/_src/*.coffee']
    },
    jshint: {
      options: {
        jshintrc: '.jshintrc',
        reporter: require('jshint-stylish')
      },
      all: [
        'Gruntfile.js',
        '<%= yeoman.app %>/js/**/*.js',
        'test/spec/**/*.js'
      ]
    },
    csslint: {
      options: {
        csslintrc: '.csslintrc'
      },
      check: {
        src: [
          '<%= yeoman.app %>/css/**/*.css'
        ]
      }
    },
    modernizr: {
      dist: {
        devFile : '<%= yeoman.app %>/_bower_components/modernizr/src',
        dest: '.tmp/js/modernizr.js',
        
        options: [
          'html5printshiv'
        ],
        
        tests: [
          'srcset'
        ],
        
        uglify : false,
        
        files: {
          src: [
            '{.tmp,<%= yeoman.app %>}/**/*.{js,coffee,css,sass,scss,html}',
            '!<%= yeoman.app %>/_bower_components/{lazysizes,modernizr}/**/*'
            ]
        }
      }
  
    },
    yaml: {
      dist: {
        options: {
          space: 2
        },
        files: [{
          expand: true, 
          cwd: '<%= yeoman.app %>/_data/', 
          src: ['**/*.yml'], 
          dest: '.tmp/data'
        }]
      }
    },
    
    firebase: {
      options: {
        mode: 'upload',
        token: '<%= fbConfig.token %>'
      },
      photos: {
        options: {
          reference: 'https://emandmike.firebaseio.com/photos',
        },
        files: [ { src: '.tmp/data/wedding.json' }, { src: '.tmp/data/engagement.json' },  { src: '.tmp/data/other.json' } ]
      },
      albums: {
        options: {
          reference: 'https://emandmike.firebaseio.com/',
        },
        files: [ { src: '.tmp/data/albums.json' } ]
      }
    },
    
    exec: {
      firebase: 'firebase deploy'
    },
    
    concurrent: {
      server: [
        'sass:server', 
        'coffee:dist',
        'svg_sprite:stage',
        'responsive_images',
        'copy:stageCss',
        'copy:stageJs',
        'copy:stageTemplates'
      ],
      dist: [
        'sass:dist', 
        'coffee:dist',
        'svg_sprite:dist',
        'copy:dist'
      ]
    }
  });
  
  
  // Define Tasks
  grunt.registerTask('injectAngular', function (target) {
    if (target === 'dist') {
      return grunt.task.run(['angularFileLoader:dist','replace:dist']);
    }
    
    grunt.task.run(['angularFileLoader:server','replace:server']);
  });
  
  grunt.registerTask('serve', function (target) {
    
    var serve = [
      'concurrent:server',
      'autoprefixer:stage',
      'jekyll:server',
      'injectAngular',
      'modernizr',
      'browserSync:server',
      'cssmin:critical',
      'watch'
    ];
    
    if (target === 'dist') {
      return grunt.task.run(['build', 'browserSync:dist']);
    }
    
    if (target === 'reset') {
      serve.unshift('clean:serverReset');
      return grunt.task.run(serve);
    }
    
    serve.unshift('clean:server');
    
    grunt.task.run(serve);
  });
  
  grunt.registerTask('uploadImages', [
    'yaml',
    'responsive_images:gallery',
    'firebase',
    'exec:firebase'
  ]);

  grunt.registerTask('server', function () {
    grunt.log.warn('The `server` task has been deprecated. Use `grunt serve` to start a server.');
    grunt.task.run(['serve']);
  });

  // No real tests yet. Add your own.
  grunt.registerTask('test', [
  //   'clean:server',
  //   'concurrent:test',
  //   'browserSync:test'
  ]);

  grunt.registerTask('check', [
    'clean:server',
    'jekyll:check',
    'sass:server',
    'coffeelint:check',
    'coffee:dist',
    'jshint:all',
    'csslint:check'
  ]);

  grunt.registerTask('build', [
    'clean:dist',
    'jekyll:dist',
    'concurrent:dist',
    'responsive_images',
    'injectAngular:dist',
    'modernizr',
    'useminPrepare',
    'concat',
    'autoprefixer:dist',
    'uglify',
    'cssmin:dist',
    'imagemin',
    'filerev',
    'usemin',
    'htmlmin'
    ]);

  grunt.registerTask('deploy', [
    'build',
    'yaml',
    'firebase',
    'exec:firebase'
    ]);

  grunt.registerTask('default', [
    'check',
    'test',
    'build'
  ]);
};
