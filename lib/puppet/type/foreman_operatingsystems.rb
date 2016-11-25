Puppet::Type.newtype(:foreman_operatingsystems) do
  desc 'foreman_operatingsystems registers an operatingsystem in foreman.'

  ensurable

  newparam(:name, :namevar => true) do
    desc 'The name of the medium.'
  end

  newparam(:base_url) do
    desc 'Foreman\'s base url.'
  end

  newparam(:effective_user) do
    desc 'Foreman\'s effective user for the registration (usually admin).'
  end

  newparam(:consumer_key) do
    desc 'Foreman oauth consumer_key'
  end

  newparam(:consumer_secret) do
    desc 'Foreman oauth consumer_secret'
  end

  newparam(:ssl_ca) do
    desc 'Foreman SSL CA (certificate authority) for verification'
  end

  # operatingsystem specific
  newproperty(:architectures, :array_matching => :all) do
    desc 'Array of architectures for this os'
    defaultto [{"name" => "x86_64"}]
  end 

  newproperty(:config_templates, :array_matching => :all) do
    desc 'Array of config templates for this os'
  end 

  newproperty(:description) do
    desc 'The description of the os'
    defaultto { @resource[:name] }
  end

  newproperty(:family) do
    desc 'The family of the os'
  end

  newproperty(:images, :array_matching => :all) do
    desc 'Array of images for this os'
  end 

  newproperty(:major) do
    desc 'The major relase number of os'
  end

  newproperty(:media, :array_matching => :all) do
    desc 'Array of media for this os'
  end 

  newproperty(:minor) do
    desc 'The minor relase number of os'
  end

  newproperty(:os_default_templates, :array_matching => :all) do
    desc 'Array of default templates for this os'
  end 

  newproperty(:parameters, :array_matching => :all) do
    desc 'Array of parameters for this os'
  end 

  newproperty(:password_hash) do
    desc 'The password hash alg user in this os'
    defaultto "SHA256"
  end

  newproperty(:provisioning_templates, :array_matching => :all) do
    desc 'Array of provisioning templates for this os'
  end 

  newproperty(:ptables, :array_matching => :all) do
    desc 'Array of ptables for this os'
  end 

  newproperty(:release_name) do
    desc 'The release name for this os'
  end

  newproperty(:title) do
    desc 'The title name for this os'
    defaultto { @resource[:name] }
  end

  newparam(:timeout) do
    desc "Timeout for HTTP(s) requests"

    munge do |value|
      value = value.shift if value.is_a?(Array)
      begin
        value = Integer(value)
      rescue ArgumentError
        raise ArgumentError, "The timeout must be a number.", $!.backtrace
      end
      [value, 0].max
    end

    defaultto 500
  end

  def refresh
    if @parameters[:ensure].retrieve == :present
      provider.refresh_features! if provider.respond_to?(:refresh_features!)
    else
      debug 'Skipping refresh; medium is not registered'
    end
  end

end
