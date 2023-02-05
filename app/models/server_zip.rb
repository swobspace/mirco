class ServerZip
  attr_reader :server, :tmpfile

  def initialize(server, options = {})
    @server = server
    @tmpfile = File.join(Rails.root, 'tmp', 'zip', SecureRandom.hex(32))
  end

  def pack
    Zip::File.open(tmpfile, create: true) do |zfile|
      add_info(zfile, server)
      server.channels.each do |channel|
        adoc_dir = "pages"
        add_adoc(zfile, channel, adoc_dir)
      end
    end
  end

  def destroy
    File.unlink self.tmpfile
  end

private

  def add_adoc(zip, channel, dir)
    name = [dir, "#{channel.name}.adoc"].join("/")
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

  def add_info(zip, server)
    name = "#{server.name}"
    zip.get_output_stream(name) do |f|
      f.puts "#{server.to_yaml}"
      f.close(false)
    end

  end
end
