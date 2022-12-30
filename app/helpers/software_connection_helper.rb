module SoftwareConnectionHelper
  def sw_connection_class(conn)
    if conn.ignore?
      "bg-ignore"
    elsif conn.disabled_channels?
      "bg-disabled"
    end
  end
end
