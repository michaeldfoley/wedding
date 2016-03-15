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

  grunt.initConfig({
    // Configurable paths
    yeoman: {
      app: 'app',
      dist: 'dist'
    },
    watch: {
      sass: {
        files: ['<%= yeoman.app %>/_scss/**/*.{scss,sass}'],
        tasks: ['sass:server', 'autoprefixer:dist']
      },
      autoprefixer: {
        files: ['<%= yeoman.app %>/css/**/*.css'],
        tasks: ['copy:stageCss', 'autoprefixer:dist']
      },
      coffee: {
        files: ['<%= yeoman.app %>/**/*.coffee'],
        tasks: ['coffee:dist']
      },
      js: {
        files: ['<%= yeoman.app %>/_src/**/*.js'],
        tasks: ['copy:stageJs']
      },
      playlist: {
        files: ['.tmp/js/playlist/**/*.js'],
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
      angular_html: {
        files: [
          '<%= yeoman.app %>/_src/**/*.html'
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
            ]
          },
          port: 3000,
          watchTask: true
        }
      },
      dist: {
        options: {
          server: {
            baseDir: '<%= yeoman.dist %>'
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
            '<%= yeoman.dist %>/*',
            // Running Jekyll also cleans the target directory.  Exclude any
            // non-standard `keep_files` here (e.g., the generated files
            // directory from Jekyll Picture Tag).
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
      dist: {
        expand: true,
        cwd: '.tmp',
        src: '**/{css,concat}/*.css',
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
        scripts: ['.tmp/js/playlist/**/*.js', '!.tmp/js/playlist/index.js'],
        relative: '.tmp/img',
        html: {recipe:  '<script src="/%" type="text/javascript"></script>'},
      },
      server: {
        src: '.jekyll/playlist/index.html'
      },
      dist: {
        src: '<%= yeoman.dist %>/playlist/index.html'
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
        src: '.jekyll/playlist/index.html',
        overwrite: true, 
        replacements: [{
          from: '<script src="js', 
          to: '<script src="/js'
        }]
      },
      dist: {
        src: '<%= yeoman.dist %>/playlist/index.html',
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
      html: '<%= yeoman.dist %>/index.html'
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
        }
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
      },
      stage: {
        expand: true,
        cwd: '<%= yeoman.app %>',
        src: ['img/**/*.{jpg,gif,png}'],
        dest: '.tmp',
        newFilesOnly: true
      },
      dist: {
        expand: true,
        cwd: '<%= yeoman.app %>',
        src: ['img/**/*.{jpg,gif,png}'],
        dest: '<%= yeoman.dist %>'
      }
    },
    imagemin: {
      dist: {
        options: {
          progressive: true
        },
        files: [{
          expand: true,
          cwd: '<%= yeoman.dist %>',
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
            '_src/**/*.js',
            'fonts/**/*',
            // Like Jekyll, exclude files & folders prefixed with an underscore.
            '!**/_*{,/**}',
            // Explicitly add any files your site needs for distribution here.
            '_bower_components/jquery/jquery.min.js',
            'favicon.{ico,png}',
            'apple-touch*.png'
          ],
          dest: '<%= yeoman.dist %>'
        },{
          expand: true,
          dot: true,
          cwd: '<%= yeoman.app %>/_src',
          src: '**/*.js',
          dest: '.tmp/js'
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
          src: 'playlist/**/*.html',
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
            '<%= yeoman.dist %>/fonts/**/*.{eot*,otf,svg,ttf,woff}'
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
        devFile : '<%= yeoman.app %>/_bower_components/modernizr/modernizr.js',
        outputFile : '.tmp/js/modernizr.js',

        extra : {
          shiv : false,
          printshiv : false,
          load : false,
          mq : false,
          cssclasses : true
        },

        extensibility : {
          addtest : false,
          prefixed : false,
          teststyles : false,
          testprops : true,
          testallprops : true,
          hasevents : false,
          prefixes : true,
          domprefixes : true,
          cssclassprefix: ''
        },
        
        uglify : false,
        parseFiles : true,
        matchCommunityTests : false,
        
        tests: [
        ],
        
        files: {
          src: [
            '.tmp/**/*',
            '<%= yeoman.app %>/**/*',
            '!<%= yeoman.app %>/_bower_components/lazysizes/plugins/**/*',
            '!<%= yeoman.app %>/_bower_components/modernizr/**/*',
            '!<%= yeoman.app %>/**/bower.json',
            ]
        }
      }
  
    },
    concurrent: {
      server: [
        'sass:server', 
        'autoprefixer:dist',
        'coffee:dist',
        'svg_sprite:stage',
        'responsive_images:stage',
        'copy:stageCss',
        'copy:stageJs',
        'copy:stageTemplates',
        'jekyll:server'
      ],
      dist: [
        'sass:dist', 
        'autoprefixer:dist',
        'coffee:dist',
        'svg_sprite:dist',
        'responsive_images:dist',
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
      'injectAngular',
      'browserSync:server',
      'penthouse',
      'cssmin:critical',
      'watch'
    ]
    
    if (target === 'dist') {
      return grunt.task.run(['build', 'browserSync:dist']);
    }
    
    if (target === 'reset') {
      serve.unshift('clean:serverReset')
      return grunt.task.run(serve);
    }
    
    serve.unshift('clean:server')
    
    grunt.task.run(serve);
  });

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
    // 'scsslint'
  ]);

  grunt.registerTask('build', [
    'clean',
    // Jekyll cleans files from the target directory, so must run first
    'jekyll:dist',
    'concurrent:dist',
    'injectAngular:dist',
    'useminPrepare',
    'modernizr',
    'concat',
    'uglify',
    'imagemin',
    'filerev',
    'usemin',
    'htmlmin',
    'browserSync:dist',
    'penthouse', 
    'cssmin'
    ]);

  grunt.registerTask('deploy', [
    'check',
    'test',
    'build',
    'buildcontrol'
    ]);

  grunt.registerTask('default', [
    'check',
    'test',
    'build'
  ]);
};
