require_relative '../infrastructure/moment'
require_relative '../infrastructure/random'

class Note
  DEFAULT_TYPE = 'task'
  UNDONE_DATE = ''

  def self.from(document)
    new(
      text: document['text'],
      type: document['type'],
      created_at: document['created_at'],
      due_date: document['due_date'],
      id: document['id'],
      done_date: document['done_date']
    )
  end

  def initialize(text:'', type:DEFAULT_TYPE, created_at:'', due_date:'', id:'', done_date:'')
    @text = text
    @type = type
    @created_at = created_at
    @due_date = due_date
    @id = id
    @done_date = done_date
  end

  def mark_as_done
    @done_date = new_date
  end

  def mark_as_undone
    @done_date = UNDONE_DATE
  end

  def new_text(new_text='')
    return if no_attribute?(new_text)

    @text = new_text
  end

  def new_due_date(new_due_date='')
    return if no_attribute?(new_due_date)

    @due_date = new_due_date
  end

  def new_type(new_type='')
    return if no_attribute?(new_type)

    @type = new_type
  end

  def serialize
    {
      'id' => id,
      'text' => @text,
      'type' => type,
      'created_at' => created_at,
      'due_date' => @due_date,
      'done_date' => @done_date
    }
  end

  private

  def id
    return new_id if no_id?

    @id
  end

  def no_attribute?(attribute)
    attribute.nil? || attribute.empty?
  end

  def new_id
    Infrastructure::Random.id
  end

  def no_id?
    @id.nil? || @id.empty?
  end

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
