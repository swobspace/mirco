class MigrateOldNotesToNotable < ActiveRecord::Migration[7.1]
  def up
    Note.where(notable_id: nil).each do |note| 
      if note.channel_statistic_id.present?
        note.notable_id = note.channel_statistic_id
        note.notable_type = 'ChannelStatistic'
      elsif note.channel_id.present?
        note.notable_id = note.channel_id
        note.notable_type = 'Channel'
      elsif note.server_id.present?
        note.notable_id = note.server_id
        note.notable_type = 'Server'
      else
        raise RuntimeError, "which notable should it bee? Huhhh..."
      end
      note.save!
    end
  end

  def down
  end
end
