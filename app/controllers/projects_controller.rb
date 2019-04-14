class ProjectsController < ApplicationController

def index
    @projects = Project.all
  end

  def show
    @project = Project.find_by(id: params[:id])
    @message = @project.messages.build
    @messages = @project.messages
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(project_params)
    respond_to do |format|
      if @project.save
        format.html { redirect_to group_path(params[:group_id]), notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @project = Project.find_by(params[:id])
    respond_to do |format|
      if @project.update(project_params) && @project.video.recreate_versions!
        format.html { redirect_to group_project_url(@project.group_id, @project.id), notice: 'project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def pay
    Payjp.api_key = 'sk_test_dc189ea51b0a5fd7341509b9'
    charge = Payjp::Charge.create(
    :amount => 3500,
    :card => params['payjp-token'],
    :currency => 'jpy',
    )
  end

  def pay_card
    Payjp.api_key = 'sk_test_dc189ea51b0a5fd7341509b9'
    charge = Payjp::Charge.create(
    amount: params[:cost],
    card:  current_user.payjp_id,
    currency: 'jpy',
)
  end

  private
  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :video,:content).merge(user_id: current_user.id, group_id: params[:group_id])
  end
end
