class ViewsController < ApplicationController
  def index
    matching_views = View.all

    @list_of_views = matching_views.order({ :created_at => :desc })

    render({ :template => "views/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_views = View.where({ :id => the_id })

    @the_view = matching_views.at(0)

    render({ :template => "views/show.html.erb" })
  end

  def create
    the_view = View.new
    the_view.id_acquisition = params.fetch("query_id_acquisition")
    the_view.id_viewer = params.fetch("query_id_viewer")
    the_view.clicked = params.fetch("query_clicked", false)
    the_view.potential_lead = params.fetch("query_potential_lead", false)

    if the_view.valid?
      the_view.save
      redirect_to("/views", { :notice => "View created successfully." })
    else
      redirect_to("/views", { :notice => "View failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_view = View.where({ :id => the_id }).at(0)

    the_view.id_acquisition = params.fetch("query_id_acquisition")
    the_view.id_viewer = params.fetch("query_id_viewer")
    the_view.clicked = params.fetch("query_clicked", false)
    the_view.potential_lead = params.fetch("query_potential_lead", false)

    if the_view.valid?
      the_view.save
      redirect_to("/views/#{the_view.id}", { :notice => "View updated successfully."} )
    else
      redirect_to("/views/#{the_view.id}", { :alert => "View failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_view = View.where({ :id => the_id }).at(0)

    the_view.destroy

    redirect_to("/views", { :notice => "View deleted successfully."} )
  end
end
