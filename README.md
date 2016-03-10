# OptionalOutlets

This Xcode plugin makes `@IBOutlet`s `Optional` and `private` in Xcode.

<p align="center">
<img src="OptionalOutlets.gif" alt="OptionalOutlets demo" />
</p>

| | OptionalOutlets
----------------------|----------------------------------
:white_check_mark: | Supports `weak` and `strong` Outlets and Collections 
:sparkles: | Super easy installation
:muscle: | `ImplicitlyUnwrappedOptional`s are ugly, say goodbye to them!
:see_no_evil: | Outlets should be private, now they are!

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

The primary goal of this plugin is to make `@IBOutlet`s `Optional`. By default, Xcode uses `ImplicitlyUnwrappedOptional`s, but that's dangerous and even though you can safely unwrap them most people don't. The secondary goal is to make your `@IBOutlet`s `private`. Using outlets outside a class is a code smell and seldom is needed. This plugin automatically makes your outlets `Optional` and `private`, simple as that! Don't worry, they are independent rules and you can disable them at any time.

:rocket: **Let's Make Xcode Great Again™**

# Special Thanks

- [@marcelofabri_](https://twitter.com/marcelofabri_) for his CocoaHeads talk about [IBOutlint](https://github.com/marcelofabri/IBOutlint) which gave me the motivation to write this and from which I've shamelessly copied most of the code.
- [@chrisfsampaio](https://twitter.com/chrisfsampaio) for adding support to making outlets `private`, adding an example project, adding feature toggles, reporting bugs and a bunch of other stuff I probably forgot to mention.
- [@orta](https://twitter.com/orta) for blogging about [his experience on building a Xcode plugin](http://artsy.github.io/blog/2014/06/17/building-the-xcode-plugin-snapshots/).
- [@kattrali](https://twitter.com/kattrali) for providing a [template for Xcode plugins](https://github.com/kattrali/Xcode-Plugin-Template).
- [@gsampaio](https://twitter.com/gsampaio) for telling me to throw the Swift version of this plugin away, copy Fabri's and save ~8Mb for all the users.

# Need help?
Please submit an issue on GitHub and provide information about your setup.

# License
This project is licensed under the terms of the MIT license. See the LICENSE file.
