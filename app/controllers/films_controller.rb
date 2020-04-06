# frozen_string_literal: true

class FilmsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_film, only: %i[show edit update destroy]
  before_action :redirect_unauthorized_user, only: %i[new create edit update destroy]
  decorates_assigned :film

  def index
    params[:genre].nil? ? @films = Film.all.decorate : set_films_by_genre
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

    @film_search = OmdbService.new(params[:search], params[:year]).search_result
    @film_search = OmdbDecorator.new(@film_search)
    insert_data_into_inputs
  end

  def insert_data_into_inputs
    @film.title = @film_search.parsed_response['Title']
    @film.description = @film_search.parsed_response['Plot']
    @film.genre = omdb_genre(@film_search.parsed_response['Genre']) unless @film_search.parsed_response['Genre'].nil?
  end

  def set_film
    @film = Film.friendly.find(params[:id])
  end

  def film_params
    params.require(:film).permit(:title, :description, :cover_img, :film_link, genre: [])
  end

  def omdb_genre(genre)
    if genre.include?(',')
      genre.delete(' ').split(',')
    else
      [genre]
    end
  end

  def sort_films
    @films = []
    Film.all.each do |film|
      (@films << film) if (film.genre & params[:genre]).sort == params[:genre].sort
    end
  end

  def set_films_by_genre
    if (Film::GENRES & params[:genre]).sort == params[:genre].sort
      sort_films
    else
      redirect_to films_url, notice: 'There isn\'t such genre.'
    end
  end
end
