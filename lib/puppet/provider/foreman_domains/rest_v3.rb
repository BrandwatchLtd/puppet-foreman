Puppet::Type.type(:foreman_domains).provide(:rest_v3, :parent => Puppet::Type.type(:foreman_resource).provider(:rest_v3)) do
  confine :feature => [:json, :oauth]

  def domain
    @domain ||= begin
      r = request(:get, 'api/v2/domains', :search => %{name="#{resource[:name]}"})
      raise Puppet::Error.new("Domain #{resource[:name]} cannot be retrieved: #{error_message(r)}") unless success?(r)
      JSON.load(r.body)['results'][0]
    end
  end

  def id
    domain ? domain['id'] : nil
  end

  def exists?
    !id.nil?
  end

  def create
    post_data = {:domain => {:name => resource[:name], :fullname => resource[:fullname], :dns_id => resource[:dns_id], :domain_parameters_attributes => resource[:domain_parameters_attributes]}}.to_json
    r = request(:post, 'api/v2/domains', {}, post_data)
    raise Puppet::Error.new("Domain #{resource[:name]} cannot be registered: #{error_message(r)}") unless success?(r)
  end

  def destroy
    r = request(:delete, "api/v2/domains/#{id}")
    raise Puppet::Error.new("Domain #{resource[:name]} cannot be removed: #{error_message(r)}") unless success?(r)
    @domain = nil
  end

  def fullname
    domain ? domain['fullname'] : nil
  end

  def fullname=(value)
    post_data = {:domain => {:fullname => value}}.to_json
    r = request(:put, "api/v2/domains/#{id}", {}, post_data)
    raise Puppet::Error.new("Domain #{resource[:name]} cannot be updated: #{error_message(r)}") unless success?(r)
  end

  def dns_id
    domain ? domain['dns_id'] : nil
  end

  def dns_id=(value)
    post_data = {:domain => {:dns_id => value}}.to_json
    r = request(:put, "api/v2/domains/#{id}", {}, post_data)
    raise Puppet::Error.new("Domain #{resource[:name]} cannot be updated: #{error_message(r)}") unless success?(r)
  end

  def domain_parameters_attributes
    domain ? domain['domain_parameters_attributes'] : nil
  end

  def domain_parameters_attributes=(value)
    post_data = {:domain => {:domain_parameters_attributes => value}}.to_json
    r = request(:put, "api/v2/domains/#{id}", {}, post_data)
    raise Puppet::Error.new("Domain #{resource[:name]} cannot be updated: #{error_message(r)}") unless success?(r)
  end

  def refresh_features!
    r = request(:put, "api/v2/domains/#{id}/refresh")
    raise Puppet::Error.new("Domain #{resource[:name]} cannot be refreshed: #{error_message(r)}") unless success?(r)
  end
end
