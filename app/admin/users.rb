ActiveAdmin.register User do
  menu priority: 3

  permit_params :email, :password, :password_confirmation, permission_ids: []

  filter :email_cont, label: 'Email'

  form do |f|
    f.inputs do
      f.input :email, input_html: { disabled: :disabled }
    end

    f.inputs 'Permissões para Projetos' do
      f.input :permissions, as: :check_boxes, collection: Permission.project_actions.map { |p| [p.decorate.action, p.id] }
    end

    f.actions
  end

  index do
    column :email
    column :created_at
    column :updated_at

    actions
  end
end
