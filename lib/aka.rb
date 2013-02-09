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
    end

    def remove string
         @aliases.delete string
         writeOut
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
        backup          # So we don't have deleter's remorse.
        @aliases = {}
        writeOut
    end

    def backup
        FileUtils.copy(@fileName,"#{@fileName}.bak")
    end

    def writeOut
        filestring = ""
        @aliases.sort.each { |key, value| filestring = filestring + "alias #{key}=\"#{value}\"\n" }
        File.open(@fileName, "w") { |file| file.write filestring  }
    end
  end
end
