class Projects::Requisites::StatusesController < ApplicationController
  def update
    requisite = Requisite.find params[:requisite_id]

    authorize! :update_status, requisite
    requisite.send "to_#{params[:status]}!"
    flash[:success] = 'Status alterado com successo.'
  end
end
