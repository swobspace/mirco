require 'zip'

class ServerZip
  attr_reader :server, :tmpfile

  def initialize(server, options = {})
    @server = server
    @tmpfile = File.join(Rails.root, 'tmp', 'zip', "server-#{@server.id}.zip")
    if File.exists?(@tmpfile)
      File.delete(@tmpfile)
    end
  end

  def pack
    Zip::File.open(tmpfile, create: true) do |zfile|
      add_info(zfile, server)
      add_server_diagram(zfile, server, 'images')
      server.channels.each do |channel|
        add_adoc(zfile, channel, 'pages')
        add_channel_diagram(zfile, channel, 'images')
      end
    end
  end

  def destroy
    File.unlink self.tmpfile
  end

private

  def add_adoc(zip, channel, dir)
    name = [dir, "#{channel.name}.adoc"].compact.join("/")
    zip.get_output_stream(name) do |f|
      rendered = ApplicationController.render(
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

  def add_info(zip, server)
    name = "#{server.name}"
    zip.get_output_stream(name) do |f|
      f.puts "#{server.to_yaml}"
      f.close(false)
    end
  end
end
