# frozen_string_literal: true

module Mirco
  class Diagram
    def initialize
      raise 'please use a diagram specific initializer'
    end

    def image(format)
      create(format) unless File.exist?(filename(format.to_sym))
      filename(format)
    end

    def create(format)
      mk_cachedir
      File.write(filename(:puml), render_puml)
      `/usr/bin/java -jar #{jarfile} -t#{format} #{filename(:puml)}`
    end

    def delete
      Dir.glob("#{path}.*").each { |f| File.delete(f) }
    end

    def oldest_filedate
      Dir.glob("#{path}.*").map{ |f| File.mtime(f) }.sort.first
    end

    def path
      File.join(cachedir, basename)
    end

    def filename(extension)
      "#{path}.#{extension}"
    end

    def mk_cachedir
      FileUtils.mkdir_p(cachedir) unless File.exist?(cachedir)
    end

    def cachedir
      Rails.root.join('tmp', 'cache', type.pluralize)
    end

    def jarfile
      Rails.root.join('shared', 'plantuml.jar')
    end

    protected

    def basename
      raise 'basename not yet defined'
    end

    def type
      raise 'type not yet defined'
    end

    def render_puml
      raise 'render_puml not yet defined'
    end
  end
end
