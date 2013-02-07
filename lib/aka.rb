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
    end

    def remove string
         #remove the alias from the list.
         @aliases.delete string
         writeOut
    end 

    def list
        #return the list of aliases.
        keyList = ""
        @aliases.keys.each{|key| keyList = keyList+" #{key}" }
        info(keyList)
    end

    def show string
        #return the command of a single alias.
        info(@aliases[string])
    end

    def empty
        #empty out the file.
        @aliases = {}
        writeOut
    end

    def backup
        FileUtils.copy(@fileName,"#{@fileName}.bak")
    end

    def writeOut
        filestring = ""
        @aliases.each { |key, value| filestring = filestring + "alias #{key}=\"#{value}\"\n" }
        
        File.open(@fileName, "w") { |file| file.write filestring  }

        #write out the list. This will be called after any method that changes something.
    end
  end
end
