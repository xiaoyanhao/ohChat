var gulp = require('gulp');
var del = require('del');
var sass = require('gulp-sass');
var livescript = require('gulp-livescript');
var nodemon = require('gulp-nodemon');
var browserSync = require('browser-sync').create();
var runSequence = require('run-sequence');

var paths = {
  ls: ['./views/**/*.ls', './routes/**/*.ls', './models/*.ls', './passport/*.ls'],
  sass: './views/**/*.sass',
  jade: './views/**/*.jade',
  materialize: './public/materialize/**/*.scss'
};

gulp.task('clean', function (callback) {
  del(['./bin', './public/materialize/css'], callback);
});

gulp.task('materialize', function () {
  return gulp.src(paths.materialize, {base: './public/materialize/sass'})
    .pipe(sass().on('error', sass.logError))
    .pipe(gulp.dest('./public/materialize/css'))
    .pipe(browserSync.stream());
});

gulp.task('sass', function () {
  return gulp.src(paths.sass, {base: './'})
    .pipe(sass().on('error', sass.logError))
    .pipe(gulp.dest('./bin'))
    .pipe(browserSync.stream());
});

gulp.task('livescript', function() {
  return gulp.src(paths.ls, {base: './'})
    .pipe(livescript({bare: true}).on('error', function(it) { throw it; }))
    .pipe(gulp.dest('./bin'));
});

gulp.task('server', ['browser-sync'], function() {
  return nodemon({
    script: './www',
    watch: ['*.js', paths.jade]
  }).on('start', function() {
    setTimeout(browserSync.reload, 2000);
  });
});

gulp.task('browser-sync', ['materialize', 'sass', 'livescript'], function () {
  var config = {
    files: [paths.jade, './public/**/*.*'],
    port: 7000,
    proxy: 'http://localhost:8000',
    open: false
  };

  browserSync.init(config);

  gulp.watch(paths.sass, ['sass']);
  gulp.watch(paths.materialize, ['materialize']);
  gulp.watch(paths.ls, ['livescript']);
});

gulp.task('default', function(callback) {
  runSequence('clean', 'server', callback);
});