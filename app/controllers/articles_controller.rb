# encoding: utf-8

class ArticlesController < ApplicationController
add_breadcrumb "Главная", :root_path, :title => "Вернуться на главную"
add_breadcrumb "Блог", "/blog.html", :title => "Вернуться на главную"
  include ApplicationHelper

  def index
    profile_finish?

    @page_title = 'Блог'
    @page_description = 'Новости и статьи о btl и промомероприятиях. Аналитика и исследования в области промо.'
    @page_keywords    = 'промо, новости промоушинга, promo события, тенденции в области btl, рекламные новости'

    @articles = Article.order('created_at DESC').page(params[:page])

  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    profile_finish?

    @article = Article.friendly.find(params[:id])

    @page_title = @article.name

    add_breadcrumb @page_title

  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    profile_finish?

    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
    profile_finish?

    @article = Article.friendly.find(params[:id])
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = Article.friendly.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = Article.friendly.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end
end
