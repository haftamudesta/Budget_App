class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[show edit update destroy]
  def index
    @expenses = if params[:months]
                  Expense.all.where('extract(month from created_at)=?',
                                    Date: :MONTHNAMES.index(params[:month]), author_id: current_user)
                else
                  Expense.all.where(author_id: current_user)
                end
    @months = Date.today.all_year.map { |date| date.strftime('%B') }.uniq
    @expenses_by_month = @expenses.group_by { |expence| expence.created_at.strftime('%Y-%m') }
    @expenses_by_day = @expenses.order(created_at: :asc).group_by do |expence|
      expence.created_at.strftime('%A-%m-%B')
    end
  end

  def new
    @expense = Expense.new
    # @expense.user = current_user
  end

  def show; end

  def create
    @expense = Expense.new(expense_params)


    respond_to do |format|
      if @expense.save
        format.html { redirect_to expense_url(@expense), notice: 'expense was successfully created.' }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to expense_url(@expense), notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @new_expense_path.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to expense_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end




  private

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:name, :amount, category_ids: []).merge(author_id: current_user.id)
  end
end
