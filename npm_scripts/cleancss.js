/*
 * This program is part of the OpenCms Mercury Template.
 *
 * Copyright (c) Alkacon Software GmbH & Co. KG (http://www.alkacon.com)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

'use strict';

var argv = require('minimist')(process.argv.slice(2));
var fs = require('fs');
var path = require('path');
var glob = require("glob");
var CleanCSS = require('clean-css');
var lineBreak = require('os').EOL;

// options used by clean-css
var cleanCssOptions = {
    compatibility : '*', //  (default) - Internet Explorer 10+ compatibility mode
    level : '1',
    rebase : true,
    sourceMap : true,
    sourceMapInlineSources : true
};

// create output directory or use existing
function ensureDir(outputDir) {
    try {
        fs.mkdirSync(outputDir);
    } catch (e) {
        if (e.code !== 'EEXIST') throw e;
    }
}

// unfortunately clean-css-cli only works with one file
// since we need to minify a number of files, using clean-css API is required
function cleanCss(inputDir, outputDir) {
    outputDir = path.normalize(outputDir + '/');
    inputDir = path.normalize(inputDir + '/') + "*.css";
    console.log('');
    console.log('Clean CSS input     : ' + inputDir);
    console.log('Clean CSS output dir: ' + outputDir);
    console.log('');
    // set the rebase path, this is required otherwise the source map file is not found
    cleanCssOptions.rebaseTo = outputDir;
    ensureDir(cleanCssOptions.rebaseTo);
    glob(inputDir, function(err, files) {
        for (var i = 0; i < files.length; i++) {
            var f = files[i];
            var o = path.normalize(outputDir + '/' + path.basename(f, '.css') + '.min.css');
            cleanCssMinify(cleanCssOptions, [ f ], o);
        }
    });
}

function cleanCssMinify(options, inputFile, outputFile) {
    (new CleanCSS(options)).minify(inputFile, function(errors, minified) {
        if (minified.inlinedStylesheets.length > 0) {
            console.log('Minified: ' + minified.inlinedStylesheets[0]);
        }

        if (minified.warnings.length > 0) {
            console.warn(minified.warnings);
        }

        if (minified.errors.length > 0) {
            console.error(minified.errors);
            process.exit(1);
        }

        if (cleanCssOptions.sourceMap) {
            var mapFilename = path.basename(outputFile) + '.map';
            var mapPath = path.join(path.dirname(outputFile), mapFilename);
            fs.writeFileSync(outputFile, minified.styles + lineBreak + '/*# sourceMappingURL=' + mapFilename + ' */', 'utf-8');
            fs.writeFileSync(mapPath, minified.sourceMap.toString(), 'utf-8');
        } else {
            fs.writeFileSync(outputFile, minified.styles, 'utf-8');
        }
    });
}

if (argv.cleancss) {
    if (argv.noSrcMap) {
        cleanCssOptions.sourceMap=false;
        cleanCssOptions.sourceMapInlineSources=false;
    }
    cleanCss(argv.inputDir, argv.outputDir);
}