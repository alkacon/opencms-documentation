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

// target path of the generated CSS in OpenCms
var cssDeployDir = "/system/modules/com.alkacon.documentation/resources/css/";

// the folder where the static template resources are located
var resourceDir = "/system/modules/com.alkacon.documentation/resources/";

// function to calculate the relative file path for the generated CSS to the static template folder in the OpenCms VFS
// it's is required to use relative paths here to make sure static export works as expected
exports.resourcePath = function(target) {
    var resPath = path.normalize(path.relative(cssDeployDir, resourceDir) + '/'
            + target)
    if (path.sep == '\\') {
        resPath = resPath.replace(/\\/g, '/');
    }
    console.log('Rewriting path:' + target + ' to:' + resPath);
    return resPath;
}

// options used by clean-css
var cleanCssOptions = {
    compatibility : 'ie10+',
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
function cleanCss(inputFiles, outputDir) {
    console.log('cleancss: from ' + inputFiles + ' to ' + outputDir);
    // set the rebase path, this is required otherwise the source map file is not found
    cleanCssOptions.rebaseTo = path.normalize(outputDir + '/');
    ensureDir(cleanCssOptions.rebaseTo);
    glob(inputFiles, function(err, files) {
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
            console.error('Minified: ' + minified.inlinedStylesheets[0]);
        }

        if (minified.warnings.length > 0) {
            console.log(minified.warnings);
        }

        if (minified.errors.length > 0) {
            console.log(minified.errors);
            process.exit(1);
        }

        var mapFilename = path.basename(outputFile) + '.map';
        var mapPath = path.join(path.dirname(outputFile), mapFilename);
        fs.writeFileSync(outputFile, minified.styles + lineBreak
                + '/*# sourceMappingURL=' + mapFilename + ' */', 'utf-8');
        fs.writeFileSync(mapPath, minified.sourceMap.toString(), 'utf-8');
    });
}

console.log('Using npmTasks.js');
if (argv.cleancss) {
    cleanCss(argv.inputFiles, argv.outputDir);
}