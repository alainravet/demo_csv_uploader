class UsersController < ApplicationController

  before_filter :get_user, only: [:show, :edit, :update, :destroy]
  def get_user
    @user = User.find(params[:id])
  end

  before_filter :authorize_owner_or_admin_only, only: [:show, :edit, :update, :destroy]
  before_filter :authorize_admin_only, only: [:index]

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, :notice => "User #{@user.login} successfully signed up!" }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def reset_sample_data
    require 'rake'
    Rake::Task.clear                  # necessary to avoid tasks being loaded several times in dev mode
    SimpleBanking::Application.load_tasks
    Rake::Task['db:seed'].reenable    # in case you're going to invoke the same task second time.
    Rake::Task['db:seed'].invoke
    redirect_to root_path, notice: "Sample Data was reset with #{User.count} users : #{User.all.collect(&:login).join(', ')}"
  end


end
