class Admins::TagsController < ApplicationController
  def index
    @tag = Tag.new
    @tags = Tag.page(params[:page]).per(10)
  end
  
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to admins_tags_path, notice: "新しいタグを追加しました。"
    else
      @tags = Tag.page(params[:page])
      flash.now[:alert] = "タグの追加に失敗しました。"
      render :index
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end
  
  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      redirect_to admins_tags_path, notice: "タグを更新しました。"
    else
      flash.now[:alert] = "タグの更新に失敗しました。"
      render :edit
    end
  end
  
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to admins_tags_path
  end
  
  private
  def tag_params
    params.require(:tag).permit(:tag_name, tag_ids: [])
  end
end
