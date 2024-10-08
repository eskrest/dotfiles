
# Dbusmenu-0.4

![version](https://img.shields.io/npm/v/@girs/dbusmenu-0.4)
![downloads/week](https://img.shields.io/npm/dw/@girs/dbusmenu-0.4)


GJS TypeScript type definitions for Dbusmenu-0.4, generated from library version 0.4.0 using [ts-for-gir](https://github.com/gjsify/ts-for-gir) v3.2.7.

A small little library that was created by pulling out some comon code out of indicator-applet. It passes a menu structure across DBus so that a program can create a menu simply without worrying about how it is displayed on the other side of the bus.

## Install

To use this type definitions, install them with NPM:
```bash
npm install @girs/dbusmenu-0.4
```

## Usage

You can import this package into your project like this:
```ts
import Dbusmenu from '@girs/dbusmenu-0.4';
```

Or if you prefer CommonJS, you can also use this:
```ts
const Dbusmenu = require('@girs/dbusmenu-0.4');
```

### Ambient Modules

You can also use [ambient modules](https://github.com/gjsify/ts-for-gir/tree/main/packages/cli#ambient-modules) to import this module like you would do this in JavaScript.
For this you need to include `@girs/dbusmenu-0.4` or `@girs/dbusmenu-0.4/ambient` in your `tsconfig` or entry point Typescript file:

`index.ts`:
```ts
import '@girs/dbusmenu-0.4'
```

`tsconfig.json`:
```json
{
  "compilerOptions": {
    ...
  },
  "include": ["@girs/dbusmenu-0.4"],
  ...
}
```

Now you can import the ambient module with TypeScript support: 

```ts
import Dbusmenu from 'gi://Dbusmenu?version=0.4';
```

### Global import

You can also import the module with Typescript support using the global `imports.gi` object of GJS.
For this you need to include `@girs/dbusmenu-0.4` or `@girs/dbusmenu-0.4/import` in your `tsconfig` or entry point Typescript file:

`index.ts`:
```ts
import '@girs/dbusmenu-0.4'
```

`tsconfig.json`:
```json
{
  "compilerOptions": {
    ...
  },
  "include": ["@girs/dbusmenu-0.4"],
  ...
}
```

Now you have also type support for this, too:

```ts
const Dbusmenu = imports.gi.Dbusmenu;
```


### ESM vs. CommonJS

GJS supports two different import syntaxes. The new modern ESM syntax and the old global imports syntax.

In TypeScript projects for GJS and GNOME Shell extensions, you have the flexibility to use `ESM` syntax and then decide the import syntax for your bundled file. If your bundler is configured to use `CommonJS`, it will convert to the GJS-specific global imports syntax, like `const moduleName = imports.gi[moduleName]`. This is different from the traditional `require` syntax seen in Node.js. The global imports syntax is chosen because it aligns with the CommonJS format supported by NPM, which is used for the generated type definitions and this package.

On the other hand, if you configure your bundler to use ESM, it will retain the ESM import syntax. It's crucial to ensure that your bundler is set up to correctly translate and bundle these imports into either CommonJS or ESM format, depending on your project's requirements.

This approach is particularly important due to the `@girs` types, which include both `*.cjs `files, using the GJS global imports syntax, and `*.js` files, which utilize the ESM syntax. By appropriately setting up your bundler, you can control which syntax—CommonJS or ESM—is used in your project. The choice of CommonJS in this context is also due to the similarity between the GJS-specific global imports and CommonJS syntax, allowing for easier management and bundling in these specific types of projects.

Since GNOME Shell 45, you should only use ESM, even for GNOME Shell extensions. Before that, extensions had to use the global import syntax, unlike normal GJS applications, where ESM has been available for some time.

### Bundle

Depending on your project configuration, it is recommended to use a bundler like [esbuild](https://esbuild.github.io/). You can find examples using different bundlers [here](https://github.com/gjsify/ts-for-gir/tree/main/examples).

## Other packages

All existing pre-generated packages can be found on [gjsify/types](https://github.com/gjsify/types).

