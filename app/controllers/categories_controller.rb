class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]
  load_and_authorize_resource
  def index
    @categories = Category.all.where(author_id: current_user)
  end

  def new
    @category = Category.new
    # @expense.user = current_user
  end

  def show; end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html do
          redirect_to category_url(@category), notice: 'category was successfully created.'
        end
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @category.update(expense_params)
        format.html do
          redirect_to expense_url(@category), notice: 'Payment was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @new_category_path.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy

    respond_to do |format|
      format.html { redirect_to expense_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :icon).merge(author_id: current_user.id)
  end
end
