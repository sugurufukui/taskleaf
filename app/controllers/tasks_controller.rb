class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.recent
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)

    if params[:back].present?
      render :new, status: :unprocessable_entity
      return
    end

    if @task.save
      redirect_to root_url, notice: "タスク「#{@task.name}」を登録しました。"
      #上記と同義
      # flash[:notice] = "タスク「#{@task.name}」を登録しました"
      # redirect_to tasls_url
    else
      render  :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @task.update(task_params)
    redirect_to root_url, notice: "タスク「#{@task.name}」を更新しました。"
  end

  def destroy
    task.destroy
    redirect_to root_url, notice: "タスク「#{task.name}」を削除しました。", status: :see_other
  end

  def confirm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end

    private

    def task_params
      params.require(:task).permit(:name, :description)
    end

    def set_task
      @task = current_user.tasks.find(params[:id])
    end
end
