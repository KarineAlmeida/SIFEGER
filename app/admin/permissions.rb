ActiveAdmin.register Permission do
  menu priority: 4

  permit_params :entity, :action

  filter :action, as: :select, collection: I18n.t('views.permission.actions').invert
  filter :entity, as: :select, collection: I18n.t('views.permission.entities').invert
  filter :created_at

  index do
    column :action do |permission|
      permission.decorate.action
    end
    column :entity do |permission|
      permission.decorate.entity
    end
    column :created_at
  end
end
