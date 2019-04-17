class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :check, only: :show

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find_by(params[:id])
    @projects = @group.projects
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    @group.users << current_user
    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group = Group.find_by(params[:id])
    @group.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end




  private

  def check
    @group = Group.find(params[:id])
    if @group.key.present? && params[:key].present?
      if @group.key != params[:key]
        render '/check'
      end
    elsif @group.key.present? && params[:key].blank?
      render '/check'
    else
    end
  end

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:key, :name, { user_ids: []})
  end
end
