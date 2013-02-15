require "aka/version"
require "fileutils"
require "methadone"
require "yaml"
module Aka

  class AliasList
    include Methadone::CLILogging

    def initialize  aliasFile = nil
        @aliasPattern = /alias (\S+)="(.+)"/
        @aliases = {}
        @defaults_file = "#{ENV["HOME"]}/.aka"
        @defaults = get_defaults_from_file
        debug "Alias file is #{aliasFile}"
        if aliasFile
            @fileName = "#{ENV["HOME"]}/#{aliasFile}"
            if change_defaults "alias-file", aliasFile
                new_alias_file aliasFile
            end
        else
            @fileName = "#{ENV["HOME"]}/.alias"
        end
        debug "The File we're looking at is #{@fileName}"
        if !File.exists? @fileName
            FileUtils.touch @fileName
        end
        debug ("made it to the class. fileName is #{@fileName}, aliasPattern is #{@aliasPattern}.")

        File.foreach(@fileName) do |line|
            @aliasPattern.match(line)do |match|
                #read them all into an array
                @aliases[match[1]] = match[2]
            end            
        end
    end

    def add string, command
        debug "string: #{string} command: #{command}"
        #add a new alias to the list
        @aliases[string] = command
        writeOut
        info "#{string} added to your alias list."
    end

    def remove string
         @aliases.delete string
         writeOut
         info "#{string} removed from your alias list."
    end 

    def list
        keyList = ""
        @aliases.keys.each{|key| keyList = keyList+" #{key}" }
        info(keyList)
    end

    def showAll
        keyList = ""
        @aliases.each{|key, value| keyList = keyList + "#{key}: #{value}\n"}
        info keyList
    end

    def show string
        info(@aliases[string])
    end

    def empty
        info "Would you like to create a backup before deleting? (y/n/a)"
        backConfirm = gets.chomp.downcase
        if backConfirm.start_with? "y"
            backup
            @aliases = {}
            writeOut
            info "Alias list deleted."
        elsif backConfirm.start_with? "a"
            info "Alias list deletion aborted."
        elsif backConfirm.start_with? "n"
           @aliases = {}
           writeOut
           info "Alias list deleted."
        else
            info "I didn't understand your response; so your file was not deleted."
        end
    end

    def backup
        FileUtils.copy(@fileName,"#{@fileName}.bak")
        info "Backup created as #{@fileName}.bak"
    end

    def writeOut
        filestring = ""
        @aliases.sort.each { |key, value| filestring = filestring + "alias #{key}=\"#{value}\"\n" }
        File.open(@fileName, "w") { |file| file.write filestring  }
    end

    def new_alias_file fileName
        info "Copy current aliases into the new file?(Yna)"
        copy = gets.chomp.downcase

        if copy == "n"
            FileUtils.touch(fileName)
            @fileName = fileName
        elsif copy == "a"
            "creation of new aliases aborted!"
        else
            FileUtils.copy(@fileName,fileName)
            @fileName = fileName
        end
    end

    def get_defaults_from_file
        if File.exists? @defaults_file
            YAML::load(File.read(@defaults_file))
        else
            {}
        end
    end

    def change_defaults name, value
      debug "name: #{name}, value: #{value} defaults: #{@defaults.to_s}"
      if @defaults[name] == nil ||@defaults[name] != value
            @defaults[name] = value
            File.open(@defaultsFile,"w"){|file| file.write defaults.to_yaml}
            info "Changed the default for #{name} to #{value}"
            true
        else
           debug "No changes required!"
           false
        end        
    end
  end
end