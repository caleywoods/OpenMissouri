class CategoriesController < ApplicationController
  inherit_resources

  def index
    # change this to something like category.where("name like %?$", params[:q]) if
    # you want to filter on just categories matching what was typed.
    @categories = Category.all

    respond_to do |format|
      # .map(&:attributes) is removing the json root object.
      # this will perform better in 1.9.2 as it handles the Symbol#to_proc better.
      format.json { render :json => @categories.map(&:attributes), :only => %w[id name] }
    end
  end

  def show
    @categories = Category.published
    @category = Category.find(params[:id])
    @data_sets = @category.data_sets.paginate :page => params[:page], :conditions => {:status => "published"}, :order => 'data_sets.created_at desc', :per_page => 20

    show!
  end

  protected

  def collection
    @categories ||= end_of_association_chain.paginate(:page => params[:page])
  end
end
