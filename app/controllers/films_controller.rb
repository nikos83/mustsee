# frozen_string_literal: true

class FilmsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_film, only: %i[show edit update destroy]
  before_action :redirect_unauthorized_user, only: %i[new create edit update destroy]
  decorates_assigned :film

  def index
    @films = Film.all.decorate
  end

  def show
    @review = Review.new
  end

  def new
    @film = Film.new
    omdb_search
  end

  def edit
    omdb_search
  end

  def create
    @film = Film.new(film_params)

    respond_to do |format|
      if @film.save
        format.html { redirect_to @film, notice: 'Film was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @film.update(film_params)
        format.html { redirect_to @film, notice: 'Film was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @film.destroy
    respond_to do |format|
      format.html { redirect_to films_url, notice: 'Films was successfully destroyed.' }
    end
  end

  private

  def omdb_search
    return if params.values_at(:search, :year).include?(nil)

    @film_search = FilmDecorator.new(OmdbService.new(params[:search], params[:year]))
    insert_data_into_inputs
  end

  def insert_data_into_inputs
    @film.title = @film_search.title
    @film.description = @film_search.plot
  end

  def set_film
    @film = Film.friendly.find(params[:id])
  end

  def film_params
    params.require(:film).permit(:title, :description, :cover_img, :film_link)
  end
end
