require 'puppet/provider/package'

Puppet::Type.type(:package).provide :freebsdcheck, :parent => :freebsd do
  include Puppet::Util::Execution

  desc "Only checks for presence/absence of packages. All package modifications must be done manually."
  
  commands :pkginfo => "/usr/sbin/pkg_info"

  def self.parse_pkg_string(pkg_string)
    {
      :pkg_name => pkg_string.split("-").slice(0..-2).join("-"),
      :pkg_version => pkg_string.split("-")[-1],
    }
  end

  def self.instances
    packages = []
    output = pkginfo "-aoQ"
    output.split("\n").each do |data|
      pkg_string, pkg_origin = data.split(":")
      pkg_info = self.parse_pkg_string(pkg_string)

      packages << new({
        :provider => self.name,
        :name     => pkg_info[:pkg_name],
      })
    end
    packages
  end

  def query
    self.class.instances.each do |provider|
      if provider.name == @resource.name
        return provider.properties
      end
    end
    nil
  end

  def install
    raise Puppet::Error, "Install %s manually" % @resource[:name]
  end

  def uninstall
    raise Puppet::Error, "Uninstall %s manually" % @resource[:name]
  end

end
