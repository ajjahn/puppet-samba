require "delegate"

module Augeas
  class Change
    attr_reader :target, :name, :delimiter

    def initialize(target, name, value = nil, delimiter = "\"")
      @target = target
      @name = name
      @value = value
      @delimiter = delimiter
    end

    def to_s
      "#{action} #{delimiter}target[. = '#{target}']/#{name}#{delimiter}#{value}"
    end

    def hash
      [target, name, Change].hash
    end

    def ==(other)
      other.is_a?(self.class) && [other.target, other.name] == [target, name]
    end
    alias_method :eql?, :==

    private

    def action
      return "set" unless @value.nil?
      "rm "
    end

    def value
      " #{@value}" if @value
    end
  end

  class ChangeSet
    def initialize
      @set = []
    end

    def <<(change)
      index = @set.index(change) || @set.length
      @set[index] = change
    end

    def to_a
      changes
    end

    def changes
      @set.map(&:to_s)
    end
  end

  class TargetedChangeSet < DelegateClass(ChangeSet)
    def initialize(target)
      @target = target
      super(ChangeSet.new)
    end

    def with(*args)
      self << Change.new(@target, *args)
      self
    end
  end
end
