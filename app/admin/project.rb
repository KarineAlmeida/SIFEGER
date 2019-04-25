ActiveAdmin.register Project do
  menu priority: 2

  permit_params :name

  filter :name_cont, label: 'Name'
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
    end

    f.actions
  end

  index do
    column :name
    column :created_at
    column :updated_at

    actions
  end
end
