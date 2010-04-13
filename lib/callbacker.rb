class Callbacker
  attr_accessor :hook, :block, :method_chain, :termination_methods, :termination_methods_reversed

  SUPPRESSED_METHODS = [:to_s, :inspect]

  DEFAULT_TERMINATING_METHODS = [:to_s, :inspect, :class]

  def initialize(_hook, _block, options={})
    self.hook = _hook
    self.block = _block
    self.method_chain = []
    self.termination_methods = options.delete(:termination_methods) || []
    self.termination_methods.collect!{|method| method.to_sym}
    self.termination_methods_reversed = options[:reverse].nil? ? false : options[:reverse]
  end

  SUPPRESSED_METHODS.each do |method_name|
    define_method method_name do |*args, &block|
      self.method_missing(method_name, *args, &block)
    end
  end

  def method_missing(method_name, *args, &block)
    if terminating_method?(method_name)
      return self.run.send method_name, *args, &block
    else
      self.add_to_method_chain(method_name, args, block)
      return self
    end
  end

  def terminating_method?(method_name)
    if self.termination_methods_reversed
      return (!self.termination_methods.include?(method_name.to_sym) or DEFAULT_TERMINATING_METHODS.include?(method_name.to_sym))
    else
      return (DEFAULT_TERMINATING_METHODS + self.termination_methods).include?(method_name.to_sym)
    end
  end

  def add_to_method_chain(method_name, args, block)
    self.method_chain << [method_name, args, block]
  end

  def run
    result = self.hook
#puts "RUNNING: #{self.method_chain.inspect}"
    self.method_chain.each do |method_name, args, block|
#puts "current result: #{result.inspect}, calling #{method_name.inspect}"
      result = result.send method_name, *args, &block
    end
    self.block.call(result) unless self.block.nil?
    return result
  end
end
