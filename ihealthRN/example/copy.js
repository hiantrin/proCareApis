const fs = require('fs-extra');

const filenames = ['android/src',
                  'android/libs',
                  'android/build.gradle',
                  'android/proguard-rules.pro',
                  'ios',
                  'module',
                  'index.js',
                  'package.json'];

let srcPath  = '';
const destPath = 'node_modules/@ihealth/ihealthlibrary-react-native/';

async function task(filename) {
  try {
    const exists = await fs.pathExists(destPath + filename)
    console.log(`${filename} is exists ${exists}`);
    if (exists) {
      await fs.remove(destPath + filename)
    }
    const result = await fs.copy(srcPath + filename, destPath + filename);
    console.log(`${filename} copied!`);
  } catch (err) {
    console.error(err)
  }
}

fs.readFile('.path', 'utf8', function(err, data) {
    srcPath = data.split('=')[1];
    filenames.forEach((filename) => {
        task(filename);
    })
})

