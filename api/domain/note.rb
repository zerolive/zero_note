require_relative '../infrastructure/moment'

class Note
  DEFAULT_TYPE = 'task'

  def initialize(text:'', type:DEFAULT_TYPE, created_at:'', due_date:'')
    @text = text
    @type = type
    @created_at = created_at
    @due_date = due_date
  end

  def serialize
    {
      'text' => @text,
      'type' => type,
      'created_at' => created_at,
      'due_date' => @due_date
    }
  end

  private

  def created_at
    return new_date if no_date?

    @created_at
  end

  def new_date
    Infrastructure::Moment.today
  end

  def type
    return DEFAULT_TYPE if no_type?

    @type
  end

  def no_date?
    @created_at.nil? || @created_at.empty?
  end

  def no_type?
    @type.nil? || @type.empty?
  end
end
