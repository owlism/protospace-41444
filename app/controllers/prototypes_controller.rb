class PrototypesController < ApplicationController
  before_action :authenticate_user!,except: [:index,:show]
  before_action :move_to_index, except: [:index, :show,:new,:create]

  def index
    @prototypes=Prototype.all
  end
 
  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.create(prototypes_params)
    if @prototype.save
    redirect_to root_path
  else
    render :new, status: :unprocessable_entity
  end
  end

  def show
    @prototypes = Prototype.find(params[:id])
    #@prototypes = current_user.prototypes
    @comment = Comment.new
    @comments = @prototypes.comments.includes(:user)
  end

  def edit
    @prototype=Prototype.find(params[:id])
    @user=@prototype.user
    unless current_user == @user
      redirect_to root_path
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototypes_params)
    redirect_to prototype_path(@prototype)
  else
    render :edit, status: :unprocessable_entity
  end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end



  private

  def prototypes_params
    params.require(:prototype).permit(:title,:catch_copy,:concept,:image).merge(user_id:current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

end