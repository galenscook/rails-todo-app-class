class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(created_at: :asc)
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to root_path
    else
      @tasks = Task.all.order(created_at: :asc)
      flash.now[:error] = 'your description needs to be at least six characters'
      render 'index'
    end

  end

  def update
    task = Task.find(params[:id])
    task.update(completed: !task.completed)
    redirect_to root_path
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to root_path
  end

  def active
    @tasks = Task.active.order(created_at: :asc)
    @task = Task.new
    render 'index'
  end

  def completed
    @tasks = Task.completed.order(created_at: :asc)
    @task = Task.new
    render 'index'
  end

  private
    def task_params
      params.require(:task).permit(:description, :completed)
    end
end
