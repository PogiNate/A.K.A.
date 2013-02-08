# Aka

AKA is an alias manager. keep tabs on all of your alias'ed commands, shortcuts, and more without hand-editing dot files.

## What?

If you work on the command line a lot you know there are commands that get really tedious to type out over and over again. for decades command line pros have been adding aliases to their shell to alleviate this problem.  Simply add a line like `alias proj="cd /path/to/current/project"` to your `.profile` file and the next time you log in you can do this:

    $ proj
instead of this:

    $ cd /path/to/current/project
And you've just saved yourself 22 characters' worth of typing.

But what if you really don't want to edit your profile files every time you want to add or remove one of these aliases? Well, you can just move all the alias definitions into a file named, say `~./alias` and then you just add one line to `.profile`:

    source ~/.alias

And now you can just edit the `.alias` file. 

Or you can use `aka`.

## Installation

    $ gem install aka

## Usage

1. add the line `source ~/.alias` to your `.bash_profile` or `.profile` or `.zshrc`… basically whatever profile file you use on your system.
2. run `aka -a hi "echo Hi There!"`
3. type `source ~/.alias` to reload the aliases in your current session (or restart your session)
4. type `hi`
    1. Enjoy having your command line say `hi there` back to you
5. run `aka -h` to see a full list of features.

## Contributing

Pull requests and issues are very welcome. If you have time, please include a solution or a test with any issues you submit.

##Acknowledgements

Many, many thanks go to [David Copeland] for the [Methadone] framework that made this app possible and [his book][awesomeApps] which made it easy.

## Roadmap

I really like this app, but I've got other things I want to work on. But there are a few features I'm still planning to add:

1. Support for a config file that will let you use a file other than `~/.alias` for your aliases
1. Grouping aliases
    1. Aliases sorted alphabetically by default.


[David Copeland]:http://www.naildrivin5.com/
[Methadone]: http://davetron5000.github.com/methadone/
[RubyGems]:https://rubygems.org/
[awesomeApps]:http://www.awesomecommandlineapps.com/