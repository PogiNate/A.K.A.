# Aka

AKA is an alias manager. keep tabs on all of your alias'ed commands, shortcuts, and more without hand-editing dot files.

## Installation

For now (meaning, until I get this into [RubyGems]) use these steps

    $ cd /path/to/aka 

Then execute:

    $ bundle

Or install it yourself as:

    $ gem install /path/to/aka

## Usage

1. add the line `source ~/.alias` to your `.bash_profile` or `.profile` or `.bashrc`… basically whatever profile file you use on your system.
2. run `aka -a hi "echo Hi There!"`
3. type `source ~/.alias` to reload the aliases in your current session (or restart your session)
4. type `hi`
    1. Enjoy having your command line say `hi there` back to you
5. run `aka -h` to see a full list of features.

## Contributing

Pull requests and issues are very welcome. If you have time, please include a solution or a test with any issues you submit.


[RubyGems]:https://rubygems.org/