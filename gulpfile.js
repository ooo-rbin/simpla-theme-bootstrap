'use strict';

process.on('uncaughtException', console.error.bind(console));

var gulp = require('gulp');
var dependencies = require('gulp-resolve-dependencies');
var concat = require('gulp-concat');
var sourcemaps = require('gulp-sourcemaps');
var less = require('gulp-less');
var coffee = require('gulp-coffee');
var minify_css = require('gulp-clean-css');
var minify_js = require('gulp-uglify');

// Основная задача

gulp.task('default', ['theme', 'style', 'script', 'admin']);
gulp.task('default:watch', ['default'], function () {
	gulp.watch([
		'./less/**/*.less',
		'./css/**/*.css',
		'!./css/theme.less.css',
		'!./css/style.less.css',
		'!./css/theme.min.css',
		'!./css/style.min.css'
	], ['theme', 'style']);
	gulp.watch([
		'./coffee/**/*.coffee',
		'./js/**/*.js',
		'!./js/script.coffee.js',
		'!./js/admin.coffee.js',
		'!./js/script.min.js',
		'!./js/admin.min.js'
	], ['script', 'admin']);
});

// Стили темы

gulp.task('theme.less', function() {
	return gulp.src(['./less/theme.less'])
		.pipe(sourcemaps.init())
		.pipe(concat('theme.less.css'))
		.pipe(less())
		.pipe(sourcemaps.write('.', {includeContent: false, sourceRoot: '../less'}))
		.pipe(gulp.dest('./css'));
});
gulp.task('theme', ['theme.less'], function() {
	return gulp.src(['./css/theme.css'])
		.pipe(sourcemaps.init({loadMaps: true}))
		.pipe(dependencies({pattern: /@require\s+(\S*\.css)/g}))
		.pipe(concat('theme.min.css'))
		.pipe(minify_css())
		.pipe(sourcemaps.write('.', {includeContent: false, sourceRoot: '.'}))
		.pipe(gulp.dest('./css'));
});

// Стили редактора

gulp.task('style.less', function() {
	return gulp.src(['./less/style.less'])
		.pipe(sourcemaps.init())
		.pipe(concat('style.less.css'))
		.pipe(less())
		.pipe(sourcemaps.write('.', {includeContent: false, sourceRoot: '../less'}))
		.pipe(gulp.dest('./css'));
});
gulp.task('style', ['style.less'], function() {
	return gulp.src(['./css/style.css'])
		.pipe(sourcemaps.init({loadMaps: true}))
		.pipe(dependencies({pattern: /@require\s+(\S*\.css)/g}))
		.pipe(concat('style.min.css'))
		.pipe(minify_css())
		.pipe(sourcemaps.write('.', {includeContent: false, sourceRoot: '.'}))
		.pipe(gulp.dest('./css'));
});

// Скрипты темы

gulp.task('script.coffee', function() {
	return gulp.src(['./coffee/script.coffee'])
		.pipe(sourcemaps.init())
		.pipe(dependencies({pattern: /@require\s+(\S*\.coffee)/g}))
		.pipe(concat('script.coffee.js'))
		.pipe(coffee())
		.pipe(sourcemaps.write('.', {includeContent: false, sourceRoot: '../coffee'}))
		.pipe(gulp.dest('./js'));
});
gulp.task('script', ['script.coffee'], function() {
	return gulp.src(['./js/script.js'])
		.pipe(sourcemaps.init({loadMaps: true}))
		.pipe(dependencies({pattern: /@require\s+(\S*\.js)/g}))
		.pipe(concat('script.min.js'))
		.pipe(minify_js())
		.pipe(sourcemaps.write('.', {includeContent: false, sourceRoot: '.'}))
		.pipe(gulp.dest('./js'));
});

// Скрипты администратора

gulp.task('admin.coffee', function() {
	return gulp.src(['./coffee/admin.coffee'])
		.pipe(sourcemaps.init())
		.pipe(dependencies({pattern: /@require\s+(\S*\.coffee)/g}))
		.pipe(concat('admin.coffee.js'))
		.pipe(coffee())
		.pipe(sourcemaps.write('.', {includeContent: false, sourceRoot: '../coffee'}))
		.pipe(gulp.dest('./js'));
});
gulp.task('admin', ['admin.coffee'], function() {
	return gulp.src(['./js/admin.js'])
		.pipe(sourcemaps.init({loadMaps: true}))
		.pipe(dependencies({pattern: /@require\s+(\S*\.js)/g}))
		.pipe(concat('admin.min.js'))
		.pipe(minify_js())
		.pipe(sourcemaps.write('.', {includeContent: false, sourceRoot: '.'}))
		.pipe(gulp.dest('./js'));
});
