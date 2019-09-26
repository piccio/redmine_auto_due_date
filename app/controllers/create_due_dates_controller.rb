class CreateDueDatesController < ApplicationController
  before_action :find_project_by_project_id
  before_action :authorize

  def show
    @create_due_date = CreateDueDate.where(project_id: @project.id).first
    @settings = Setting.plugin_redmine_auto_due_date
  end

  def new
    @create_due_date = CreateDueDate.new(project_id: @project.id)
  end

  def create
    params[:create_due_date][:project_id] = @project.id

    @create_due_date = CreateDueDate.new(create_due_date_params)

    if @create_due_date.save
      flash[:notice] = l(:create_due_date_created, scope: :auto_due_date)

      redirect_to project_create_due_date_path(@project)
    else
      render('new')
    end
  end

  def edit
    @create_due_date = CreateDueDate.where(project_id: @project.id).first
  end

  def update
    @create_due_date = CreateDueDate.where(project_id: @project.id).first

    if @create_due_date.update_attributes(create_due_date_params)
      flash[:notice] = l(:create_due_date_updated, scope: :auto_due_date)

      redirect_to project_create_due_date_path(@project)
    else
      render('edit')
    end
  end

  def destroy
    @create_due_date = CreateDueDate.where(project_id: @project.id).first

    @create_due_date.destroy

    flash[:notice] = l(:create_due_date_deleted, scope: :auto_due_date)

    redirect_to project_create_due_date_path
  end

  private

  def create_due_date_params
    params.require(:create_due_date).permit(:days, :project_id)
  end
end