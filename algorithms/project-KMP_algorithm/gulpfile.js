import del from 'del';
import gulp from 'gulp';
import cache from 'gulp-cached';
import BrowserSync from 'browser-sync';

import orfalius from './orfalius.js';

const browserSync = BrowserSync.create();


const TEMPLATE = 'resources/template.html';
const SOURCE = 'src/**/*.md';
const SNIPPETS = 'src/**/*.mds';
const IMAGES = 'src/**/img/**/*';
const STATIC = ['src/**/*', '!src/**/vid/**/*', `!${SOURCE}`, `!${SNIPPETS}`];
const ASSETS = ['resources/**/css/*', 'resources/**/fonts/*', 'resources/**/icons/*', 'resources/**/js/*'];


function clean() {
    return del(['site/*']);
}


function compile() {
    return gulp.src(SOURCE)
        .pipe(cache('compile'))
        .pipe(orfalius(TEMPLATE))
        .pipe(gulp.dest('site'));
}

function copyStatic() {
    return gulp.src(STATIC)
        .pipe(cache('copy'))
        .pipe(gulp.dest('site'));
}

function copyAssets() {
    return gulp.src(ASSETS)
        .pipe(cache('copy'))
        .pipe(gulp.dest('site'));
}


function watch() {
    gulp.watch([TEMPLATE, SOURCE, SNIPPETS, IMAGES], compile).on('change', browserSync.reload);
    gulp.watch(STATIC, copyStatic).on('change', browserSync.reload);
    gulp.watch(ASSETS, copyAssets).on('change', browserSync.reload);
}

gulp.task('clean', clean);

gulp.task('default', gulp.series(
    gulp.parallel(
        compile,
        copyStatic,
        copyAssets),
    watch
));
