class MessagesController < ApplicationController

  before_action :set_group, only: [:edit, :create]

  def index
    @messages = Messages.all
  end

  def new
    @message = Message.new
  end

  def create

    @message = Message.new(create_params)
    if @message.save
      redirect_to group_project_path(@message.group_id,@message.project_id), notice: '投稿完了しました'
    else
      @project = Project.find(params[:project_id])
      render template: 'projects/show' ,notice: '投稿できませんでした'
    end
  end

  def edit
    @message = Message.find(params[:group_id])
  end

  def update
    @message = Message.new(create_params)
    if @message.save
      redirect_to groups_path(@group), notice: '編集完了です'
    else
      render gruop_edit_path(@gruop), notice: '不備があります、やり直してください'
    end

  end

  private
  def create_params
    params.require(:message).permit(:content).merge(user_id: current_user.id, group_id: params[:group_id],project_id: params[:project_id])
  end

  def set_group
    @group = Group.new(id: params[:group_id])
  end
end
