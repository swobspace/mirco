module Mirco
  class Diagram
    def initialize
      raise RuntimeError, "please use a diagram specific initializer"
    end

    def image(format)
      unless File.exists?(filename(format.to_sym))
        create(format)
      end
      filename(format)
    end

    def create(format)
      mk_cachedir
      File.write(filename(:puml), render_puml)
      `/usr/bin/plantuml -t#{format.to_s} #{filename(:puml)}`
    end

    def delete
      Dir.glob("#{path}.*").each {|f| File.delete(f)}
    end

    def path
      File.join(cachedir, basename)
    end

    def filename(extension)
      "#{path}.#{extension.to_s}"
    end

    def mk_cachedir
      FileUtils.mkdir_p(cachedir) unless File.exists?(cachedir)
    end

    def cachedir
      File.join(Rails.root, 'tmp', 'cache', type.pluralize)
    end

  protected

    def basename
      raise RuntimeError, "basename not yet defined"
    end

    def type
      raise RuntimeError, "type not yet defined"
    end

    def render_puml
      raise RuntimeError, "render_puml not yet defined"
    end
  end
end
