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

var path = require('path');

// target deploy path of the generated CSS in the OpenCms VFS
var deployVfsDir;
// the path in the VFS where the template theme resources are located
var templateThemeVfsDir;

exports.initRewritePaths = function(deployDir, templateThemeDir) {
    console.log('');
    deployVfsDir = deployDir;
    templateThemeVfsDir = templateThemeDir;
    console.log('CSS deploy dir      : ' + deployVfsDir);
    console.log('Template theme dir  : ' + templateThemeVfsDir);
}

// function to calculate the relative file path for the generated CSS to the static template folder in the OpenCms VFS
// it's is required to use relative paths here to make sure static export works as expected
exports.resourcePath = function(target) {
    var resPath = path.normalize(path.relative(deployVfsDir, templateThemeVfsDir) + '/' + target);
    if (path.sep == '\\') {
        resPath = resPath.replace(/\\/g, '/');
    }
    console.log('- Rewriting path    : ' + target + ' to: ' + resPath);
    return resPath;
}
