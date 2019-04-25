class Projects::RequisitesController < ApplicationController
    def index
      @responsable_choice_form = Requisite::ResponsableChoiceForm.new({}, current_project)
      @requisites = current_project.requisites.order(created_at: :desc)
      @kanban_requisite_control = KanbanRequisiteControl.new(current_project)

      authorize! :read, Requisite
    end

    def new
      @requisite = Requisite.new

      authorize! :create, Requisite
    end

    def edit
      @requisite = Requisite.find params[:id]

      authorize! :update, @requisite
    end

    def show
      @requisite = Requisite.find params[:id]

      authorize! :read, @requisite
    end

    def create
      @requisite = Requisite.new create_requisite_params
      authorize! :create, Requisite

      if @requisite.save
        flash[:success] = 'Requisito criado com sucesso.'
        redirect_to project_requisites_path(current_user.current_project)
      else
        flash.now[:error] = 'Não foi possível criar o requisito, verifique o formulário e tente novamente.'
        render :new
      end
    end

    def update
      @requisite = Requisite.find params[:id]

      authorize! :update, @requisite
      if @requisite.update_attributes update_requisite_params
        flash[:success] = 'Requisito atualizado com sucesso.'
        redirect_to project_requisites_path(current_user.current_project)
      else
        flash.now[:error] = 'Não foi possível atualizar o requisito, verifique o formulário e tente novamente.'
        render :edit
      end
    end

    def destroy
      @requisite = Requisite.find params[:id]

      authorize! :delete, @requisite
      @requisite.destroy
      flash[:success] = 'Requisito excluído com sucesso.'
      redirect_to project_requisites_path(current_user.current_project)
    end

    private

    def current_project
      current_user.current_project
    end

    def create_requisite_params
      params.require(:requisite).permit(:slg, :kind, :title, :description,
                                        :priority).merge(author: current_user,
                                                      project: current_project)
    end

    def update_requisite_params
      params.require(:requisite).permit(:slg, :kind, :title, :description,
                                        :priority)
    end
end
