
class Note
  DEFAULT_TYPE = 'task'

  def initialize(text:'', type:DEFAULT_TYPE)
    @text = text
    @type = type
  end

  def serialize
    { 'text' => @text, 'type' => type }
  end

  private

  def type
    return DEFAULT_TYPE if no_type?

    @type
  end

  def no_type?
    @type.nil? || @type.empty?
  end
end
