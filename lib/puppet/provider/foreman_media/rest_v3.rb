Puppet::Type.type(:foreman_media).provide(:rest_v3, :parent => Puppet::Type.type(:foreman_resource).provider(:rest_v3)) do
  confine :feature => [:json, :oauth]

  def medium
    @medium ||= begin
      r = request(:get, 'api/v2/media', :search => %{name="#{resource[:name]}"})
      raise Puppet::Error.new("Media #{resource[:name]} cannot be retrieved: #{error_message(r)}") unless success?(r)
      JSON.load(r.body)['results'][0]
    end
  end

  def id
    medium ? medium['id'] : nil
  end

  def exists?
    !id.nil?
  end

  def create
    post_data = {:medium => {:name => resource[:name], :path => resource[:path], :os_family => resource[:os_family], :operatingsystem_ids => resource[:operatingsystem_ids]}}.to_json
    r = request(:post, 'api/v2/media', {}, post_data)
    raise Puppet::Error.new("Media #{resource[:name]} cannot be registered: #{error_message(r)}") unless success?(r)
  end

  def destroy
    r = request(:delete, "api/v2/media/#{id}")
    raise Puppet::Error.new("Media #{resource[:name]} cannot be removed: #{error_message(r)}") unless success?(r)
    @medium = nil
  end

  def path
    medium ? medium['path'] : nil
  end

  def path=(value)
    post_data = {:medium => {:path => value}}.to_json
    r = request(:put, "api/v2/media/#{id}", {}, post_data)
    raise Puppet::Error.new("Media #{resource[:name]} cannot be updated: #{error_message(r)}") unless success?(r)
  end

  def os_family
    medium ? medium['os_family'] : nil
  end

  def os_family=(value)
    post_data = {:medium => {:os_family => value}}.to_json
    r = request(:put, "api/v2/media/#{id}", {}, post_data)
    raise Puppet::Error.new("Media #{resource[:name]} cannot be updated: #{error_message(r)}") unless success?(r)
  end

  def operatingsystem_ids
    medium ? medium['operatingsystem_ids'] : nil
  end

  def operatingsystem_ids=(value)
    post_data = {:medium => {:operatingsystem_ids => value}}.to_json
    r = request(:put, "api/v2/media/#{id}", {}, post_data)
    raise Puppet::Error.new("Media #{resource[:name]} cannot be updated: #{error_message(r)}") unless success?(r)
  end

  def refresh_features!
    r = request(:put, "api/v2/media/#{id}/refresh")
    raise Puppet::Error.new("Media #{resource[:name]} cannot be refreshed: #{error_message(r)}") unless success?(r)
  end
end
