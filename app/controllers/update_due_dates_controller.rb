class UpdateDueDatesController < ApplicationController
  before_filter :find_project_by_project_id
  before_filter :authorize

  def show
    @update_due_date = UpdateDueDate.where(project_id: @project.id).first
    @settings = Setting.plugin_redmine_auto_due_date
  end

  def new
    @update_due_date = UpdateDueDate.new(project_id: @project.id)
  end

  def create
    params[:update_due_date][:project_id] = @project.id

    @update_due_date = UpdateDueDate.new(update_due_date_params)

    if @update_due_date.save
      flash[:notice] = l(:update_due_date_updated, scope: :auto_due_date)

      redirect_to project_update_due_date_path(@project)
    else
      render('new')
    end
  end

  def edit
    @update_due_date = UpdateDueDate.where(project_id: @project.id).first
  end

  def update
    @update_due_date = UpdateDueDate.where(project_id: @project.id).first

    if @update_due_date.update_attributes(update_due_date_params)
      flash[:notice] = l(:update_due_date_updated, scope: :auto_due_date)

      redirect_to project_update_due_date_path(@project)
    else
      render('edit')
    end
  end

  def destroy
    @update_due_date = UpdateDueDate.where(project_id: @project.id).first

    @update_due_date.destroy

    flash[:notice] = l(:update_due_date_deleted, scope: :auto_due_date)

    redirect_to project_update_due_date_path
  end

  private

  def update_due_date_params
    params.require(:update_due_date).permit(:days, :project_id)
  end
end