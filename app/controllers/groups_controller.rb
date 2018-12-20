class GroupsController < ApplicationController
  before_action :require_godmother
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :align_person_state, only: [:edit, :new]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
    @mentors = Person.where(role: 2).where(state: 3)
  end

  # GET /groups/1/edit
  def edit
    @mentees = @group.mentees + Person.where(role: 1).where(state: 3)
    @mentors = @group.mentors + Person.where(role: 2).where(state: 3)
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new
    @group.mentor_ids = params[:group][:mentor_ids]

    if @group.save
      redirect_to @group, notice: 'Group was successfully created.'
    else
      @mentors = Person.where(role: 2).where(state: 3)
      flash[:alert] = "You have to select a mentor."
      render :new
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    params[:group][:mentee_ids] ||= []
    params[:group][:mentor_ids] ||= []

    people_ids = params[:group][:mentee_ids] + params[:group][:mentor_ids]

    if @group.update(mentee_ids: people_ids)
      redirect_to @group, notice: 'Group was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:mentor_ids, :entee_ids)
    end

    def align_person_state
      Person.where("state = 5 OR state = 3").each { |p| p.save if p.align_group_state }
    end
end
