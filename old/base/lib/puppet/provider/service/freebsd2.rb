Puppet::Type.type(:service).provide :freebsd2, :parent => :init do

  desc "Provider for FreeBSD. Makes use of rcvar argument of init scripts and parses/edits rc files."

  confine :operatingsystem => [:freebsd]

  RCCONF = '/etc/rc.conf'
  RCCONF_LOCAL = '/etc/rc.conf.local'
  RCCONF_DIR = '/etc/rc.conf.d'

  def self.defpath
    superclass.defpath
  end

  # Executing an init script with the 'rcvar' argument returns
  # the service name, rcvar name and whether it's enabled/disabled
  def rcvar
    rcvar = execute([self.initscript, :rcvar], :failonfail => true, :squelch => false)
    rcvar = rcvar.split("\n")
    return rcvar
  end

  # Extract service name
  def service_name
    name = self.rcvar[0]
    self.fail("No service name found in rcvar") if name.nil?
    name = name.gsub!(/# (.*)/, '\1')
    self.fail("Service name is empty") if name.nil?
    self.debug("Service name is #{name}")
    return name
  end

  # Extract rcvar name
  def rcvar_name
    name = self.rcvar[2]
    self.fail("No rcvar name found in rcvar") if name.nil?
    name = name.gsub!(/(.*)_enable=(.*)/, '\1')
    self.fail("rcvar name is empty") if name.nil?
    self.debug("rcvar name is #{name}")
    return name
  end

  # Extract rcvar value
  def rcvar_value
    value = self.rcvar[2]
    self.fail("No rcvar value found in rcvar") if value.nil?
    value = value.gsub!(/(.*)_enable=\"(.*)\"/, '\2')
    self.fail("rcvar value is empty") if value.nil?
    self.debug("rcvar value is #{value}")
    return value
  end

  # Edit rc files and set the service to yes/no
  def rc_edit(yesno)
    service = self.service_name
    rcvar = self.rcvar_name
    self.debug("Editing rc files: setting #{rcvar} to #{yesno} for #{service}")
    if not self.rc_replace(service, rcvar, yesno)
      self.rc_add(service, rcvar, yesno)
    end
  end

  # Try to find an existing setting in the rc files 
  # and replace the value
  def rc_replace(service, rcvar, yesno)
    success = false
    # Replace in all files, not just in the first found with a match
    [RCCONF, RCCONF_LOCAL, RCCONF_DIR + "/#{service}"].each do |filename|
      if File.exists?(filename)
        s = File.read(filename)
        if s.gsub!(/(#{rcvar}_enable)=\"?(YES|NO)\"?/, "\\1=\"#{yesno}\"")
          File.open(filename, File::WRONLY) { |f| f << s }
          self.debug("Replaced in #{filename}")
          success = true
        end
      end
    end
    return success
  end

  # Add a new setting to the rc files
  def rc_add(service, rcvar, yesno)
    append = "\n\# Added by Puppet\n#{rcvar}_enable=\"#{yesno}\""
    # First, try the one-file-per-service style
    if File.exists?(RCCONF_DIR)
      File.open(RCCONF_DIR + "/#{service}", File::WRONLY | File::APPEND | File::CREAT, 0644) {
        |f| f << append
        self.debug("Appended to #{f.path}")
      }
    else
      # Else, check the local rc file first, but don't create it
      if File.exists?(RCCONF_LOCAL)
        File.open(RCCONF_LOCAL, File::WRONLY | File::APPEND) {
          |f| f << append
          self.debug("Appended to #{f.path}")
        }
      else
        # At last use the standard rc.conf file
        File.open(RCCONF, File::WRONLY | File::APPEND | File::CREAT, 0644) {
          |f| f << append
          self.debug("Appended to #{f.path}")
        }
      end
    end
  end

  def enabled?
    if /YES$/ =~ self.rcvar_value then
      self.debug("Is enabled")
      return :true
    end
    self.debug("Is disabled")
    return :false
  end

  def enable
    self.debug("Enabling")
    self.rc_edit("YES")
  end

  def disable
    self.debug("Disabling")
    self.rc_edit("NO")
  end

  def startcmd
    [self.initscript, :onestart]
  end

  def stopcmd
    [self.initscript, :onestop]
  end

  def statuscmd
    [self.initscript, :onestatus]
  end

end
