require "aka/version"
require "fileutils"
require "methadone"
module Aka

  class AliasList
    include Methadone::CLILogging

    def initialize  
        @aliasPattern = /alias (\S+)="(.+)"/
        @aliases = {}
        @fileName = "#{ENV["HOME"]}/.alias"
        if !File.exists? @fileName
            FileUtils.touch @fileName
        end
        debug ("made it to the class. filenName is #{@fileName}, aliasPattern is #{@aliasPattern}.")      
        #Open the alias list
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
  end
end
