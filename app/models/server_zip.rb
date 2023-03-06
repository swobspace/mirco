require 'zip'

class ServerZip
  attr_reader :server, :tmpfile, :hostname

  def initialize(server, options = {})
    @options = options.symbolize_keys
    @server = server
    @tmpfile = options.fetch(:outfile) {
                 File.join(Rails.root, 'tmp', 'zip', "server-#{@server.id}.zip")
               }
    if File.exists?(@tmpfile)
      File.delete(@tmpfile)
    end
    @hostname = (@server.hostname || @server.name).gsub(/[^A-Za-z.0-9_-]/, '')
  end

  def pack
    Zip::File.open(tmpfile, create: true) do |zfile|
      add_server_adoc(zfile, server, pagesdir)
      add_server_diagram(zfile, server, imagesdir)
      server.channels.each do |channel|
        add_channel_adoc(zfile, channel, pagesdir)
        add_channel_diagram(zfile, channel, imagesdir)
      end
    end
  end

  def destroy
    File.unlink self.tmpfile
  end

private
  attr_reader :options

  def imagesdir
    options.fetch(:imagesdir) {"images/#{hostname}"}
  end

  def pagesdir
    options.fetch(:pagesdir) {"pages/#{hostname}"}
  end

  def examplesdir
    options.fetch(:examplesdir) {"examples/#{hostname}"}
  end

  def add_server_adoc(zip, server, dir)
    name = [dir, "#{server.name}.adoc"].compact.join("/")
    zip.get_output_stream(name) do |f|
      rendered = myrenderer.render(
                   assigns: {server: server},
                   template: 'servers/show',
                   formats: [:adoc],
                   layout: false
                 )
      f.write rendered
      f.close(false)
    end
  end

  def add_channel_adoc(zip, channel, dir)
    name = [dir, "#{channel.name}.adoc"].compact.join("/")
    zip.get_output_stream(name) do |f|
      rendered = myrenderer.render(
                   assigns: {channel: channel},
                   template: 'channels/show',
                   formats: [:adoc],
                   layout: false
                 )
      f.write rendered
      f.close(false)
    end
  end

  def add_server_diagram(zip, server, dir)
    name = [dir, "#{server.name}.svg"].compact.join("/")
    diagram = Mirco::ServerDiagram.new(server)
    zip.add(name, diagram.image(:svg))
  end

  def add_channel_diagram(zip, channel, dir)
    name = [dir, "#{channel.name}.svg"].compact.join("/")
    diagram = Mirco::ChannelDiagram.new(channel)
    zip.add(name, diagram.image(:svg))
  end

  def myrenderer
    ApplicationController.renderer.with_defaults(
      http_host: Mirco.host,
      script_name: Mirco.script_name,
      https: true
    )
  end
end
