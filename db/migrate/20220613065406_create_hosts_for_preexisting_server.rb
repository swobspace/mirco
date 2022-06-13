class CreateHostsForPreexistingServer < ActiveRecord::Migration[6.1]
  def up
    sg = SoftwareGroup.find_or_create_by!(name: 'MIRTH')
    Server.where(host_id: nil).each do |server|
      host = Host.create!(name: server.name,
                          software_group_id: sg.id,
                          location_id: server.location&.id,
                          ipaddress: server.uri&.host)
                          
      server.update(host_id: host.id)
    end
  end

  def down
  end
end

