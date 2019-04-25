class RequisiteComparation
  PARAMS_TO_CHECK = %w[title slg description kind priority]

  attr_reader :old_requisite, :new_requisite, :changes

  def self.check(old_requisite, new_requisite)
    new(old_requisite, new_requisite)
  end

  def initialize(old_requisite, new_requisite)
    @changes       = { kind: :attribute_change, changes: {} }
    @old_requisite = old_requisite
    @new_requisite = new_requisite
    check
  end

  private

  def check
    PARAMS_TO_CHECK.each do |param|
      old_value           = old_requisite.send(param)
      new_value           = new_requisite.send(param) || 'vazio'
      decorated_old_value = old_requisite.decorate.send(param)
      decorated_new_value = new_requisite.decorate.send(param) || 'Vazio'
      croped_old_value    = crop_text(decorated_old_value)
      croped_new_value    = crop_text(decorated_new_value)

      if(old_value != new_value)
        self.changes[:changes][param] = "O valor do attributo <strong class='attribute'>#{translate_attribute(param)}</strong> mudou de <strong data-full-text='#{decorated_old_value}'>#{croped_old_value}</strong> para <strong data-full-text='#{decorated_new_value}'>#{croped_new_value}</strong>"
      end
    end

    @changes
  end

  def crop_text(value)
    return value if value.length < 30
    value[0..30] + '...'
  end

  def translate_attribute(attribute)
    I18n.t("activerecord.attributes.requisite.#{attribute}")
  end

end
