require "aka/version"
require "fileutils"
require "methadone"
require "yaml"
module Aka

  class AliasList
    include Methadone::CLILogging

    def initialize  incoming_alias_file = nil
        @aliasPattern = /alias (\S+)="(.+)"/
        @aliases = {}
        @defaults_file = "#{ENV["HOME"]}/.aka"
        @defaults = get_defaults_from_file
        debug "Incoming Alias file is #{incoming_alias_file}"
        if incoming_alias_file
            @fileName = "#{ENV["HOME"]}/#{incoming_alias_file}"
            if incoming_alias_file != @defaults['alias-file'] 
                change_alias_file incoming_alias_file
                change_defaults "alias-file", incoming_alias_file
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
        # A whole bunch of rigamarole to make all the line items the same width.
        length = 0
        @aliases.keys.each do |k|
            length = k.length if k.length > length
        end
        length = (length + 1)* -1
        keyList = ""
        @aliases.each{|key, value| keyList = keyList + sprintf("%1$*2$s: %3$s\n",key, length, value)}
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

    def change_alias_file new_file_name
        new_file_name = "#{ENV['HOME']}/#{new_file_name}"
        info "Copy current aliases into the new file?(Yna)"
        copy = gets.chomp.downcase

        if copy == "n"
            FileUtils.touch(new_file_name)
            @fileName = new_file_name
        elsif copy == "a"
            "creation of new aliases aborted!"
        else
            debug "Copying aliases from #{@defaults['alias-file']} to #{new_file_name}"
            FileUtils.copy("#{ENV['HOME']}/#{@defaults['alias-file']}",new_file_name)
            @fileName = new_file_name
        end
    end

    def get_defaults_from_file
        if File.exists? @defaults_file
            YAML::load(File.read(@defaults_file))
        else
            {'alias-file'=>".alias"}
        end
    end

    def change_defaults name, value
        if @defaults[name] == nil ||@defaults[name] != value
            @defaults[name] = value
            File.open(@defaults_file,"w"){|file| file.write @defaults.to_yaml}
            info "Changed the default for #{name} to #{value}"
            true
        else
           debug "No changes required!"
           false
        end        
    end
  end
end