Puppet::Type.newtype(:foreman_domains) do
  desc 'foreman_domains registers a domains in foreman.'

  ensurable

  newparam(:name, :namevar => true) do
    desc 'The name of the domain.'
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

  newproperty(:fullname) do
    desc 'The description of the domain'
    isrequired
    newvalues(URI.regexp)
  end

  newproperty(:dns_id) do
    desc 'The dns proxy to use within the domain'
  end

  newproperty(:domain_parameters_attributes) do
    desc 'Array of domain parameter attributes of the domain'
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
      debug 'Skipping refresh; domain is not registered'
    end
  end

end
