class ProjectsController < ApplicationController

  def index
    @projects = current_user.projects

    authorize! :read, Project
  end

  def new
    @project = Project.new

    authorize! :create, Project
  end

  def edit
    @project = Project.friendly.find(params[:id])

    authorize! :update, @project
  end

  def show
    @project = Project.friendly.find(params[:id])

    authorize! :read, @project
  end

  def create
    @project = Project.new create_project_params

    authorize! :create, Project

    if @project.save
      flash[:success] = 'Projeto criado com sucesso.'
      redirect_to projects_path
    else
      flash.now[:error] = 'Não foi possível criar o projeto, verifique o formulário e tente novamente.'
      render :new
    end
  end

  def update
    @project = Project.friendly.find(params[:id])

    authorize! :update, @project

    if @project.update_attributes update_project_params
      flash[:success] = 'Projeto atualizado com sucesso.'
      redirect_to projects_path
    else
      flash.now[:error] = 'Não foi possível atualizar o projeto, verifique o formulário e tente novamente.'
      render :edit
    end
  end

  def destroy
    @project = Project.friendly.find(params[:id])

    authorize! :delete, @project

    @project.destroy
    flash[:success] = 'Projeto excluído com sucesso.'
    redirect_to projects_path
  end

  private

  def create_project_params
    params.require(:project).permit(:name, :acronyms, :description, :conclusion_date,
                                    :email, :site).merge(
                                      profiles_attributes: [{ role: :owner, user: current_user}]
                                    )
  end

  def update_project_params
    params.require(:project).permit(:name, :acronyms, :description, :conclusion_date,
                                    :email, :site)
  end
end
