
// postcss configuration

var npmConfig = require('./adjustpaths.js');

npmConfig.initRewritePaths(process.env.npm_config_xdeploydir, process.env.npm_package_config_templateThemeVfsDir);

module.exports = {
 plugins : [
     require('autoprefixer')(npmConfig.autoprefixerOpts),
     require('postcss-urlrewrite')({
         imports:  true,
         properties: ['src', 'background', 'background-image'],
         rules: [{
             from: '../photoswipe/',
             to: npmConfig.resourcePath('photoswipe/')
         },{
             from: '../fonts/',
             to: npmConfig.resourcePath('fonts/')
         }]
     })
   ]
}

