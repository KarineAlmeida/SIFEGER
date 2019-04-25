class Projects::Requisites::VersionsController < ApplicationController

    def index
      @versions = requisite.requisite_versions.order('requisite_versions.created_at desc')

      authorize! :read, requisite
    end


    def new
      @form = RequisiteVersionForm.new(requisite, requisite.slice(:title, :slg, :description, :kind, :priority))

      authorize! :create, Requisite
    end

    def create
      @form = RequisiteVersionForm.new(requisite, version_params)

      authorize! :create, Requisite
      if @form.save!
        flash[:success] = 'Requisito atualizado com sucesso.'
        redirect_to project_requisite_versions_path(project, requisite)
      else
        flash.now[:error] = 'Não foi possível atualizar o requisito, verifique o formulário e tente novamente.'
        render :new
      end
    end

    private

    def version_params
      params.require(:requisite_version_form).permit(:slg, :kind, :title, :description, :priority)
    end

    def project
      Project.friendly.find(params[:project_id])
    end

    def requisite
      project.requisites.find(params[:requisite_id])
    end

end
