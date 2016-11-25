Puppet::Type.type(:foreman_operatingsystems).provide(:rest_v3, :parent => Puppet::Type.type(:foreman_resource).provider(:rest_v3)) do
  confine :feature => [:json, :oauth]

  def operatingsystem
    @operatingsystem ||= begin
      r = request(:get, 'api/v2/operatingsystems', :search => %{name="#{resource[:name]}"})
      raise Puppet::Error.new("Operating System #{resource[:name]} cannot be retrieved: #{error_message(r)}") unless success?(r)
      JSON.load(r.body)['results'][0]
    end
  end

  def id
    operatingsystem ? operatingsystem['id'] : nil
  end

  def exists?
    !id.nil?
  end

  def create
    post_data = {:operatingsystem => {:name => resource[:name],
                                      :architectures => resource[:architectures],
                                      :config_templates => resource[:config_templates],
                                      :family => resource[:family],
                                      :images => resource[:images],
                                      :major => resource[:major],
                                      :media => resource[:media],
                                      :minor => resource[:minor],
                                      :os_default_templates => resource[:os_default_templates],
                                      :parameters => resource[:parameters],
                                      :password_hash => resource[:password_hash],
                                      :provisioning_templates => resource[:provisioning_templates],
                                      :ptables => resource[:ptables],
                                      :release_name => resource[:release_name],
                                      :title => resource[:title]}}.to_json
    r = request(:post, 'api/v2/operatingsystems', {}, post_data)
    raise Puppet::Error.new("Operating System #{resource[:name]} cannot be registered: #{error_message(r)}") unless success?(r)
  end

  def destroy
    r = request(:delete, "api/v2/operatingsystems/#{id}")
    raise Puppet::Error.new("Operating System #{resource[:name]} cannot be removed: #{error_message(r)}") unless success?(r)
    @operatingsystem = nil
  end

  #
  def architectures
    operatingsystem ? operatingsystem['architectures'] : nil
  end

  def architectures=(value)
    post_data = {:operatingsystem => {:architectures => value}}.to_json
    r = request(:put, "api/v2/operatingsystems/#{id}", {}, post_data)
    raise Puppet::Error.new("Operating System #{resource[:name]} cannot be updated: #{error_message(r)}") unless success?(r)
  end

  #
  def config_templates
    operatingsystem ? operatingsystem['config_templates'] : nil
  end

  def config_templates=(value)
    post_data = {:operatingsystem => {:config_templates => value}}.to_json
    r = request(:put, "api/v2/operatingsystems/#{id}", {}, post_data)
    raise Puppet::Error.new("Operating System #{resource[:name]} cannot be updated: #{error_message(r)}") unless success?(r)
  end

  #
  def family
    operatingsystem ? operatingsystem['family'] : nil
  end

  def family=(value)
    post_data = {:operatingsystem => {:family => value}}.to_json
    r = request(:put, "api/v2/operatingsystems/#{id}", {}, post_data)
    raise Puppet::Error.new("Operating System #{resource[:name]} cannot be updated: #{error_message(r)}") unless success?(r)
  end

  #
  def images
    operatingsystem ? operatingsystem['images'] : nil
  end

  def images=(value)
    post_data = {:operatingsystem => {:images => value}}.to_json
    r = request(:put, "api/v2/operatingsystems/#{id}", {}, post_data)
    raise Puppet::Error.new("Operating System #{resource[:name]} cannot be updated: #{error_message(r)}") unless success?(r)
  end

  #
  def major
    operatingsystem ? operatingsystem['major'] : nil
  end

  def major=(value)
    post_data = {:operatingsystem => {:major => value}}.to_json
    r = request(:put, "api/v2/operatingsystems/#{id}", {}, post_data)
    raise Puppet::Error.new("Operating System #{resource[:name]} cannot be updated: #{error_message(r)}") unless success?(r)
  end

  #
  def media
    operatingsystem ? operatingsystem['media'] : nil
  end

  def media=(value)
    post_data = {:operatingsystem => {:media => value}}.to_json
    r = request(:put, "api/v2/operatingsystems/#{id}", {}, post_data)
    raise Puppet::Error.new("Operating System #{resource[:name]} cannot be updated: #{error_message(r)}") unless success?(r)
  end

  #
  def minor
    operatingsystem ? operatingsystem['minor'] : nil
  end

  def minor=(value)
    post_data = {:operatingsystem => {:minor => value}}.to_json
    r = request(:put, "api/v2/operatingsystems/#{id}", {}, post_data)
    raise Puppet::Error.new("Operating System #{resource[:name]} cannot be updated: #{error_message(r)}") unless success?(r)
  end

  #
  def os_default_templates
    operatingsystem ? operatingsystem['os_default_templates'] : nil
  end

  def os_default_templates=(value)
    post_data = {:operatingsystem => {:os_default_templates => value}}.to_json
    r = request(:put, "api/v2/operatingsystems/#{id}", {}, post_data)
    raise Puppet::Error.new("Operating System #{resource[:name]} cannot be updated: #{error_message(r)}") unless success?(r)
  end

  #
  def parameters
    operatingsystem ? operatingsystem['parameters'] : nil
  end

  def parameters=(value)
    post_data = {:operatingsystem => {:parameters => value}}.to_json
    r = request(:put, "api/v2/operatingsystems/#{id}", {}, post_data)
    raise Puppet::Error.new("Operating System #{resource[:name]} cannot be updated: #{error_message(r)}") unless success?(r)
  end

  #
  def password_hash
    operatingsystem ? operatingsystem['password_hash'] : nil
  end

  def password_hash=(value)
    post_data = {:operatingsystem => {:password_hash => value}}.to_json
    r = request(:put, "api/v2/operatingsystems/#{id}", {}, post_data)
    raise Puppet::Error.new("Operating System #{resource[:name]} cannot be updated: #{error_message(r)}") unless success?(r)
  end

  #
  def provisioning_templates
    operatingsystem ? operatingsystem['provisioning_templates'] : nil
  end

  def provisioning_templates=(value)
    post_data = {:operatingsystem => {:provisioning_templates => value}}.to_json
    r = request(:put, "api/v2/operatingsystems/#{id}", {}, post_data)
    raise Puppet::Error.new("Operating System #{resource[:name]} cannot be updated: #{error_message(r)}") unless success?(r)
  end

  #
  def ptables
    operatingsystem ? operatingsystem['ptables'] : nil
  end

  def ptables=(value)
    post_data = {:operatingsystem => {:ptables => value}}.to_json
    r = request(:put, "api/v2/operatingsystems/#{id}", {}, post_data)
    raise Puppet::Error.new("Operating System #{resource[:name]} cannot be updated: #{error_message(r)}") unless success?(r)
  end

  #
  def release_name
    operatingsystem ? operatingsystem['release_name'] : nil
  end

  def release_name=(value)
    post_data = {:operatingsystem => {:release_name => value}}.to_json
    r = request(:put, "api/v2/operatingsystems/#{id}", {}, post_data)
    raise Puppet::Error.new("Operating System #{resource[:name]} cannot be updated: #{error_message(r)}") unless success?(r)
  end

  #
  def title
    operatingsystem ? operatingsystem['title'] : nil
  end

  def title=(value)
    post_data = {:operatingsystem => {:title => value}}.to_json
    r = request(:put, "api/v2/operatingsystems/#{id}", {}, post_data)
    raise Puppet::Error.new("Operating System #{resource[:name]} cannot be updated: #{error_message(r)}") unless success?(r)
  end

  def refresh_features!
    r = request(:put, "api/v2/operatingsystems/#{id}/refresh")
    raise Puppet::Error.new("Operating System #{resource[:name]} cannot be refreshed: #{error_message(r)}") unless success?(r)
  end
end
