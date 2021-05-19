class ParticipationsController < ApplicationController
  before_action :set_participation, only: %i[ show edit update destroy ]
  require 'faker'
  # GET /participations or /participations.json
  def index
    @participations = Participation.all
  end

  # GET /participations/1 or /participations/1.json
  def show
  end

  # GET /participations/new
  def new
    @participation = Participation.new
  end

  # GET /participations/1/edit
  def edit
  end

  # POST /participations or /participations.json
  def create
    @participation = Participation.new
    @participation.update(user_id:User.find_by(email:current_user.email).id,event_id:params[:event_id],stripe_customer_id: Faker::Lorem.characters(number: 10))
    respond_to do |format|
      if @participation.save
        format.html { redirect_to '/events', notice: "Gossip was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
  

  # PATCH/PUT /participations/1 or /participations/1.json
  def update
    respond_to do |format|
      if @participation.update(participation_)
        format.html { redirect_to @participation, notice: "Participation was successfully updated." }
        format.json { render :show, status: :ok, location: @participation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participations/1 or /participations/1.json
  def destroy
    @participation.destroy
    respond_to do |format|
      format.html { redirect_to participations_url, notice: "Participation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participation
      @participation = Participation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def participation_
      params.require(:participation).permit(:event_id)
    end
end
