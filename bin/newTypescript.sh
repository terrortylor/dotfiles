#!/bin/bash

npm init -y
npm install typescript --save-dev
npm install @types/node --save-dev
npx tsc --init --rootDir src --outDir build \
--esModuleInterop --resolveJsonModule --lib es6 \
--module commonjs --allowJs true --noImplicitAny true
sed -i '/"scripts":.*/a \ \ \ \ "start": "./node_modules/typescript/bin/tsc && node build/index.js",' package.json
mkdir src
touch src/index.ts
echo "console.log('Hello world!')" > src/index.ts
echo "To test run: npm start"
