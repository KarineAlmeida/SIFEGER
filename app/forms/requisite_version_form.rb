class RequisiteVersionForm < BaseForm
  attr_reader :title, :slg, :description, :kind, :author, :priority, :requisite

  validates :title, :slg, :description, :kind, :priority, presence: true

  def initialize(requisite, args={})
    @requisite   = requisite
    @title       = args['title']
    @slg         = args['slg']
    @description = args['description']
    @kind        = args['kind']
    @priority    = args['priority']
  end

  def url
    routes.project_requisite_versions_path(@requisite.project, @requisite)
  end

  def save!
    return unless valid?

    ActiveRecord::Base.transaction do
      new_requisite = Requisite.new requisite_params
      changes = RequisiteComparation.check(@requisite, new_requisite).changes

      if changes[:changes].any?
        @requisite.update! requisite_params

        log = RequisiteLog.create title: 'Alteração na definição do requisito.', version_changes: changes
        @requisite.requisite_versions.create! object: @requisite.reload.attributes, requisite_log: log, kind: :attribute_change

        if changes[:changes].keys.include? 'description'
          @requisite.to_propose!
        end

        true
      else
        true
      end
    end
  end

  private

  def requisite_params
    {
      title:            @title,
      slg:              @slg,
      description:      @description,
      kind:             @kind,
      priority:         @priority
    }
  end
end
