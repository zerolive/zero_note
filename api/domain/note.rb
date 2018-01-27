
class Note
  def initialize(text:'', type:'')
    @text = text
    @type = type
  end

  def serialize
    { 'text' => @text, 'type' => @type }
  end
end
