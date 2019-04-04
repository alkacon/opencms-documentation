
// options used by autoprefixer
var autoprefixerOptions = { browsers: [
    '> 0.5%',
    'last 2 versions',
    'not dead' // add all browsers that have > 0.5% market share
]}

// old options
var autoprefixerOptionsOld = { browsers: [
    'last 3 versions', // this will cover IE crap
    'last 15 Chrome versions', // high release frequency
    'last 10 ChromeAndroid versions', // should be the same as Chrome but make sure
    'last 15 Firefox versions', // high release frequency
    'last 5 Safari versions', // desktop OS means lower release frequency
    'last 5 Edge versions', // desktop OS means lower release frequency
    'last 3 iOs versions', // adds too much crap if we go back further
    'last 1 Android versions' // chrome is used on most anyway, adds too much crap if we go back further
]}

var npmTask = require('./npmtasks.js');

// postcss configuration
module.exports = {
    plugins : [
        require('autoprefixer')(autoprefixerOptions), // add vendor prefixes
        // require('postcss-sorting')({"sort-order": 'default'}), // sort the rules in the output
        // require('stylefmt')(), // pretty-print the output
        require('postcss-urlrewrite')({
            imports:  true,
            properties: ['src', 'background', 'background-image'],
            rules: [{
                from: '../photoswipe/',
                to: npmTask.resourcePath('photoswipe/')
            },{
                from: '../revolution-slider/',
                to: npmTask.resourcePath('../alkacon.mercury.xtensions/revolution-slider/')
            },{
                from: '../fonts/',
                to: npmTask.resourcePath('../../alkacon.mercury.theme/fonts/')
            }]
        })
    ]
}

