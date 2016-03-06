# OptionalOutlets

This Xcode plugin makes `@IBOutlet`s Optional in Xcode.

<p align="center">
<img src="OptionalOutlets.gif" alt="OptionalOutlets demo" />
</p>

| | OptionalOutlets
----------------------|----------------------------------
:white_check_mark: | No method swizzling needed
:rocket: | Saves you **hours** of boredom by not having to manually fixing the outlets
:sparkles: | Super easy installation
:muscle: | `ImplicitlyUnwrappedOptional`s are ugly, say goodbye to them!

# Installation

### Alcatraz
You can install `OptionalOutlets` using [Alcatraz](http://alcatraz.io/).

First, install [Alcatraz](http://alcatraz.io/) using

```
curl -fsSL https://raw.githubusercontent.com/supermarin/Alcatraz/deploy/Scripts/install.sh | sh
```

- Restart Xcode
- Click on `Window`
- Select `Package Manager`
- Search and Install `OptionalOutlets`
- Restart Xcode

### Manually

You can also install the plugin manually by cloning this repository and building the project. It'll be installed on `~/Library/Application Support/Developer/Shared/Xcode/Plug-ins/OptionalOutlets.xcplugin`.

You should restart Xcode after that.

# What does this do?

The primary goal of this plugin is to make `@IBOutlet`s Optional. By default, Xcode uses `ImplicitlyUnwrappedOptional`s, but that's dangerous and even though you can safely unwrap them most people don't. This plugin automatically makes your outlets Optional, simple as that!

**Let's get rid of force unwrapping!**

# Special Thanks

- [@marcelofabri_](https://twitter.com/marcelofabri_) for his CocoaHeads talk about [IBOutlint](https://github.com/marcelofabri/IBOutlint) which gave me the motivation to write this and from which I've shamelessly copied most of the code.
- [@orta](https://twitter.com/orta) for blogging about [his experience on building a Xcode plugin](http://artsy.github.io/blog/2014/06/17/building-the-xcode-plugin-snapshots/).
- [@kattrali](https://twitter.com/kattrali) for providing a [template for Xcode plugins](https://github.com/kattrali/Xcode-Plugin-Template).
- [@gsampaio](https://twitter.com/gsampaio) for telling me to throw the Swift version of this plugin away, copy Fabri's and save ~8Mb for all the users.

# Need help?
Please submit an issue on GitHub and provide information about your setup.

# License
This project is licensed under the terms of the MIT license. See the LICENSE file.
