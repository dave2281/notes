class NotesController < ApplicationController
  before_action :set_user
  before_action :set_notes, only: [:index]
  before_action :set_note, only: [:edit, :update, :destroy]

  # GET /notes/new
  def new
    @note = @user.notes.build
  end

  # POST /notes or /notes.json
  def create
    @note = @user.notes.build(note_params)

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: "Заметка была успешно создана!" }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1 or /notes/1.json
  def update
    if @note.update(note_params)
      redirect_to home_index_path, notice: "Заметка успешно обновлена."
    else
      render :edit
    end
  end

  # DELETE /notes/1 or /notes/1.json
  def destroy
    @note.destroy
    redirect_to home_index_path, notice: 'Заметка успешно удалена.'
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = @user.notes.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to home_index_path, alert: 'Заметка не найдена.'
    end

    def set_notes
      @notes = @user.notes
    end

    def set_user
      @user = current_user
    end
    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:title, :text, :tags)
    end    
end
