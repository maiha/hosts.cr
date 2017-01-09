class Hosts
  record Host, addr : String, names : Set(String)

  def initialize(path = "/etc/hosts")
    name2addr = Hash(String, Set(String)).new
    addr2name = Hash(String, Set(String)).new
    @name2host = Hash(String, Host).new
    @addr2host = Hash(String, Host).new

    File.open(path).each_line do |line|
      line = line.sub(/#.*/, "")
      next if line.empty?
      names = line.split(/\s+/)
      addr = names.shift || next
      addr2name[addr] = Set(String).new if !addr2name.has_key?(addr)
      names.each {|n| addr2name[addr] << n }
    end

    addr2name.each do |addr, names|
      host = Host.new(addr, names)
      @addr2host[addr] = host
      names.each do |name|
        @name2host[name] = host
      end
    end
  end

  def [](key : String)
    table(key)[key]
  end

  def []?(key : String)
    table(key)[key]?
  end

  def name?(key : String)
    self[key]?.try(&.names.first)
  end

  private def table(key : String)
    case key
    when /^\d{1,3}(\.\d{1,3}){3}$/
      @addr2host
    else
      @name2host
    end
  end
end
