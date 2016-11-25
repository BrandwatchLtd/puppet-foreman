Puppet::Type.newtype(:foreman_media) do
  desc 'foreman_media registers a media in foreman.'

  ensurable

  newparam(:name, :namevar => true) do
    desc 'The name of the medium.'
    isrequired
  end

  newparam(:base_url) do
    desc 'Foreman\'s base url.'
  end

  newparam(:effective_user) do
    desc 'Foreman\'s effective user for the registration (usually admin).'
    defaultto 'admin'
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

  newproperty(:path) do
    desc 'The path of the medium'
    isrequired
    newvalues(URI.regexp)
  end

  newproperty(:os_family) do
    desc 'The os family of the medium'
  end

  newproperty(:operatingsystem_ids) do
    desc 'The operatingsystem ids of the medium'
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
