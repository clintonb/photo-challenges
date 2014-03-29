class ChallengesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_challenge, only: [:show, :edit, :update, :destroy, :vote]

  # GET /challenges
  # GET /challenges.json
  def index
    @voted = current_user ? current_user.get_up_voted(Challenge).pluck(:id) : []
    @challenges = Challenge.all.includes(:user)
  end

  # GET /challenges/1
  # GET /challenges/1.json
  def show
  end

  # GET /challenges/new
  def new
    @challenge = Challenge.new
  end

  # GET /challenges/1/edit
  def edit
  end

  # POST /challenges
  # POST /challenges.json
  def create
    @challenge = Challenge.new(challenge_params)
    @challenge.user = current_user

    respond_to do |format|
      if @challenge.save
        format.html { redirect_to @challenge, notice: 'Challenge was successfully created.' }
        format.json { render action: 'show', status: :created, location: @challenge }
      else
        format.html { render action: 'new' }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /challenges/1
  # PATCH/PUT /challenges/1.json
  def update
    respond_to do |format|
      if @challenge.update(challenge_params)
        format.html { redirect_to @challenge, notice: 'Challenge was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /challenges/1
  # DELETE /challenges/1.json
  #def destroy
  #  @challenge.destroy
  #  respond_to do |format|
  #    format.html { redirect_to challenges_url }
  #    format.json { head :no_content }
  #  end
  #end

  def vote
    @challenge.liked_by current_user
    render json: {msg: @challenge.vote_registered? ? 'Vote registered' : 'Already voted'}
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_challenge
    @challenge = Challenge.includes(:user).find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def challenge_params
    params.require(:challenge).permit(:description)
  end
end
